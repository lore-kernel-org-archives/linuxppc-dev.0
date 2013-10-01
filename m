Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A03E2C008A
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 02:32:24 +1000 (EST)
Message-ID: <524AF913.6020007@linutronix.de>
Date: Tue, 01 Oct 2013 18:32:19 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
 <524A7FCB.3020406@linutronix.de> <20131001091115.GB2993@katana>
In-Reply-To: <20131001091115.GB2993@katana>
Content-Type: text/plain; charset=windows-1252
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

On 10/01/2013 11:11 AM, Wolfram Sang wrote:
> Hi,

Hi Wolfram,

> Well, if you insist, I'd prefer the following patch.
> 
> From: Wolfram Sang <wsa@the-dreams.de> Subject: [PATCH] ppc:
> mpc52xx: silence false positive from old GCC
> 
> So people can compile with -Werror (RT patchset).

Why do you mention the RT patch set here? Doesn't the vanila tree gets
compiled with -Werror as well?

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de> --- 
> arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +- 1 file changed,
> 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c index b89ef65..ad3c9b0
> 100644 --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c +++
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c @@ -340,7 +340,7 @@
> static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int
> virq, { int l1irq; int l2irq; -	struct irq_chip *irqchip; +	struct
> irq_chip *irqchip = NULL; /* pet old compilers */

That would probably work, too. I would drop that comment but then
someone might clean that up :P

> void *hndlr; int type; u32 reg;
> 
>> Why miss leading code? Default here does the same as unhandled
>> and crit where it does nothing.
> 
> People not realizing 'default' is a no-op might wonder why unknown 
> levels are mapped to critical.

I see. And what would you suggest as default in case we would have an
additional bit?

> 
>> Any why do you want to see l2irq since it was not in the case
>> statement? l2 holds the number, l1 the level.
> 
> We know which level it was, since the printout is only for that
> level. We probably want to know which requested IRQ was causing
> this, so we can fix the assorted driver. Otherwise we only know
> that some critical IRQ was requested somewhere.

Hmmm. I assumed that critical / SDMA / … are interrupt numbers but they
are seem not be. In that case I guess l2 is more important. l1 kinda
looks important since it is the value in the switch case which failed
but since it can only hold one possible value, I guess your info is
better :)

> 
> Thanks,
> 
> Wolfram
> 
Sebastian
