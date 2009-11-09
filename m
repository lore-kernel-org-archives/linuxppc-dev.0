Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1C49BB7088
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 00:41:36 +1100 (EST)
Date: Mon, 9 Nov 2009 16:41:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RFC] gianfar: Do not call skb recycling with disabled IRQs
Message-ID: <20091109134134.GB26965@oksana.dev.rtsoft.ru>
References: <E1N63WM-0003xK-PN@jdl.com> <E1N64UY-00049g-Hb@jdl.com>
	<20091105165738.GA31923@oksana.dev.rtsoft.ru>
	<20091108.010848.116517157.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091108.010848.116517157.davem@davemloft.net>
Cc: jdl@jdl.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	afleming@freescale.com, jason.wessel@windriver.com,
	shemminger@vyatta.com, buytenh@wantstofly.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 08, 2009 at 01:08:48AM -0800, David Miller wrote:
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: Thu, 5 Nov 2009 19:57:38 +0300
> 
> > But that basically means that with skb recycling we can't safely
> > use KGDBoE, though we can add something like this:
> 
> Please stop adding special logic only to your driver to handle these
> things.
> 
> Either it's a non-issue, or it's going to potentially be an issue for
> everyone using skb_recycle_check() in a NAPI driver, right?
> 
> So why not add the "in_interrupt()" or whatever check to
> skb_recycle_check() and if the context is unsuitable return false (0)
> ok?

I think the check is needed, yes. But if we add just that check,
then we'll never do skb recycling in the tx path (since gianfar
always grabs irqsave spinlock during tx ring cleanup, so the check
will always return false).

So we must add the check to keep polling with disabled IRQs safe,
but we also should get rid of irqsave spinlock in the gianfar
driver (to make the skb recycling actually work in most cases).

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
