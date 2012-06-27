Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 87A27B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 08:51:24 +1000 (EST)
Message-ID: <1340837479.3732.90.camel@pasglop>
Subject: Re: [PATCH] powerpc: check_and_cede_processor never cedes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 28 Jun 2012 08:51:19 +1000
In-Reply-To: <20120628084509.4caec81d@kryten>
References: <20120628084509.4caec81d@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-28 at 08:45 +1000, Anton Blanchard wrote:
>  	hard_irq_disable();
> -	if (get_paca()->irq_happened == 0)
> +	if (get_paca()->irq_happened == PACA_IRQ_HARD_DIS)
>  		cede_processor();

I'd rather add a helper, something like lazy_irq_pending()
and hide the actual check for the bits in irq_happened, in
case we change the scheme again.

Something like:

static inline bool lazy_irq_pending(void)
{
	return !!(get_paca()->irq_happened & ~PACA_IRQ_HARD_DIS);
}

Cheers,
Ben.
