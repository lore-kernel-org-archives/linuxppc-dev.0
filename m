Date: Mon, 9 Sep 2002 15:16:24 -0400 (EDT)
From: Tony Howard <tahoward@ntrnet.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: cdrecord, cdrdao failing with scsi bus reset
In-Reply-To: <6DF87017DA95D611AC6000606730DE9B0BD7BE@BLREXSR>
Message-ID: <Pine.LNX.4.33.0209091514360.1320-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


List,

I am having a problem with my cd recorder, and I was hoping someone could
help.  I have copied an audio CD to my HD using cdda2wav, but trying to
write with cdrecord causes a SCSI bus reset.  cdrdao fails with a different message,
but I get an identical scsi bus reset according to the kernel logs.  After
the reset, I can't access the CD drive until I reboot.  Relevant info:

Apple Performa 6400
Built in SCSI (Mesh)
Linux 2.4.20-pre5
cdrecord 1.10
cdrdao 1.1.6
Drive: Sanyo CRD-R880S, aka Smart & Friendly CD Rocket 8020

Here is what's on my scsi bus:
[root@ranger root]# cdrecord -scanbus
Cdrecord 1.10 (powerpc-unknown-linux-gnu) Copyright (C) 1995-2001 Jörg
Schilling
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.5'
scsibus0:
        0,0,0     0) *
        0,1,0     1) *
        0,2,0     2) 'GENERIC ' 'CD-R CRD-R800S ' '1.23' Removable CD-ROM
        0,3,0     3) 'MATSHITA' 'CD-ROM CR-8008  ' '8.0h' Removable CD-ROM
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *


Here is the output from cdrecord:
[root@ranger cd]# cdrecord -v dev=0,2,0 -dummy -dao -useinfo *.wav
pregap1: -1
Cdrecord 1.10 (powerpc-unknown-linux-gnu) Copyright (C) 1995-2001 Jörg
Schilling
TOC Type: 0 = CD-DA
scsidev: '0,2,0'
scsibus: 0 target: 2 lun: 0
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.5'
atapi: 0
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : SYNC LINKED
Vendor_info    : 'GENERIC '
Identifikation : 'CD-R CRD-R800S '
Revision       : '1.23'
Device seems to be: Generic mmc CD-R.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 1843200 = 1800 KB
FIFO size      : 4194304 = 4096 KB
Track 01: audio  41 MB (04:06.22) no preemp
Track 02: audio  50 MB (05:02.50) no preemp
Track 03: audio  38 MB (03:51.80) no preemp
Track 04: audio  33 MB (03:19.13) no preemp
Track 05: audio  66 MB (06:33.40) no preemp
Track 06: audio  33 MB (03:21.56) no preemp
Track 07: audio  51 MB (05:09.04) no preemp
Track 08: audio  61 MB (06:04.82) no preemp
Track 09: audio  42 MB (04:14.44) no preemp
Track 10: audio  66 MB (06:34.09) no preemp
Track 11: audio  49 MB (04:53.84) no preemp
Track 12: audio  40 MB (04:00.16) no preemp
Track 13: audio  75 MB (07:29.33) no preemp
Track 14: audio  47 MB (04:39.70) no preemp
Track 15: audio  47 MB (04:44.96) no preemp
Total size:     747 MB (74:05.02) = 333377 sectors
Lout start:     748 MB (74:07/02) = 333377 sectors
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl


I get the following lines in my kernel log:
mesh_abort(c8757e00)
mesh: state at c8772e78, regs at ca18a000, dma at ca18c000
    ct=   0 seq= 9 bs=   0 fc= 0 exc= 0 err= 0 im= 7 int= 0 sp=80
    dma stat=e0 cmdptr=875c010
    phase=0 msgphase=0 conn_tgt=2 data_ptr=0
    dma_st=0 dma_ct=0 n_msgout=0
    target 2: req=c8757e00 goes_out=0 saved_ptr=0
mesh_abort(c8757c00)
mesh: state at c8772e78, regs at ca18a000, dma at ca18c000
    ct=   0 seq= 9 bs=   0 fc= 0 exc= 0 err= 0 im= 7 int= 0 sp=80
    dma stat=e0 cmdptr=875c010
    phase=0 msgphase=0 conn_tgt=2 data_ptr=0
    dma_st=0 dma_ct=0 n_msgout=0
    target 2: req=c8757e00 goes_out=0 saved_ptr=0
mesh_host_reset
mesh: target 2 synchronous at 10.0 MB/s
scsi: device set offline - not ready or command retry failed after host
reset: host 0 channel 0 id 2 lun 0
mesh: target 3 synchronous at 10.0 MB/s

Does anybody have any suggestions?  I don't think its termination issues -
I just have the built in CD and the external burner, and it has a
termination switch which is set to on.

Tony


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
