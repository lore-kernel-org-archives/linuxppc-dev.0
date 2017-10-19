Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHcLp06PnzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 16:05:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 brking@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/xmon: Always enable xmon sysrq trigger
In-Reply-To: <20171018113436.16112-1-gpiccoli@linux.vnet.ibm.com>
References: <20171018113436.16112-1-gpiccoli@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 16:05:21 +1100
Message-ID: <878tg7n2we.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> Distros vary the way they enable SysRq by default - mostly they seem
> to enable some mask and then majority of the SysRq functions are
> disabled. For instance, xmon does not even have a mask, and unsless
> SysRq are completely enabled ( == 1), xmon trigger keeps disabled.
>
> Countless times while investigating hangs we needed xmon and it was
> disabled - machine just got hung and while in serial console, we just
> couldn't drop to xmon, forcing to a new attempt to reproduce the issue
> with SysRq fully enabled.
>
> This patch "fixes" this by having xmon enabled in all possible masks
> of SysRq. In other words, xmon trigger will only be disabled if SysRq
> is 0 (completely disabled). So, while debugging a hung, when one tries
> to drop to xmon this patch prevents the frustrating message:
> "This sysrq operation is disabled".

I know it's annoying when you get stuck with a box like this, but I
can't merge this patch.

You're *removing* the system administrators ability to control access to
xmon (other than disabling sysrq entirely). That's a regression.

What we should do is get a bit allocated for xmon, so it can have a
non-zero single-bit enable mask.

cheers


> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 4679aeb84767..780d708472a2 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3514,6 +3514,7 @@ static struct sysrq_key_op sysrq_xmon_op = {
>  	.handler =	sysrq_handle_xmon,
>  	.help_msg =	"xmon(x)",
>  	.action_msg =	"Entering xmon",
> +	.enable_mask =	0xFFFF,
>  };
>  
>  static int __init setup_xmon_sysrq(void)
> -- 
> 2.14.2
