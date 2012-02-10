Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62A4CB6F98
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Feb 2012 05:40:10 +1100 (EST)
Message-ID: <4F356477.7010809@freescale.com>
Date: Fri, 10 Feb 2012 12:39:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v3 1/3] KVM: PPC: epapr: Factor out the epapr init
References: <1328868141-17364-1-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1328868141-17364-1-git-send-email-yu.liu@freescale.com>
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

On 02/10/2012 04:02 AM, Liu Yu wrote:
> from the kvm guest paravirt init code.
> 
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v3:
> apply the epapr init for all ppc platform
> 
>  arch/powerpc/Kconfig                    |    4 +++
>  arch/powerpc/include/asm/epapr_hcalls.h |    8 +++++
>  arch/powerpc/kernel/Makefile            |    1 +
>  arch/powerpc/kernel/epapr_para.c        |   46 +++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/kvm.c               |   13 +++------
>  arch/powerpc/kvm/Kconfig                |    1 +
>  6 files changed, 64 insertions(+), 9 deletions(-)
>  create mode 100644 arch/powerpc/kernel/epapr_para.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 47682b6..00bd508 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -196,6 +196,10 @@ config EPAPR_BOOT
>  	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
>  	default n
>  
> +config EPAPR_PARA
> +	bool
> +	default n

EPAPR_PARAVIRT

>  config DEFAULT_UIMAGE
>  	bool
>  	help
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
> index f3b0c2c..c4b86e4 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -148,6 +148,14 @@
>  #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
>  #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
>  
> +extern u32 *epapr_hcall_insts;
> +extern int epapr_hcall_insts_len;
> +
> +static inline void epapr_get_hcall_insts(u32 **instp, int *lenp)
> +{
> +	*instp = epapr_hcall_insts;
> +	*lenp = epapr_hcall_insts_len;
> +}

Why do we need a function for this?  Why is the public interface
anything other than "invoke a hypercall"?

> +static int __init epapr_para_init(void)
> +{
> +	struct device_node *hyper_node;
> +	u32 *insts;
> +	int len;
> +
> +	hyper_node = of_find_node_by_path("/hypervisor");
> +	if (!hyper_node)
> +		return -ENODEV;
> +
> +	insts = (u32*)of_get_property(hyper_node, "hcall-instructions", &len);

Do not cast away that const.

> @@ -535,18 +536,12 @@ EXPORT_SYMBOL_GPL(kvm_hypercall);
>  static int kvm_para_setup(void)
>  {
>  	extern u32 kvm_hypercall_start;
> -	struct device_node *hyper_node;
>  	u32 *insts;
>  	int len, i;
>  
> -	hyper_node = of_find_node_by_path("/hypervisor");
> -	if (!hyper_node)
> -		return -1;
> -
> -	insts = (u32*)of_get_property(hyper_node, "hcall-instructions", &len);
> -	if (len % 4)
> -		return -1;
> -	if (len > (4 * 4))
> +	insts = epapr_hcall_insts;
> +	len = epapr_hcall_insts_len;
> +	if (insts == NULL)
>  		return -1;
>  
>  	for (i = 0; i < (len / 4); i++)

Why are you still doing the patching inside kvm.c?

-Scott
