Date: Mon, 18 Jan 1999 13:29:38 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Daniel Jacobowitz <drow@false.org>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
In-Reply-To: <19990117152914.A12471@drow.res.cmu.edu>
Message-ID: <Pine.LNX.3.95.990118132148.32489A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

the author of cdrecord suggests we look at:

Disabled disconnect/reconnect on the SCSI bus
A bug in the scheduler or pager in the kernel.

full message is below.

brad

From: Joerg Schilling <schilling@fokus.gmd.de>

>From brad@pht.com Sun Jan 17 03:47:57 1999

>i use cdrecord on linux on both pc and ppc. the recent ppc kernels have a
>problem and i hope you can offer insight so i can locate and hopefully fix
>the problem in the kernel. 

>i can use v1.6 on pc (kernel 2.0.35) without problems; but on the ppc,
>v1.6, which used to work on v2.1.24, now dies consistently after writing
>less than 10M using v2.2.0pre5. i've tried the current version of cdrecord
>with the same result: 

>Executing 'write_g1' command on Bus 1 Target 4, Lun 0 timeout 40s
>CDB:  2A 00 00 00 27 00 00 00 10 00
>cdrecord: I/O error. write_g1: scsi sendcmd: retryable error
>CDB:  2A 00 00 00 27 00 00 00 10 00
>status: 0x2 (CHECK CONDITION)
>Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 10 02 00 00
>Sense Key: 0x5 Illegal Request, Segment 0
>Sense Code: 0x10 Qual 0x02 (id crc or ecc error) [No matching qualifier]
>Fru 0x0

>this is a ricoh connected to the ppc's 53C94 bus.

>the complete -v -v -V log is at http://pht.com/~brad/cdrecord/ but it's
>too long to include here. 


As the Sense Key 0x5 (illegal request is illegal in combination
with sense code 0x10, I would guess that this is a buffer underrun.
A buffer underrun usually ends up in an illegal request key as the
next write operation after the underrun will use an illegal
sector address from the point of view of the drive.

Now lets discussw why a buffer underrun may occur:

1)	Disabled disconnect/reconnect on the SCSI bus

2)	Incorrect termination on the SCSI bus

3)	A bug in the scheduler or pager in the kernel.

>ps it might be worth mention in the docs: a suggestion with regard to
>shmmax settings and cdrecord. it appears that the shmmax value can be
>changed at runtime from the default < 4M to a value more optimal for
>cdrecord:

>echo 6000000 >/proc/sys/kernel/shmmax


Interesting, it is not included 2.1.118 for Intel.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix

--------

I don't have the exact messages, but attempting to use an external CDR
(boot drive on MESH, burner on 53c94) locks up with a bunch of illegal
sense requests.  Then it tries to reset the external bus, times out,
claims to try harder, and more or less locks up.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
