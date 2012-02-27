Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1971B6FA9
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 07:52:35 +1100 (EST)
Message-ID: <4F4BED09.1040306@freescale.com>
Date: Mon, 27 Feb 2012 14:52:25 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v6 1/4] KVM: PPC: epapr: Factor out the epapr init
References: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
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

On 02/23/2012 03:22 AM, Liu Yu wrote:
> +static int __init epapr_paravirt_init(void)
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
> +	if (!insts)
> +		return 0;

-ENODEV here too.

> +	if (!(len % 4) && len <= (4 * 4)) {
> +		for (i = 0; i < (len / 4); i++)
> +			patch_instruction(epapr_hypercall_start + i, insts[i]);
> +
> +		epapr_paravirt_enabled = true;
> +	} else {
> +		printk(KERN_WARNING
> +		       "ePAPR paravirt: hcall-instructions format error\n");
> +	}

Do this:

if (error) {
	print error
	return error code
}

continue with function

Not this:

if (!error) {
	continue with function
} else {
	report the error from several lines back
}

> @@ -33,6 +34,14 @@ config KVM_GUEST
>  
>  	  In case of doubt, say Y
>  
> +config EPAPR_PARAVIRT
> +	bool "ePAPR para-virtualization support"
> +	default n
> +	help
> +	  Used to enalbe ePAPR complied para-virtualization support for guest.
> +
> +	  In case of doubt, say Y

s/Used to enalbe/Enable/

s/complied/compliant/ (or just s/complied//)

-Scott
