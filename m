Date: Sat, 21 Sep 2002 20:26:31 -0700
From: curt brune <curt@acm.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: initrd, ramdisk problems
Message-ID: <20020922032631.GA30804@lenin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm booting linux 2.4.18 on an embedded planet RPX_LITE-DW (823e) with
a RAM disk, however I am getting a "crc" error while decompressing the
RAM disk.  Snipped from the boot log are these two lines:

>> RAMDISK: Compressed image found at block 0
>> crc errorFreeing initrd memory: 1670k freed

I built the kernel image using "gmake zImage.initrd" .  This picked up
my gzipped ramdisk image OK.

[editor: I know, I know.  I should be using ppcboot.]

The ramdisk is 8192 bytes uncompressed.  Compressed it is 1.7MB.

The target kernel is configured for 8192 byte ramdisks also.  This is
stumping me.

In the boot log I also noticed something funny.  My board only has
16MB total on it and the kernel is configured for 8MB ramdisk.  In the
boot log it says it is initializing 16 ramdisks of 8MB each ....

>> Kernel command line: root=/dev/ram ramdisk=8192
>> Memory: 13104k available (916k kernel code, 348k data, 52k init, 0k
>> highmem)
>> ...
>> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

Looking in rd.c I see 16 is a #define constant.  Is this a problem?

Cheers,
Curt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
