Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7708DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:40:47 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4F20iUk269708
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 12:00:45 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1iHO4028180
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:44:18 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1ekRL015406
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:40:46 +1000
Date: Tue, 15 May 2007 11:40:44 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: treeImage.initrd rule is very broken
Message-ID: <20070515014044.GE565@localhost.localdomain>
References: <1179154033.3420.13.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179154033.3420.13.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 09:47:13AM -0500, Josh Boyer wrote:
> Hi David,
> 
> I tried compiling an Ebony kernel wrapped with a DTS and initrd this
> morning but it fails with the following error:
> 
> WRAP    arch/powerpc/boot/treeImage.initrd.ebony
> DTC: dts->dtb  on file "/home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/ebony.dts"
> powerpc-440-linux-gnu-ld: arch/powerpc/boot/treeboot-initrd.ebony.o: No such file: No such file or directory
> powerpc-440-linux-gnu-nm: 'arch/powerpc/boot/treeImage.initrd.ebony': No such file
> powerpc-440-linux-gnu-objdump: 'arch/powerpc/boot/treeImage.initrd.ebony': No such file
> mv: cannot stat `arch/powerpc/boot/treeImage.initrd.ebony': No such file or directory
> stat: No such file or directory
> ln: accessing `arch/powerpc/boot/treeImage.initrd.ebony': No such file or directory
> make[1]: *** [arch/powerpc/boot/zImage.initrd] Error 1
> make: *** [zImage.initrd] Error 2
> 
> At first glance, it should be looking for treeboot-ebony.o, not
> treeboot-initrd.ebony.o.  On a whim, I symlinked treeboot-initrd.ebony.o
> to treeboot-ebony.o and the compile worked, however the wrapper wasn't
> called with the ramdisk.image.gz file:
> 
>  /bin/sh /home/jwboyer/src/linux-2.6/arch/powerpc/boot/wrapper -c -o arch/powerpc/boot/treeImage.initrd.ebony -p treeboot-initrd.ebony -C "powerpc-440-linux-gnu-"  -s /home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/ebony.dts vmlinux
> DTC: dts->dtb  on file "/home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/ebony.dts"
> 
> So something is very broken with this rule.  I poked at it for a while,
> but I apparently don't have the make-fu to figure out how to un-break
> it.
> 
> Help?

Bother.  I think the problem is that make is selecting the treeImage.%
rule (which does match), instead of the more specific
treeImage.initrd.%.  I think the very simple patch below, which just
reverses the order of the rules, might fix it.  Can you give it a
whirl?

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-15 11:39:18.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-15 11:39:27.000000000 +1000
@@ -204,12 +204,12 @@ dts = $(if $(shell echo $(CONFIG_DEVICE_
 $(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,$(dts))
 
-$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
-	$(call if_changed,wrap,treeboot-$*,$(dts))
-
 $(obj)/treeImage.initrd.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts),,$(obj)/ramdisk.image.gz)
 
+$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
+	$(call if_changed,wrap,treeboot-$*,$(dts))
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
