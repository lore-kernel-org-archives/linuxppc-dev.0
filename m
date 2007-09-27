Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 526D1DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 04:43:28 +1000 (EST)
Message-ID: <46FBF9B7.9010007@freescale.com>
Date: Thu, 27 Sep 2007 13:43:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
References: <20070810095153.GC13994@moe.telargo.com>	<200709271907.50479.jbe@pengutronix.de>
	<9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
In-Reply-To: <9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> The call to msleep() is inside a block protected with
> :#define in_interrupt()          (irq_count())
> if (!in_interrupt)
> 
> The stack trace looks like it is in a timer interrupt so shouldn't
> irq_count be non-zero?
> Could there be some lack of coordination on irq_count and the timer
> tick with the preempt patch applied?  Or does irq_count() not count
> soft irqs?
> 
> (!in_interrupt) may be the wrong way to protect this code.

I think in_atomic() is what you want.

-Scott
