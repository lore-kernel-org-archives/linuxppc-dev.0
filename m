Return-Path: <glikely@secretlab.ca>
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com
	[209.85.218.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11B2BB6F70
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 07:18:48 +1000 (EST)
Received: by yib12 with SMTP id 12so5800514yib.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2011 14:18:45 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 27 Sep 2011 12:29:12 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
Message-ID: <20110927182912.GA3994@ponder.secretlab.ca>
References: <4E81D6C0.3010201@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E81D6C0.3010201@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 27, 2011 at 04:59:28PM +0300, Felix Radensky wrote:
> Hi,
> 
> Looks like  8xxx GPIO driver cannot properly handle interrupts
> when multiple GPIO controllers exist in the system.
> 
> On Freescale P1022 there are 3 GPIO controllers. All 3 use
> the same interrupt line, internal interrupt 31. If all controllers
> are defined in device tree set_irq_chained_handler() is invoked
> 3 times with same  hardware irq number. The result is interrupt
> storm,  mpc8xxx_gpio_irq_cascade() is invoked indefinitely.
> 
> What would be the best way to fix the problem ?

The solution is to make the gpio driver register as a regular
interrupt handler, and not as a chained handler.

g.
