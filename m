Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qnZ4S1t7szDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 11:51:04 +1000 (AEST)
Message-ID: <1460857857.32510.176.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sat, 16 Apr 2016 20:50:57 -0500
In-Reply-To: <CAPk1OjHEe+qcPYakD0BbikSkK+Dipj-9P2vatSceTcjMWYAPYg@mail.gmail.com>
References: <1459950325-10327-1-git-send-email-alessio.bogani@elettra.eu>
 <CAPk1OjHEe+qcPYakD0BbikSkK+Dipj-9P2vatSceTcjMWYAPYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/fsl: Fix build of the dtb embedded
 kernel images
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-15 at 10:27 +0200, Alessio Igor Bogani wrote:
> Hi,
> 
> On 6 April 2016 at 15:45, Alessio Igor Bogani <alessio.bogani@elettra.eu>
> wrote:
> > The commit dc37374 move a lot of device tree files into fsl directory
> > fixing Makefile for cuImage target only. Unfortunately there are others
> > target which require to embebbed device tree into the kernel image
> > (i.e. dtbImage.%). So use a more generic approach.
> > 
> > Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> > ---
> >  arch/powerpc/boot/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index 6116510..8fe78a3 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -362,9 +362,6 @@ $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb
> > $(wrapperbits)
> >  $(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> >         $(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
> > 
> > -$(obj)/cuImage.%: vmlinux $(obj)/fsl/%.dtb $(wrapperbits)
> > -       $(call if_changed,wrap,cuboot-$*,,$(obj)/fsl/$*.dtb)
> > -
> >  $(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> >         $(call if_changed,wrap,simpleboot
> > -$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
> > 
> > @@ -381,6 +378,9 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb
> > $(wrapperbits)
> >  $(obj)/%.dtb: $(src)/dts/%.dts FORCE
> >         $(call if_changed_dep,dtc)
> > 
> > +$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
> > +       $(call if_changed_dep,dtc)
> > +
> >  # If there isn't a platform selected then just strip the vmlinux.
> >  ifeq (,$(image-y))
> >  image-y := vmlinux.strip
> 
> Any comments?

Looks OK to me.

-Scott
