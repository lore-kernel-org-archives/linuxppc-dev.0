Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2J6v4FhqzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 03:08:07 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y143so14392387pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 08:08:07 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 16 Jan 2017 21:37:59 +0530
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH] powerpc/icp-opal: Fix missing KVM case and harden replay
Message-ID: <20170116160759.GA31332@localhost.localdomain>
References: <1484533171.11927.24.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484533171.11927.24.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 15, 2017 at 08:19:31PM -0600, Benjamin Herrenschmidt wrote:
> The icp-opal call is missing the code from icp-native to recover
> interrupts snatched by KVM. Without that, when running KVM, we can
> get into a situation where an interrupt is lost and the CPU stuck
> with an elevated CPPR.
> 
> Also harden replay by always checking the return from opal_int_eoi
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/sysdev/xics/icp-opal.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
> index d38e86f..60c5765 100644
> --- a/arch/powerpc/sysdev/xics/icp-opal.c
> +++ b/arch/powerpc/sysdev/xics/icp-opal.c
> @@ -20,6 +20,7 @@
>  #include 
>  #include 
>  #include 
> +#include 
>

??

<snip>

> @@ -39,7 +40,26 @@ static void icp_opal_flush_ipi(void)
>  	 * Should we be flagging idle loop instead?
>  	 * Or creating some task to be scheduled?
>  	 */
> -	opal_int_eoi((0x00 << 24) | XICS_IPI);
> +	if (opal_int_eoi((0x00 << 24) | XICS_IPI) > 0)
> +		force_external_irq_replay();
> +}

Shouldn't we also update kvm bits on icp_native_ipi_action
and icp_native_cause_ipi?

Balbir Singh.
