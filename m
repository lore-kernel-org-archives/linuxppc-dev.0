Return-Path: <esbenhaabendal@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id C5723B7D20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jun 2010 07:28:27 +1000 (EST)
Received: by fxm5 with SMTP id 5so306815fxm.15
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jun 2010 14:28:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.1006071440520.2933@localhost.localdomain>
References: <1275686352.2970.2.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006042343150.2933@localhost.localdomain>
	<AANLkTilb7---Qg1oLwzanKP1RGe04fkAXDtZzz0w9MGz@mail.gmail.com>
	<20100605151031.2d562268@hina.wild-wind.fr.eu.org>
	<alpine.LFD.2.00.1006051732270.2933@localhost.localdomain>
	<AANLkTimlSBEhl58CNuScKjxbqdTwTYgqo7vrHTcd1x9G@mail.gmail.com>
	<alpine.LFD.2.00.1006051915290.2933@localhost.localdomain>
	<AANLkTimcB9vRqnNYyBh6hjHXZHcmFvw72MZUEIGfeexq@mail.gmail.com>
	<alpine.LFD.2.00.1006052155100.2933@localhost.localdomain>
	<AANLkTik2so7osQJFq6NRaIFK2GVLURVozOqSsejd1K0F@mail.gmail.com>
	<alpine.LFD.2.00.1006062228120.2933@localhost.localdomain>
	<1275914058.2818.8.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006071440520.2933@localhost.localdomain>
Date: Mon, 7 Jun 2010 23:28:23 +0200
Message-ID: <AANLkTilPhof5cnhBCXSzKJSnWl6Vuu2fRts2pBBBNl6K@mail.gmail.com>
Subject: Re: [RFC][PATCH] irq: support IRQ_NESTED_THREAD with non-threaded
	interrupt handlers
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: joachim.eastwood@jotron.com, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Esben Haabendal <eha@doredevelopment.dk>,
	linuxppc-dev@ozlabs.org, Marc Zyngier <maz@misterjones.org>,
	Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 7, 2010 at 5:06 PM, Thomas Gleixner <tglx@linutronix.de> wrote:

> Maybe you understand now, why I was pretty sure upfront, that your
> approach was wrong even without knowing all the gory details ? :)

I understand.  There is a better solution, which is to use threaded
interrupts where needed.

But I must confess that I am disappointed that you still fail to see
how the pca953x
patch actually eliminates the need for serialization. But I don't
think there is much
point in going on about that.

The phy driver should be rewritten to use a threaded handler, it will
solve my particular problem.
And in the meantime, I have been promised to get the phy interrupts ofloade=
d
to real CPU interrupt lines :-)

Oh, I still think that the disable_irq_nosync documentaiton is misleading.
Functions that are allowed in a particular context should not call function=
s
that are not allowed to be called in that context. But now I know :-)

/Esben
--=20
Esben Haabendal, Senior Software Consultant
Dor=E9Development ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Phone: +45 51 92 53 93, E-mail: eha@doredevelopment.dk
WWW: http://www.doredevelopment.dk
