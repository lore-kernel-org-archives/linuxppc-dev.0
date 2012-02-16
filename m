Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EE7FB6EE6
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 04:13:33 +1100 (EST)
Message-ID: <4F3D3933.3020501@freescale.com>
Date: Thu, 16 Feb 2012 11:13:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v4 1/3] KVM: PPC: epapr: Factor out the epapr init
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, B07421@freescale.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2012 03:26 AM, Liu Yu wrote:
> from the kvm guest paravirt init code.
> 
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v4:
> 1. code cleanup
> 2. move kvm_hypercall_start() to epapr_hypercall_start()
> 
>  arch/powerpc/Kconfig                    |    4 ++
>  arch/powerpc/include/asm/epapr_hcalls.h |    2 +
>  arch/powerpc/kernel/Makefile            |    1 +
>  arch/powerpc/kernel/epapr.S             |   25 ++++++++++++++++
>  arch/powerpc/kernel/epapr_para.c        |   49 +++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/kvm.c               |   28 ++----------------
>  arch/powerpc/kernel/kvm_emul.S          |   10 ------
>  arch/powerpc/kvm/Kconfig                |    1 +
>  8 files changed, 85 insertions(+), 35 deletions(-)
>  create mode 100644 arch/powerpc/kernel/epapr.S
>  create mode 100644 arch/powerpc/kernel/epapr_para.c

The comment about spelling out "paravirt" wasnn't meant to be restricted
to the kconfig symbol.  There are lots of words that begin with "para",
and ePAPR isn't just about virtualization.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1919634..1262b43 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -202,6 +202,10 @@ config EPAPR_BOOT
>  	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
>  	default n
>  
> +config EPAPR_PARAVIRT
> +	bool
> +	default n

Why isn't this user-selectable?  It's useful on its own.

> diff --git a/arch/powerpc/kernel/epapr.S b/arch/powerpc/kernel/epapr.S
> new file mode 100644
> index 0000000..697b390
> --- /dev/null
> +++ b/arch/powerpc/kernel/epapr.S

epapr-hcall.S

> +bool epapr_para_enabled = false;
> +
> +static int __init epapr_para_init(void)
> +{
> +	struct device_node *hyper_node;
> +	const u32 *insts;
> +	int len, i;
> +
> +	hyper_node = of_find_node_by_path("/hypervisor");
> +	if (!hyper_node)
> +		return -ENODEV;
> +
> +	insts = of_get_property(hyper_node, "hcall-instructions", &len);
> +	if (!(len % 4) && (len >= (4 * 4))) {
> +		for (i = 0; i < (len / 4); i++)
> +			epapr_hypercall_start[i] = insts[i];
> +		flush_icache_range((ulong)epapr_hypercall_start,
> +		                   (ulong)epapr_hypercall_start + len);
> +
> +		epapr_para_enabled = true;
> +	}

Use patch_instruction(), fix the if test, and remove unnecessary
parentheses.  Print an error if the if test fails, but return silently
if the property is absent.

Please make asm/epapr_hcalls.h and asm/fsl_hcalls.h work with this as well.

-Scott
