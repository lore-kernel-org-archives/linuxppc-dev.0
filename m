Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmVyh1B8CzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 18:27:24 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 3D8CE440DB6_710A5E8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 08:27:20 +0000 (GMT)
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 CA38843E091_710A5E6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 08:27:18 +0000 (GMT)
Received: by mail-qg0-f42.google.com with SMTP id f52so77057835qga.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 01:27:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459950325-10327-1-git-send-email-alessio.bogani@elettra.eu>
References: <1459950325-10327-1-git-send-email-alessio.bogani@elettra.eu>
Date: Fri, 15 Apr 2016 10:27:17 +0200
Message-ID: <CAPk1OjHEe+qcPYakD0BbikSkK+Dipj-9P2vatSceTcjMWYAPYg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] powerpc/fsl: Fix build of the dtb embedded kernel
 images
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 6 April 2016 at 15:45, Alessio Igor Bogani <alessio.bogani@elettra.eu> wrote:
> The commit dc37374 move a lot of device tree files into fsl directory
> fixing Makefile for cuImage target only. Unfortunately there are others
> target which require to embebbed device tree into the kernel image
> (i.e. dtbImage.%). So use a more generic approach.
>
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
>  arch/powerpc/boot/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 6116510..8fe78a3 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -362,9 +362,6 @@ $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>  $(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>         $(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
>
> -$(obj)/cuImage.%: vmlinux $(obj)/fsl/%.dtb $(wrapperbits)
> -       $(call if_changed,wrap,cuboot-$*,,$(obj)/fsl/$*.dtb)
> -
>  $(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>         $(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
>
> @@ -381,6 +378,9 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>  $(obj)/%.dtb: $(src)/dts/%.dts FORCE
>         $(call if_changed_dep,dtc)
>
> +$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
> +       $(call if_changed_dep,dtc)
> +
>  # If there isn't a platform selected then just strip the vmlinux.
>  ifeq (,$(image-y))
>  image-y := vmlinux.strip

Any comments?

Ciao,
Alessio
