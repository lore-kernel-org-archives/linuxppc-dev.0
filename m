Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A421B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 10:21:44 +1100 (EST)
Subject: Re: [RFC PATCH v2 09/11] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1259441037-15725-10-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
	<1259441037-15725-10-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Nov 2009 10:21:39 +1100
Message-ID: <1259536899.2076.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-28 at 21:43 +0100, Albert Herranz wrote:

> +static void flipper_pic_mask_and_ack(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +	u32 mask = 1 << irq;
> +
> +	clrbits32(io_base + FLIPPER_IMR, mask);
> +	/* this is at least needed for RSW */
> +	out_be32(io_base + FLIPPER_ICR, mask);
> +}

That's a lot better. You probably still need to also read back to make
sure the line is properly de-asserted before you return... but if you
don't observe spurrious interrupts then it probably doesn't matter
much. 

No big deal either way though, change it if you want but I'm not going
to nack it if you don't :-)

You can also save cycles by avoiding the read/modify/write by storing a
memory cache of what the mask should be. MMIO reads tend to be slow.

Cheers,
Ben.
