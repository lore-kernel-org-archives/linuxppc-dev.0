Return-Path: <mgreer@mvista.com>
Date: Tue, 20 Mar 2007 10:41:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/7] boot: use a common zImage rule
Message-ID: <20070320174110.GA11009@mag.az.mvista.com>
References: <boot-00.miltonm@bga.com> <boot-01.miltonm@bga.com>
	<20070320033039.GA21124@localhost.localdomain>
	<f7b20d0a2660652ca1ddbb69eb41feb5@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7b20d0a2660652ca1ddbb69eb41feb5@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 08:47:20AM -0500, Milton Miller wrote:
> 
> On Mar 19, 2007, at 10:30 PM, David Gibson wrote:
> 
> > On Mon, Mar 19, 2007 at 02:58:07PM -0600, Milton Miller wrote:
> >> Before the plethora of platforms gets any worse, establish a common
> >> rule to invoke the wrapper for any platform.  Add arguments to
> >> the rule for initrd, dts, dtb, etc.   Show example usage with initrd.
> >
> > The problem with this patch is that while the wrap command can take a
> > dts or dtb, there's no way to specify which should be used with each
> > target.
> 
> I thought a bit about that before I posted, but didn't write anything.
> We could add standard varable names dts-$(platform) dtb-$(platform),
> since make would default such names as unset.
> 
> But this does raise the point, instead of listing the image names, 
> should
> we be seelcting the platforms and generating the image names with the
> expansion.   That would save us stripping of zImage to get the platform
> name in the rule.
> 
> I'll try to test this later.
> 
> Should I respin patch 3, add FORCE, without this so we can merge that
> first?   I put this one first so there would be less adding rules that
> would be removed later, but the other is really a bugfix and this is
> a cleanup.

FYI, I made the patch below so I could build a zImage with a dts.  I also
added the rule:

	image-$(CONFIG_PPC_PRPMC2800)		+= zImage.dts.prpmc2800

to build a zImage.dts.prpmc2800 that contained a dts.

Mark
---

Index: powerpc/arch/powerpc/boot/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/boot/Makefile
+++ powerpc/arch/powerpc/boot/Makefile
@@ -153,6 +153,10 @@ $(addprefix $(obj)/,$(filter-out uImage 
                $(obj)/zImage.%: vmlinux $(wrapperbits)
        $(call if_changed,wrap,$(patsubst $(obj)/zImage.%,%,$@))
 
+$(addprefix $(obj)/,$(filter-out uImage zImage.ps3,$(image-y))): \
+               $(obj)/zImage.dts.%: vmlinux $(wrapperbits)
+       $(call if_changed,wrap,$(patsubst $(obj)/zImage.dts.%,%,$@),$(src)/dts/$(CONFIG_DEVICE_TREE))
+
 $(addprefix $(obj)/,$(filter-out uImage
zImage.initrd.ps3,$(initrd-y))): \
                $(obj)/zImage.initrd.%: vmlinux $(wrapperbits) \
                $(obj)/ramdisk.image.gz
