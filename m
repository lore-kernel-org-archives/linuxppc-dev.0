Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E044DDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 10:45:49 +1100 (EST)
Subject: Re: [i2c] [PATCH 19 3/5] Clean up error returns
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910801200718q7304bc29q38e67580613189e4@mail.gmail.com>
References: <20080112024737.7023.61680.stgit@terra.home>
	<20080112024743.7023.23630.stgit@terra.home>
	<20080120120730.06dd8a7f@hyperion.delvare>
	<9e4733910801200718q7304bc29q38e67580613189e4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 10:06:41 +1100
Message-Id: <1200956801.6807.16.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-01-20 at 10:18 -0500, Jon Smirl wrote:
> > So it seems to me like the polling mode code is never actually used?
> > Unless some platforms include an "empty" IRQ in their device
> > definition. Which indeed seems to be the case... but then they set
> the
> > IRQ to 0, NOT to NO_IRQ, so I'm wondering if the change you propose
> is
> > really correct.
> 
> All of this is very confusing to me, There are physical IRQs and
> virtual IRQs. Apparently zero is a legal physical IRQ but it is not a
> legal virtual IRQ. We only get virtual IRQs in this code. We need to
> get BenH to give us the right answer on these two cases.

Testing against NO_IRQ for a linux IRQ number should always be correct.

Physical IRQ numbers are remapped and shouldn't be visible to drivers,
NO_IRQ is a value that never exist for a valid logical interrupt number,
that is 0 for arch/powerpc and -1 for arch/ppc.

Ben.
