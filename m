Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED1EB679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 04:46:49 +1000 (EST)
In-Reply-To: <1154024834.29826.240.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <67FD272C-C378-4549-8B35-70912AFAB7EF@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][2/2] RTAS MSI
Date: Thu, 27 Jul 2006 20:46:42 +0200
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: 2.6-msi/drivers/pci/Makefile
> ===================================================================
> --- 2.6-msi.orig/drivers/pci/Makefile
> +++ 2.6-msi/drivers/pci/Makefile
> @@ -27,9 +27,12 @@ obj-$(CONFIG_PPC64) += setup-bus.o
>  obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
>  obj-$(CONFIG_X86_VISWS) += setup-irq.o
>
> -msiobj-y := msi.o msi-apic.o
> -msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
> -msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
> +msiobj-$(CONFIG_X86) += msi.o msi-apic.o
> +msiobj-$(CONFIG_IA64) += msi.o msi-apic.o

> +msiobj-$(CONFIG_IA64_GENERIC) += msi.o msi-apic.o msi-altix.o
> +msiobj-$(CONFIG_IA64_SGI_SN2) += msi.o msi-apic.o msi-altix.o

These two lines don't need the msi.o and msi-altix.o AFAICS.

> +msiobj-$(CONFIG_PPC_PSERIES) += msi-rtas.o

I think this file should live in arch/powerpc, and so should this
Makefile fragment.

> +
>  obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
>
>  #

Other than that, can we please have the part that doesn't build the
"generic" MSI stuff included ASAP?

> Index: 2.6-msi/drivers/pci/msi-rtas.c

Maybe msi-papr.c is a better name btw?  Not that I care :-)

No comments on your actual code, sorry.


Segher
