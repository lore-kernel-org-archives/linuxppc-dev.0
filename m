Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: C.Gillan@ecit.qub.ac.uk
Message-ID: <34753.143.117.36.139.1088161982.squirrel@143.117.36.139>
Date: Fri, 25 Jun 2004 12:13:02 +0100 (BST)
Subject: PPCBoot question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been using PPCBoot/Das U-Boot to boot an MPC860 based
evaluation board in which the Kernel and an (initrd) file
system are loaded at defined addresses in Flash.

The Flash system has been partitioned (in the kernel) using
MTD so that there is a partition holding the initrd filesystem.

I would like to to be able to build only one binary file
to be used for download to the target, rather than have to
download the kernel and filesystem separately. But, I'm not sure if
this is possible and if it is, how to set up the bootm command
to work with this. Perhaps, I've missed something in the documentation.

As I understand it, the mkimage utility that comes with the PPCBoot/Das
U-Boot bootloader software can build a combined image containing both
the kernel and the file system - following is from the PPCBoot documentation:

 -> tools/mkimage -n '2.2.13 for initrd on TQM850L' \
        > -A ppc -O linux -T kernel -C gzip -a 00000000 -e 0000000C \
        > -d /opt/mpc8xx/src/linux-2.2.13/arch/ppc/coffboot/vmlinux.gz \
        > examples/image-2.2.13-initrd
        Image Name:   2.2.13 for initrd on TQM850L
        Created:      Wed Jul 19 02:34:59 2000
        Image Type:   PowerPC Linux Kernel Image (gzip compressed)
        Data Size:    335725 Bytes = 327.86 kB = 0.32 MB
        Load Address: 0x00000000
        Entry Point:  0x0000000c

My confusion arises from the fact that I don't see a way of
specifying the address to which the file system will be downloaded,
whenever it is inside this single binary file.
As I understand it, I need to specify that address as the second
argument on the bootm command, e.g.

    bootm <kernel-address> <file-system-address>


I'd be grateful for any help received.

Thanks,

Charles Gillan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
