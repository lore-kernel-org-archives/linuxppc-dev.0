Message-ID: <39F5F96E.AAE39677@mvista.com>
Date: Tue, 24 Oct 2000 14:04:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
CC: Zhaobin Zhu <zzhu@emc.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: <kernel-image-name>
References: <Pine.GSO.4.21.0010231622560.25586-100000@stekt8>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Topi,

I don't know what you're nfs problems are.

initrd is broken.  In the 2.4.0-test kernel (and probably others), some
necessary lines were removed from arch/ppc/boot/head.S.  I believe they have
been added back in the more recent source.  Here is a patch:

--- /opt/hardhat/devkit/lsp/sp8240/linux-2.4.0-test2/arch/ppc/boot/head.S
Sat Nov 27 16:41:59 1999
+++ head.S      Tue Oct 24 13:44:56 2000
@@ -112,6 +112,14 @@
        cmpi    0,r2,0
        bne     00b

+       /* r4,r5 have initrd_start, size */
+       lis     r2,initrd_start@h
+       ori     r2,r2,initrd_start@l
+       lwz     r4,0(r2)
+       lis     r2,initrd_end@h
+       ori     r2,r2,initrd_end@l
+       lwz     r5,0(r2)
+
        /* tell kernel we're prep */
        /*
         * get start address of kernel code which is stored as a coff



Also, the sandpoint_setup_arch() routine in arch/ppc/kernel/sandpoint_setup.c
needs to be fixed.  Change the SCSI_CDROM_MAJOR to RAMDISK_MAJOR.

These hacks should get your ramdisk going...

Mark
--


> Linux/PPC load: root=/dev/ram
>
> Any ideas what I'm doing wrong here? I've been up all day so when you're
> really tired, there's something really stupid I'm forgetting right now...
>
> I don't know why, but I seem to be the only one that cannot even make the
> damn stupid sandpoint to boot at *all*. Maybe I should get a job cleaning
> toilets instead...
>
> -topi

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
