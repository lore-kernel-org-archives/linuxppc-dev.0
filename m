Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C2AB32C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 03:29:26 +1000 (EST)
Message-ID: <502BDC6B.4090800@freescale.com>
Date: Wed, 15 Aug 2012 12:29:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V7 1/3] powerpc/pci: Make sure ISA IO base is not zero
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1345021026-10886-2-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2012 03:57 AM, Jia Hongtao wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Some platforms like QEMU treat 0 as an invalid address for ISA IO base.
> So we make sure that ISA IO base will never be zero. By functionality this
> is equivalent to assgin the first pci bus detected as a primary bus.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>

When did Ben post this?

Suggesting a temporary workaround in an e-mail is *not* the same as
posting a patch, and definitely not the same as providing a
signed-off-by which AFAICT you forged.  Don't do that.

> ---
>  arch/powerpc/kernel/pci-common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 0f75bd5..2a09aa5 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -734,7 +734,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
>  			hose->io_base_virt = ioremap(cpu_addr, size);
>  
>  			/* Expect trouble if pci_addr is not 0 */
> -			if (primary)
> +			if (primary || !isa_io_base)
>  				isa_io_base =
>  					(unsigned long)hose->io_base_virt;
>  #endif /* CONFIG_PPC32 */
> 

Didn't I already point out that this has problems when the primary bus
is not the first to be probed?  If your answer is that you fix that in a
later patch, that breaks bisectability.

-Scott
