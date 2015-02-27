Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 496AF1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 13:25:36 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1424768706-23150-5-git-send-email-asolokha@kb.kras.ru>
Date: Fri, 27 Feb 2015 09:25:28 +0700
In-Reply-To: <1424768706-23150-5-git-send-email-asolokha@kb.kras.ru> (Arseny
 Solokha's message of "Tue, 24 Feb 2015 16:05:06 +0700")
Message-ID: <87zj80jdk7.fsf@KB00016249.iskra.kb>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -1676,31 +1666,6 @@ void __init mpic_init(struct mpic *mpic)
>  		mpic_err_int_init(mpic, MPIC_FSL_ERR_INT);
>  }
>  
> -void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
> -{
> -	u32 v;
> -
> -	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
> -	v &= ~MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK;
> -	v |= MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(clock_ratio);
> -	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
> -}
> -
> -void __init mpic_set_serial_int(struct mpic *mpic, int enable)
> -{
> -	unsigned long flags;
> -	u32 v;
> -
> -	raw_spin_lock_irqsave(&mpic_lock, flags);
> -	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
> -	if (enable)
> -		v |= MPIC_GREG_GLOBAL_CONF_1_SIE;
> -	else
> -		v &= ~MPIC_GREG_GLOBAL_CONF_1_SIE;
> -	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
> -	raw_spin_unlock_irqrestore(&mpic_lock, flags);
> -}
> -
>  void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
>  {
>  	struct mpic *mpic = mpic_find(irq);

Thinking about it some more, I wonder whether it makes sense to propagate these
values through device tree (and refuse to apply them if they are 0), just like
what timer_group_get_freq() and timer_group_get_irq() in
arch/powerpc/sysdev/mpic_timer.c do.

Does it have any real use?
