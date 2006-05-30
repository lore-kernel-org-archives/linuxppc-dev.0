Return-Path: <Chetan.S.Anantharaman@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: execve of /sbin/init fails
Date: Tue, 30 May 2006 18:16:27 -0400
Message-ID: <EDF27F298D4B03498AE0C249A941DFF803D6DF@de01exm68.ds.mot.com>
In-Reply-To: <OF32D825BB.6DBF6685-ON8525717E.0072AF23@teal.com>
From: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
To: <Jeff.Fellin@rflelect.com>, "Steve Iribarne \(GMail\)" <netstv@gmail.com>,
	<adgospod@gmail.com>
Cc: linuxppc-embedded-bounces+jeff.fellin=rflelect.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for your reply. Yes, the file /sbin/init is in the ramdisk file
system with execute permissions on it. I am running Busybox (how can I
check the version?), but my /sbin/init is not Busybox's init.

One thing I'd like to mention is, I have used the same ramdisk
filesystem and the same version of Linux 2.4 kernel and U-Boot
bootloader and have been able to successfully execute the /sbin/init.
This board has a Xilinx Virtex 2 Pro FPGA with a PPC405. On my new
board, with a Xilinx Virtex 4 FX100 FPGA, with the kernel running on a
PPC405 and the same filesystem, the execve of /sbin/init "hangs". By
hangs, I mean there is no output on the console after the below output
and it does not return (which indicates that it has not encountered an
error of some sort, since execve returns on error only). So, I am not
sure where it is stuck and is there any way to tell where it's stuck at?

Hope this above info and below screen capture provide a bit more
background to the issue.


Below is a capture of the screen output:
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
OCP uart ver 1.6.2 init complete
LSP Revision 42
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq =3D 22) is a 16550A
xgpio #0 at 0x50000000 mapped to 0xC5000000
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Tracer: Initialization complete
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 5104k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 40k init



-----Original Message-----
From: Jeff.Fellin@rflelect.com [mailto:Jeff.Fellin@rflelect.com]=20
Sent: Tuesday, May 30, 2006 3:55 PM
To: Anantharaman Chetan-W16155
Cc: linuxppc-embedded@ozlabs.org;
linuxppc-embedded-bounces+jeff.fellin=3Drflelect.com@ozlabs.org
Subject: Re: execve of /sbin/init fails

=20

                      "Anantharaman Chetan-W16155"

                      <Chetan.S.Anantharaman@motorola.com>
To:       <linuxppc-embedded@ozlabs.org>                 =20
                      Sent by:
cc:                                                      =20
                      =
linuxppc-embedded-bounces+jeff.fellin=3Drflelect.com
Subject:  execve of /sbin/init fails                     =20
                      @ozlabs.org

=20

=20

                      05/30/2006 15:59

=20

=20










>Hi,
>I am trying to bring up a custom board with a PPC405 processor running
Linux 2.4.20 (MontaVista Release) and am >having problems with the call
to
execve("/sbin/init", argv_init, envp_init) not returning in the file
main.c. The processor >just hangs and there is no output on the
terminal. I
have tried to see if I can run "bin/sh" and even this execve call does
>not
return. Some things about the board are, the networking option has been
disabled in the Linux .config file. I am >running U-Boot 1.1.1 as the
bootloader and am downloading the uImage (compressed kernel) and the
initrd.boot >(filesystem) into RAM and accessing the filesystem in RAM.
 Chetan, I would check the contents of the initrd filesystem you created
to
verify the files are in the image. If they are monitor the console
output
to verfiy the ramdisk filesystem is found and installed into ram.
Jeff Fellin

>Any help as to what could be causing this to happen or how to debug
this
issue would be appreciated. Also, I've tried >to capture the return
value
of the execve call but since the call does not return, this has not
helped
any.

Thanks,
Chetan Anantharaman

 _______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
