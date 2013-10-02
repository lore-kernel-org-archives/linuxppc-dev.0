Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E79D42C007E
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 17:12:20 +1000 (EST)
Message-ID: <524BC750.1090401@linutronix.de>
Date: Wed, 02 Oct 2013 09:12:16 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
 <524A7FCB.3020406@linutronix.de> <20131001091115.GB2993@katana>
 <524AF913.6020007@linutronix.de> <20131001190344.GA3006@katana>
In-Reply-To: <20131001190344.GA3006@katana>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/2013 09:03 PM, Wolfram Sang wrote:
> 
> Yup. But I just remembered a better solution:
> 
> From: Wolfram Sang <wsa@the-dreams.de> Subject: [PATCH] ppc:
> mpc52xx: silence false positive from old GCC
> 
> So people can compile with -Werror.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de> --- 
> arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +- 1 file changed,
> 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c index b89ef65..2898b73
> 100644 --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c +++
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c @@ -340,7 +340,7 @@
> static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int
> virq, { int l1irq; int l2irq; -	struct irq_chip *irqchip; +	struct
> irq_chip *uninitialized_var(irqchip); void *hndlr; int type; u32
> reg;
> 
> 
> uninitialized_var was created for exactly that purpose IIRC.

Yup, looks good, thanks.

> 
> Thanks,
> 
> Wolfram
> 

Sebastian
