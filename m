Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0ACBEDDFAC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 15:31:17 +1000 (EST)
Subject: Re: [patch 5/6] PS3: Fix system slowdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46365913.3090504@am.sony.com>
References: <20070430202420.872228544@am.sony.com>
	<46365913.3090504@am.sony.com>
Content-Type: text/plain
Date: Tue, 01 May 2007 15:31:06 +1000
Message-Id: <1177997466.24962.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-30 at 14:01 -0700, Geoff Levand wrote:
> From: Takao Shinohara <shin@sm.sony.co.jp>
> 
> The PS3 HV will deliver soft-disabled interrupts at the next HV call or
> interrupt.  Add an HV call to local_irq_restore() to force the timely
> delivery of any pending interrupts.
> 
> This fixes the system slowdown bug reported here
> http://bugzilla.kernel.org/show_bug.cgi?id=8260
> 
> From: Takao Shinohara <shin@sm.sony.co.jp>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Note: It would be nicer to do the HV call from assembly, using a
firmware feature section, when the interrupt actually happens. The main
reason I haven't done a patch yet is that it happens in an exception
vectors with only few registers available nad the HV call will clobber a
lot more than we have saved.

Ben.


> ---
> 
> I made a request to change the behavior of the lv1 hypervisor to better
> support the way we do soft-disable on Linux, but it is still not been
> decided if and when that support will be done.
> 
>  arch/powerpc/kernel/irq.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- ps3-linux-dev.orig/arch/powerpc/kernel/irq.c
> +++ ps3-linux-dev/arch/powerpc/kernel/irq.c
> @@ -67,6 +67,7 @@
>  #ifdef CONFIG_PPC64
>  #include <asm/paca.h>
>  #include <asm/firmware.h>
> +#include <asm/lv1call.h>
>  #endif
>  
>  int __irq_offset_value;
> @@ -162,6 +163,16 @@ void local_irq_restore(unsigned long en)
>  	local_paca->hard_enabled = en;
>  	if ((int)mfspr(SPRN_DEC) < 0)
>  		mtspr(SPRN_DEC, 1);
> +
> +	/*
> +	 * Force the delivery of pending soft-disabled interrupts on PS3.
> +	 * Any HV call will have this side effect.
> +	 */
> +	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
> +		u64 tmp;
> +		lv1_get_version_info(&tmp);
> +	}
> +
>  	hard_irq_enable();
>  }
>  #endif /* CONFIG_PPC64 */
> 
