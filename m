Return-Path: <ivan@vmfacility.fr>
From: "Ivan Warren" <ivan@vmfacility.fr>
To: <linuxppc-dev@ozlabs.com>
Date: Sat, 13 Nov 2004 23:03:46 +0100
Message-ID: <IOEOJNOGAAKFBLIMGDCJAEJMCAAA.ivan@vmfacility.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Issue with ppc64/vibmscsi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

I am running into the following problem :

I have started experimenting running linux ppc64 on a newly acquired IBM
9111-520 (p520).

I am attempting to run a linux kernel (2.6.9) in a partition. All the
devices are virtual.

I (shamelessly) used the debian ppc d-i installer... It wouldn't complete,
but went far enough to have a usable root filesystem. So I installed yaboot,
did the ybin, etc.. so I could boot from the disk..

The kernel is cross compiled (on a ia32 system)...

Now.. My problem starts when I attempt to do some heavy I/O operations..
(namely debian's apt-get something which I believe to do heavy I/O using
db)..

At this point, I start getting heavy I/O errors - to a point where the root
fs is remounted read-only.. The virt scsi client adapter is then made
disabled (all further I/O fail).

the virtual I/O server shows this :
<ERRLOG>
LABEL:          CLIENT_FAILURE
IDENTIFIER:     37DDE80C

Date/Time:       Sat Nov 13 13:07:51 CST 2004
Sequence Number: 54
Machine Id:      00C1721E4C00
Node Id:         vios1
Class:           S
Type:            TEMP
Resource Name:   vhost3

Description
Misbehaved Virtual SCSI Client

Probable Causes
Bad IU, or SRP Violation

Failure Causes
Bad IU, or SRP Violation

        Recommended Actions
        Remove Virtual SCSI Client, then Configure the same instance

Detail Data
                  Module     RC   Location   Data
srp_parse_descriptor_lis 0000000000000002 00000006 C00000000126B3C0 2E000
</ERRLOG>

And the console shows :

ibmvscsi: Virtual adapter failed!
SCSI error : <0 0 1 0> return code = 0x70000
end_request: I/O error, dev sda, sector 13438632
SCSI error : <0 0 1 0> return code = 0x70000
end_request: I/O error, dev sda, sector 13438640
SCSI error : <0 0 1 0> return code = 0x70000
.. ad libidum ...

I added a few printk to the srp/rdma driver and I get this :
(notes in () are hand edited comments)
<LOG>
(Note : This is the srp_event_struct iu field dump)
Sending IU : 02000000 00010000 00000000 00000000
 00000000 81000000 00000000 00000000
 280000CD 0EA00000 08000000 00000000
 00000000 02050000 00000000 00001000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
(note : this is the CRQ request for the above SRP block)
rpa_scsi : CRQ_SEND : CRQ = 8001000000000100 - 4300
(failing SRP)
Sending IU : 02000000 00020002 00000000 00000000
 00000000 81000000 00000000 00000000
 280000CD 0EA80001 70000000 00000000
 00000000 00004444 00000000 00000020
 0002E000 00000000 02052000 00000000
 0000E000 00000000 0C000000 00000000
 00020000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000
(failing CRQ)
rpa_scsi : CRQ_SEND : CRQ = 8001000000000100 - 4400
ibmvscsi: Virtual adapter failed!
SCSI error : <0 0 1 0> return code = 0x70000
end_request: I/O error, dev sda, sector 13438632
...
</LOG>

Basically, I cannot see anything wrong with the last failing request... (SRP
Request type 02 : SRP_TYPE_CMD, data in format 2 (indirect) - 2 data in
descriptors) - and some of the CDB fields I recognize : SCSI Command code 28
and LBA CD0EA8 (which matches sector 13438632 indicated afterwards..).. The
rest is way to obscure for me..

This problem is *almost* always reproducible (~90% of the time - occurs when
attempting the same operation).. I attempted deleting/recreating the virtual
device, changed the size, to no avail..

Question :

- Is this *really* a misbehaving client - or - a buggy server (VIOS at
1.1.20, p520 FW at SF220_51)?
- In the latter case, how do I report this to IBM (knowing roll-your-own
kernels are probably not supported)..
- If this is a misbehaving client, When extra information is needed (knowing
that my SRP, SCSI, VSCSI knowledge is somewhat limited) ?

Thanks,

--Ivan
