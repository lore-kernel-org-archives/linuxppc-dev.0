To: Carl Lin <carl@fiberlogic.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem about running kernel with root fs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Mar 2001 22:11:32 +0800."
             <3AB61394.D9CD1DB3@fiberlogic.com>
Date: Mon, 19 Mar 2001 15:27:59 +0100
Message-Id: <20010319142804.E1A0B281DB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AB61394.D9CD1DB3@fiberlogic.com> Carl Lin wrote:
>
> I try to run Linux kernel 2.4.0-test13-pre2 (ramdisk size
> =4096KB and initrd supported) with a root fs (hello.rfs
> from BlueCat) on a board equivalent to TQM855L with the
> following configuration :
...
>   bootcmd=bootm 2800100

That's a strange address to start an image at...

...
> When I "mkimage" with a single kernel image by
>
> mkimage -A ppc -O linux -T kernel -C gzip -a 0 -e 0 \
> -n 'test' -d arch/ppc/coffboot/vmlinux.gz \
> /opt/tftpboot/vmlinux
>
> and download it to the board, it runs as following :
>
> Linux version 2.4.0-test13-pre2
> Boot arguments: root=/dev/ram
> ..................................
> Kernel command line: root=/dev/ram
> ..................................
> Memory: 14752k available (956k kernel code,........
> ..................................
> RAMDISK driver initialized: 16 RAM disks of 4096K size
> 1024 blocksize
> ...................................................
> VFS: Cannot open root device "ram" or 01:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 01:00

If you boot a plain kernel image with "bootm kernel_addr",  there  is
no ramdisk image passed to the kernel, so it cannot work.

If you want to boot a kernel at "kernel_addr" with a separate ramdisk
image at "ramdisk_addr" you have to use the command
"bootm kernel_addr ramdisk_addr".

> When I "mkimage" with the kernel and the root fs by
>
> mkimage -A ppc -O linux -T multi -C gzip -a 0 -e 0 \
> -n 'test' -d arch/ppc/coffboot/vmlinux.gz:hello.rfs \
> /opt/tftpboot/vmlinux
...
> ## Booting Linux kernel at 00100000 ...
>    Image Name:   test
>    Image Type:   PowerPC Linux Multi-File Image (gzip...
>    Data Size:    629184 Bytes = 614 kB = 0 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Contents:
>    Image 0:   516095 Bytes = 503 kB = 0 MB
>    Image 1:   113076 Bytes = 110 kB = 0 MB
>    Verifying Checksum ... OK
>    Uncompressing Multi-File Image ... OK
>    Loading Ramdisk to db0fc000 ...

Is that really the load address? 0xdb0fc000? That should not  happen.
You cannot have THAT much RAM on your board.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Copy from one, it's plagiarism; copy from two, it's research.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
