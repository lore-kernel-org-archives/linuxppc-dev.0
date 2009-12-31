Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com
	[209.85.211.198]) by ozlabs.org (Postfix) with ESMTP id BEC76B6EF4
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 01:34:30 +1100 (EST)
Received: by ywh36 with SMTP id 36so12771711ywh.15
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 06:34:28 -0800 (PST)
Message-ID: <4B3CB67C.9060408@billgatliff.com>
Date: Thu, 31 Dec 2009 08:34:36 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Question on MPC52xx IRQ[123] pins
References: <4B2FF71E.10508@billgatliff.com>
	<fa686aa40912211516u4a079693h74e39fd887cb421d@mail.gmail.com>
In-Reply-To: <fa686aa40912211516u4a079693h74e39fd887cb421d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Correct.  IRQ2 can only be used as IRQ2.  It cannot be used a GPIO.
> (Well, I suppose you *could* try to hack into the interrupt controller
> driver and fetch the pin state that way; but I don't know if you can
> read the state of masked out IRQ pins, and it sure would be ugly.)
>   

Actually, I did think of a way you could do this.  You could register an
interrupt handler on the line, and set the irq type to level-low or
level-high.  Depending on whether the handler fires right away, you know
what the state of the pin must be.  And when the interrupt handler does
fire, you switch the irq type to the opposite setting.

I think that approach rates pretty high on the "ugly scale" too, but
perhaps tolerably so.  In fact, were I to actually need to interface one
of the IRQ lines to gpiolib, I might attempt this...


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
