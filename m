Return-Path: <mgreer@mvista.com>
Date: Wed, 10 Jan 2007 17:40:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: jdl@jdl.com, jwboyer@jdub.homelinux.org, msm@freescale.com
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
Message-ID: <20070111004048.GA27351@mag.az.mvista.com>
References: <20061019002635.GA2356@mag.az.mvista.com>
	<E1GaYUQ-0001jb-20@jdl.com>
	<20061019195156.GB6586@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061019195156.GB6586@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2006 at 12:51:56PM -0700, Mark A. Greer wrote:
> On Thu, Oct 19, 2006 at 09:03:18AM -0500, Jon Loeliger wrote:
> > So, like, the other day "Mark A. Greer" mumbled:
> > > 
> > > This would be used by the sandpoint, say, by adding the following rules
> > > to the Makefile in the appropriate places:
> > > 
> > > 	$(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
> > > 		$(call cmd,wrap_dts,sandpoint)
> > > 
> > > 	$(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
> > > 		$(call cmd,wrap_dts_initrd,sandpoint)
> > > 
> > > and:
> > > 
> > > 	image-$(CONFIG_SANDPOINT)               += zImage.sandpoint
> > > 
> > > Comments?
> > 
> > Isn't there a way to do this without hardcoding the
> > platform name in the makefiles directly?  I fear for
> > the one-per-platform effect that is yet to come with
> > the conversion of many of the legacy boards.

Okay, its been a while so let's see if anyone remembers and/or cares
anymore.  :)

How about something like the patch below?

Basically, if you want a dtb wrapped up in your zImage, set
CONFIG_DEFAULT_DTB=y and also define CONFIG_DTS to point where your dts
file is.

Does that meet everyones requirements?

Mark
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 98392fb..848d1e4 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -118,6 +118,13 @@ quiet_cmd_wrap	= WRAP    $@
 quiet_cmd_wrap_initrd = WRAP    $@
       cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
+quiet_cmd_wrap_dts = WRAP_DTS    $@
+      cmd_wrap_dts =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-s $(CONFIG_DTS) vmlinux
+quiet_cmd_wrap_dts_initrd = WRAP_DTS    $@
+      cmd_wrap_dts_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 \
+				$(CROSSWRAP) -s $(CONFIG_DTS) \
+				-i $(obj)/ramdisk.image.gz vmlinux
 
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
 	$(call cmd,wrap,chrp)
@@ -155,6 +162,12 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
+$(obj)/zImage.dtb: vmlinux $(wrapperbits)
+	$(call cmd,wrap_dts,dtb)
+
+$(obj)/zImage.initrd.dtb: vmlinux $(wrapperbits)
+	$(call cmd,wrap_dts_initrd,dtb)
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
@@ -165,6 +178,7 @@ image-$(CONFIG_PPC_PS3)			+= zImage.ps3
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_DEFAULT_DTB)		+= zImage.dtb
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
