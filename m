Date: Mon, 4 Jan 1999 19:41:15 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org, p1rabbit@halcyon.com
Subject: Re: 2.2.0pre2 SCSI problems, more (fwd)
Message-ID: <Pine.LNX.3.96LJ1.1b7.990104192040.452A-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


paul,

i removed all devices from the second bus except for an 80M quantum drive
that i used to boot from.  (everyone should be warned that you should boot
from a non-mesh device when mesh debugging is on! :) 

a strange thing, and maybe bad news for debugging: the drive is discovered
properly by the debugging kernel. maybe it's a timing issue. i hope the
logs can tell you something. 

the problem drive is on scsi id 1.

brad

AWACS: error, status = 40210f
...
scsi0 : MESH
scsi1 : 53C94
scsi : 2 hosts.
mesh_start: c2fbce00 ser=1 tgt=0 cmd= 0 0 0 0 0 0 use_sg=0 buffer=c2ffbd70 bufflen=256
mesh: sending 6 msg bytes: c0 1 3 1 32 f
got 5 message bytes: 1 3 1 32 f
mesh: target 0 synchronous at 5.0 MB/s
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=0, buflen=256
buffer = c2 ff bd 80 c0 20 5b a4
mesh_start: c2fbce00 ser=2 tgt=0 cmd= 12 0 0 0 ff 0 use_sg=0 buffer=c2ffbd70 bufflen=256
mesh: sending 1 msg bytes: c0
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=132, buflen=256
buffer = 0 0 2 2 7f 0 0 12
  Vendor: QUANTUM   Model: PD1225S           Rev: 3110
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
mesh: target 1 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
mesh: target 3 synchronous at 4.2 MB/s
  Vendor: SONY      Model: CD-ROM CDU-8005   Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
  Vendor: QUANTUM   Model: CTS80S            Rev: 4.2 
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 4, lun 0
scsi : detected 1 SCSI cdrom 3 SCSI disks total.
sr0: disc change detected.
Uniform CDROM driver Revision: 2.51
mesh_start: c2fbc600 ser=24 tgt=0 cmd= 0 0 0 0 0 0 use_sg=0 buffer=c2fb2000 bufflen=512
mesh: sending 1 msg bytes: c0
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=0, buflen=512
buffer = 0 0 0 0 0 0 0 0
mesh_start: c2fbc600 ser=25 tgt=0 cmd= 25 0 0 0 0 0 0 0 0 0 use_sg=0 buffer=c2fb2000 bufflen=8
mesh: sending 1 msg bytes: c0
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=8, buflen=8
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2395980 [1169 MB] [1.2 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2503872 [1222 MB] [1.2 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 166200 [81 MB] [0.1 GB]
eth0: MACE at 00:05:02:e0:03:4f
Partition check:
 sda:<4>mesh_start: c2fbc600 ser=30 tgt=0 cmd= 8 0 0 0 2 0 use_sg=1 buffer=c2fb2000 bufflen=1024
mesh: sending 1 msg bytes: c0
got 1 message bytes: 4
mesh: reselected by target 0
mesh: saved_ptr=0 goes_out=0 cmd=c2fbc600
got 1 message bytes: 80
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=1024, buflen=1024
mesh_start: c2fbc600 ser=31 tgt=0 cmd= 8 0 0 0 2 0 use_sg=1 buffer=c2fb2000 bufflen=1024
mesh: sending 1 msg bytes: c0
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=1024, buflen=1024
 sda1<4>mesh_start: c2fbc600 ser=32 tgt=0 cmd= 8 0 0 2 2 0 use_sg=1 buffer=c2fb2000 bufflen=1024
mesh: sending 1 msg bytes: c0
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=1024, buflen=1024
 sda2 sda3<4>mesh_start: c2fbc600 ser=33 tgt=0 cmd= 8 0 0 4 2 0 use_sg=1 buffer=c2fb2000 bufflen=1024
mesh: sending 1 msg bytes: c0
mesh: status is 0
got 1 message bytes: 0
mesh_done: result = 0, data_ptr=1024, buflen=1024
 sda4 sda5
 sdb: sdb1 sdb2 sdb3 sdb4
 sdc: sdc1 sdc2 sdc3 sdc4 sdc5
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 124k init 32k prep
NET4: AppleTalk 0.18 for Linux NET4.0


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
