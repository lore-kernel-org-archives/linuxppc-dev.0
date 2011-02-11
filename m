Return-Path: <scottwood@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C431FB71A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 09:19:38 +1100 (EST)
Date: Fri, 11 Feb 2011 16:19:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kenny Ho <kho@belairnetworks.com>
Subject: Re: Question on setting up external interrupt for P1020 (MPC8xxx)
	with device tree
Message-ID: <20110211161920.3c44a678@udp111988uds>
In-Reply-To: <92C536451C241244A14F3001819BF6688A503C@bnott05.belairnetworks.com>
References: <92C536451C241244A14F3001819BF6688A503B@bnott05.belairnetworks.com>
	<20110211155644.6799f6b6@udp111988uds>
	<92C536451C241244A14F3001819BF6688A503C@bnott05.belairnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Feb 2011 17:15:47 -0500
Kenny Ho <kho@belairnetworks.com> wrote:

> Thanks Scott.
> 
> Do you know the logic of the hwirq <-> virq mapping?

It's dynamic.

> When I was digging into the GPIO interrupt, the hwirq seems to be the same as the virq

The allocator tries that if it's available, but if that virq is already
taken, or is in the legacy ISA region under 16, you'll get a different
number.

> (both are 47 which is 16 (external interrupt) + 31 (internal interrupt).
> If I want to use external interrupt 7 and 8, should the virq also be 7
> and 8?

No.

> For some reason I am getting 41 for virq... may be I am still
> doing something wrong.

It's correct.  Pass what you receive into request_irq().

-Scott
