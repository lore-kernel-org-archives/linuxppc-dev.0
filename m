Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id E0BB1DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 16:35:13 +1000 (EST)
Message-ID: <48C76AFF.6090205@coritel.it>
Date: Wed, 10 Sep 2008 08:36:47 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Dave Littell <littelld@verizon.net>
Subject: Re: initramfs too large?
References: <48C719BB.1050807@verizon.net>
In-Reply-To: <48C719BB.1050807@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dave,

if I well understood you've done a "manual" operation very ugly. You can 
adjust the default settings in the kernel menu under device 
drivers/block devices and set the number of ramdisk device and the 
default size. You can use even the kernel command line option 
"ramdisk_size" to tell to the kernel the size of the ramdisk size you 
are using.

Regards.


Dave Littell ha scritto:
> Hi all,
>
> I believe my initramfs has grown beyond some limit, but I'm at a loss to
> know how to correct it.  We recognized that we would have to allow a
> larger initramfs than the defaults provided, so I modified the following
> (on a 2.6.18 kernel):
>
> 1. .../arch/powerpc/boot/wrapper: A "-Ttext=0x1000000" was added to the
> ld args.
>
> 2. .../arch/powerpc/boot/zImage.lds.S: The ALIGN() directive was changed
>  to use 16 instead of 4.
>
> I thought I was finished and everything seemed to be working well with
> an initramfs CPIO archive size of approx. 9 MB.  However, we just had
> another size increase (to a CPIO archive size of approx. 12 MB) and now
> I'm rewarded with this at boot:
>
> ## Booting image at 08000000 ...
>    Image Name:   Linux-2.6.18_pro500-440epx_eval
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    7113720 Bytes =  6.8 MB
>    Load Address: 01000000
>    Entry Point:  01000410
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> CPU clock-frequency <- 0x27bc86ae (667MHz)
> CPU timebase-frequency <- 0x27bc86ae (667MHz)
> /plb: clock-frequency <- 9ef21ab (167MHz)
> /plb/opb: clock-frequency <- 4f790d5 (83MHz)
> /plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
> /plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
> Memory <- <0x0 0x0 0x10000000> (256MB)
> ENET0: local-mac-address <- 00:80:3f:0d:80:0d
> ENET1: local-mac-address <- 79:60:04:ea:d9:a1
>
> zImage starting: loaded at 0x01000000 (sp: 0x0ff182e8)
> Allocating 0x904dc0 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0100d000:0x01912c90)...done 0x8de100 bytes
>
> Linux/PowerPC load: console=ttyS0,115200 console=ttyMTD3
> Finalizing device tree... flat tree at 0x191f3a0
>
> Here it sits, forever.  I poked around a bit with the JTAG and found (in
> one instance) that probe_machine() (from setup_common.c) was taking a
> DataTLBError exception because it appears the machine descriptors are
> scrubbed to 0.  I added some debug code to setup_common.c, but on the
> next attempted boot the JTAG showed that DataTLBError exceptions in
> identify_cpu() (cputable.c).
>
> If I reduce the size of initramfs back to it's original size the system
> runs just fine.  So, I'm guessing the larger initramfs is somehow
> stomping on something, but have no idea how to proceed to resolve this.
>
>
> Thanks very much,
> Dave
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
