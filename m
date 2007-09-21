Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CA0DDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 23:08:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IYiF6-0003Bj-KC
	for linuxppc-embedded@ozlabs.org; Fri, 21 Sep 2007 06:08:24 -0700
Message-ID: <12820276.post@talk.nabble.com>
Date: Fri, 21 Sep 2007 06:08:24 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6 and INITRAMFS in one file booting problem on ml403
In-Reply-To: <12796771.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12796771.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have sorted out partially my problem. The thing was that in the command
line which was passed from
u-boot to the kernel I have put root=/dev/ram what refers to the old
approach for the ramfs. In my case I use a new approach which does not need
the ram disk? (I guess and I have reduced it to 4 MB) and in the command
line I put somthing like: rdinit=/sbin/init.

When I have changed that all started somehow to work but unfortunately it
does not always work.
My observation is that I am able to boot linux kernel which contains
initramfs let say once per 2-3 tries.

I do not understand this behavior. I have tried many various things but I
came to the point that some times linux kernel boots properly or it does not
boot at all.

Below I enclose the output from the console:

U-Boot 1.2.0 (Sep 21 2007 - 14:26:11)


### No HW ID - assuming Avnet Virtex-4
DRAM:  32 MB
Top of RAM usable for U-Boot at: 02000000
Reserving 152k for U-Boot at: 01fd9000
Reserving 256k for malloc() at: 01f99000
Reserving 120 Bytes for Board Info at: 01f98f88
Reserving 48 Bytes for Global Data at: 01f98f58
Stack Pointer at: 01f98f38
New Stack Pointer is: 01f98f38
Now running in RAM - U-Boot at: 01fd9000
FLASH: flash detect cfi

## Booting image at 01300000 ...
   Image Name:   Linux-2.6.23-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    6983268 Bytes =  6.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01F986B8 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF7D
bd address  = 0x01F98F88
memstart    = 0x00000000
memsize     = 0x02000000
flashstart  = 0xFF000000
flashsize   = 0x00800000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x00000031
procfreq    =    100 MHz
plb_busfreq =    100 MHz
ethaddr     = 00:50:C2:46:D8:01
IP addr     = 129.129.144.82
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ... 

After that it hangs.
I have tried to see what is in the memory location under __log_buf
but it was not more than: kernel panic .. not syncing .. signal 4 ...

Does somody has a clue what could be wrong?

Best Regards

Mirek 


-- 
View this message in context: http://www.nabble.com/Kernel-2.6-and-INITRAMFS-in-one-file-booting-problem-on-ml403-tf4487411.html#a12820276
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
