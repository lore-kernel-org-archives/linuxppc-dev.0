Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20021022144513.36073.qmail@web13401.mail.yahoo.com>
Date: Tue, 22 Oct 2002 07:45:13 -0700 (PDT)
From: Norm Legare <normlegare@yahoo.com>
Subject: Flash setup
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I would like to powerup my board and have Linux come up automatically
to the prompt.  To do this I would like to store ppcboot in partition
1, the kernel in partition 2, and the root fs in partition 3 and have
ppcboot transfer control to Linux through some environment settings.
I have searched the archives and found an email that seems to outline
this, it says, that the kernel config should have CONFIG_FLASH and
CONFIG_AMD_FLASH turned on, as well as, adding a definition to file
drivers/char/flash_config.c for my board (board = MBX860 and the
definition is the same as TQM8xx).  Then a dd command can write the
images to the partitions.  I have done this, but I get the following
problem:

/dev # dd if=/tmp/tmpfile of=/dev/flasha3 bs=64k
dd: /dev/flasha3: No such device

See below for the contents of my dev subdir.  Also, is it possible to
do a serial download of the images from a host to the flash with a
target root filesystem utilizing busybox?

TIA,
Norm


My dev subdir looks like this:
/dev # ls -all
drwxrwxr-x   2 root     root         3072 Oct 21  2002 .
drwxr-xr-x  12 root     root         1024 Oct 21  2002 ..
crw--w----   1 root     root       5,   1 Jan  2 01:18 console
lrwxrwxrwx   1 root     root            3 Oct 21  2002 fb -> fb0
crw-------   1 root     root      29,   0 Mar 24  2001 fb0
lrwxrwxrwx   1 root     root            7 Oct 21  2002
flash_environment -> flasha3
lrwxrwxrwx   1 root     root            7 Oct 21  2002 flash_kernel ->
flasha2
lrwxrwxrwx   1 root     root            7 Oct 21  2002 flash_monitor ->
flasha1
lrwxrwxrwx   1 root     root            7 Oct 21  2002 flash_reserved
-> flasha4
crw-r--r--   1 root     root      60,   0 Nov 14  2000 flasha
crw-r--r--   1 root     root      60,   1 Nov 14  2000 flasha1
crw-r--r--   1 root     root      60,   2 Nov 14  2000 flasha2
crw-r--r--   1 root     root      60,   3 Nov 14  2000 flasha3
crw-r--r--   1 root     root      60,   4 Nov 14  2000 flasha4
crw-r--r--   1 root     root      60,   5 Nov 14  2000 flasha5
crw-r--r--   1 root     root      60,   6 Nov 14  2000 flasha6
crw-r--r--   1 root     root      60,   7 Nov 14  2000 flasha7
crw-r--r--   1 root     root      60,   8 Nov 14  2000 flashb
crw-r--r--   1 root     root      60,   9 Nov 14  2000 flashb1
crw-r--r--   1 root     root      60,  10 Nov 14  2000 flashb2
crw-r--r--   1 root     root      60,  11 Nov 14  2000 flashb3
crw-r--r--   1 root     root      60,  12 Nov 14  2000 flashb4
crw-r--r--   1 root     root      60,  13 Nov 14  2000 flashb5
crw-r--r--   1 root     root      60,  14 Nov 14  2000 flashb6
crw-r--r--   1 root     root      60,  15 Nov 14  2000 flashb7
crw-r--r--   1 root     root       1,   7 Nov  2  2000 full
brw-rw----   1 root     root       3,   0 Mar 24  2001 hda
brw-rw----   1 root     root       3,   1 Mar 24  2001 hda1
brw-rw----   1 root     root       3,  10 Mar 24  2001 hda10
brw-rw----   1 root     root       3,  11 Mar 24  2001 hda11
brw-rw----   1 root     root       3,  12 Mar 24  2001 hda12
brw-rw----   1 root     root       3,  13 Mar 24  2001 hda13
brw-rw----   1 root     root       3,  14 Mar 24  2001 hda14
brw-rw----   1 root     root       3,  15 Mar 24  2001 hda15
brw-rw----   1 root     root       3,  16 Mar 24  2001 hda16
brw-rw----   1 root     root       3,   2 Mar 24  2001 hda2
brw-rw----   1 root     root       3,   3 Mar 24  2001 hda3
brw-rw----   1 root     root       3,   4 Mar 24  2001 hda4
brw-rw----   1 root     root       3,   5 Mar 24  2001 hda5
brw-rw----   1 root     root       3,   6 Mar 24  2001 hda6
brw-rw----   1 root     root       3,   7 Mar 24  2001 hda7
brw-rw----   1 root     root       3,   8 Mar 24  2001 hda8
brw-rw----   1 root     root       3,   9 Mar 24  2001 hda9
crw-r--r--   1 root     root      42,   2 Dec  7  2000 ivms_switch
crw-r-----   1 root     root       1,   2 Nov  2  2000 kmem
crw-r--r--   1 root     root      42,   1 Dec  7  2000 led_green
crw-r--r--   1 root     root      42,   0 Jul 30  2000 led_yellow
crw-r-----   1 root     root       1,   1 Nov  2  2000 mem
crw-rw-rw-   2 root     root       1,   3 Nov  2  2000 mouse
crw-rw-r--   1 root     root      90,   0 Jun  8  2001 mtd0
crw-rw-r--   1 root     root      90,   2 Jun  8  2001 mtd1
crw-rw-r--   1 root     root      90,  20 Jun  8  2001 mtd10
crw-rw-r--   1 root     root      90,  22 Jun  8  2001 mtd11
crw-rw-r--   1 root     root      90,  24 Jun  8  2001 mtd12
crw-rw-r--   1 root     root      90,  26 Jun  8  2001 mtd13
crw-rw-r--   1 root     root      90,  28 Jun  8  2001 mtd14
crw-rw-r--   1 root     root      90,  30 Jun  8  2001 mtd15
crw-rw-r--   1 root     root      90,  32 Jun  8  2001 mtd16
crw-rw-r--   1 root     root      90,   4 Jun  8  2001 mtd2
crw-rw-r--   1 root     root      90,   6 Jun  8  2001 mtd3
crw-rw-r--   1 root     root      90,   8 Jun  8  2001 mtd4
crw-rw-r--   1 root     root      90,  10 Jun  8  2001 mtd5
crw-rw-r--   1 root     root      90,  12 Jun  8  2001 mtd6
crw-rw-r--   1 root     root      90,  14 Jun  8  2001 mtd7
crw-rw-r--   1 root     root      90,  16 Jun  8  2001 mtd8
crw-rw-r--   1 root     root      90,  18 Jun  8  2001 mtd9
brw-rw-r--   1 root     root      31,   0 Jun  8  2001 mtdblock0
brw-rw-r--   1 root     root      31,   1 Jun  8  2001 mtdblock1
brw-rw-r--   1 root     root      31,  10 Jun  8  2001 mtdblock10
brw-rw-r--   1 root     root      31,  11 Jun  8  2001 mtdblock11
brw-rw-r--   1 root     root      31,  12 Jun  8  2001 mtdblock12
brw-rw-r--   1 root     root      31,  13 Jun  8  2001 mtdblock13
brw-rw-r--   1 root     root      31,  14 Jun  8  2001 mtdblock14
brw-rw-r--   1 root     root      31,  15 Jun  8  2001 mtdblock15
brw-rw-r--   1 root     root      31,  16 Jun  8  2001 mtdblock16
brw-rw-r--   1 root     root      31,   2 Jun  8  2001 mtdblock2
brw-rw-r--   1 root     root      31,   3 Jun  8  2001 mtdblock3
brw-rw-r--   1 root     root      31,   4 Jun  8  2001 mtdblock4
brw-rw-r--   1 root     root      31,   5 Jun  8  2001 mtdblock5
brw-rw-r--   1 root     root      31,   6 Jun  8  2001 mtdblock6
brw-rw-r--   1 root     root      31,   7 Jun  8  2001 mtdblock7
brw-rw-r--   1 root     root      31,   8 Jun  8  2001 mtdblock8
brw-rw-r--   1 root     root      31,   9 Jun  8  2001 mtdblock9
crw-rw-r--   1 root     root      90,   1 Jun  8  2001 mtdr0
crw-rw-r--   1 root     root      90,   3 Jun  8  2001 mtdr1
crw-rw-r--   1 root     root      90,  21 Jun  8  2001 mtdr10
crw-rw-r--   1 root     root      90,  23 Jun  8  2001 mtdr11
crw-rw-r--   1 root     root      90,  25 Jun  8  2001 mtdr12
crw-rw-r--   1 root     root      90,  27 Jun  8  2001 mtdr13
crw-rw-r--   1 root     root      90,  29 Jun  8  2001 mtdr14
crw-rw-r--   1 root     root      90,  31 Jun  8  2001 mtdr15
crw-rw-r--   1 root     root      90,  33 Jun  8  2001 mtdr16
crw-rw-r--   1 root     root      90,   5 Jun  8  2001 mtdr2
crw-rw-r--   1 root     root      90,   7 Jun  8  2001 mtdr3
crw-rw-r--   1 root     root      90,   9 Jun  8  2001 mtdr4
crw-rw-r--   1 root     root      90,  11 Jun  8  2001 mtdr5
crw-rw-r--   1 root     root      90,  13 Jun  8  2001 mtdr6
crw-rw-r--   1 root     root      90,  15 Jun  8  2001 mtdr7
crw-rw-r--   1 root     root      90,  17 Jun  8  2001 mtdr8
crw-rw-r--   1 root     root      90,  19 Jun  8  2001 mtdr9
crw-rw-rw-   2 root     root       1,   3 Nov  2  2000 null
crw-rw-rw-   1 root     root       2,   0 Nov  2  2000 ptyp0
crw-rw-rw-   1 root     root       2,   1 Nov  2  2000 ptyp1
crw-rw-rw-   1 root     root       2,   2 Nov  2  2000 ptyp2
crw-rw-rw-   1 root     root       2,   3 Nov  2  2000 ptyp3
crw-rw-rw-   1 root     root       2,   4 Nov  2  2000 ptyp4
crw-rw-rw-   1 root     root       2,   5 Nov  2  2000 ptyp5
crw-rw-rw-   1 root     root       2,   6 Nov  2  2000 ptyp6
crw-rw-rw-   1 root     root       2,   7 Nov  2  2000 ptyp7
brw-r-----   1 root     root       1,   1 Jan  1  1980 ram
brw-rw----   1 root     root       1,   0 Nov 10  1997 ram0
brw-rw----   1 root     root       1,   1 Sep 10  1996 ram1
crw-rw-rw-   1 root     root       5,   0 Nov  2  2000 tty
crw--w----   1 root     root       4,   0 May 11  2001 tty0
crw--w----   1 root     root       4,   1 Aug  8  2001 tty1
crw-------   1 root     root       4,   2 Jul 21  2001 tty2
crw-------   1 root     root       4,   3 Jul 21  2001 tty3
crw-rw----   1 root     root       4,  64 Nov  2  2000 ttyS0
crw-rw----   1 root     root       4,  65 Nov  2  2000 ttyS1
crw-rw----   1 root     root       4,  66 Nov  2  2000 ttyS2
crw-rw----   1 root     root       4,  67 Nov  2  2000 ttyS3
crw-rw----   1 root     root       4,  68 Mar 17  2002 ttyS4
crw-rw----   1 root     root       4,  69 Mar 17  2002 ttyS5
crw--w----   1 root     root       3,   0 Nov  2  2000 ttyp0
crw--w----   1 root     root       3,   1 Nov  2  2000 ttyp1
crw--w----   1 root     root       3,   2 Nov  2  2000 ttyp2
crw--w----   1 root     root       3,   3 Nov  2  2000 ttyp3
crw--w----   1 root     root       3,   4 Nov  2  2000 ttyp4
crw--w----   1 root     root       3,   5 Nov  2  2000 ttyp5
crw--w----   1 root     root       3,   6 Nov  2  2000 ttyp6
crw--w----   1 root     root       3,   7 Nov  2  2000 ttyp7
crw-rw-rw-   1 root     root       1,   5 Nov  2  2000 zero


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
