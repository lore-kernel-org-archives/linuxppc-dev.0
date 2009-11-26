Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11F4B1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:18:19 +1100 (EST)
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 16:18:14 +1100
Message-ID: <1259212694.16367.270.camel@pasglop>
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

On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:

> +static void flipper_pic_mask_and_ack(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +
> +	clear_bit(irq, io_base + FLIPPER_IMR);
> +	set_bit(irq, io_base + FLIPPER_ICR);
> +}

Do not use clear_bit and set_bit on IOs. They will do lwarx/stwcx. which
is really not what you want. You can use __clear_bit and __set_bit but
it's still fishy. Those operate on unsigned long, so the size vary
between 32 and 64 bit etc... not something you care that much about, but
it's still the wrong tool for the job.

Do those guys have more than 32 interrupts ? If not, just hand
code the msak & shifts. If they do, then maybe stick with __clear_bit()
and __set_bit() which are the non atomic variants.

Cheers,
Ben.
