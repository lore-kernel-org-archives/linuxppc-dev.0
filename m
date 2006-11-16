Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D25F167BC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 11:14:55 +1100 (EST)
Date: Thu, 16 Nov 2006 23:46:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller
	using libata
Message-ID: <20061116234601.78325642@localhost.localdomain>
In-Reply-To: <11637151391017-git-send-email-tnt@246tNt.com>
References: <11637151391017-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>,
	Sven Luther <sl@bplan-gmbh.de>, Linux IDE <linux-ide@vger.kernel.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 16 Nov 2006 23:12:19 +0100
Sylvain Munaut <tnt@246tNt.com> wrote:

> * The manual states we should check for the TIP bit before all
> PIO transaction. That's not really supported by libata and requires
> reimplementing almost all the hooks. But after talking to Freescale,
> it turnsout it's not really necessary. So this driver doesn't implement
> that check. I noticed no problem so far ...
>

All PIO transactions meaning each PIO command sequence or each register
read/write ? In the former case is it not enough just to wrap the command
write ?

> * This driver doesn't use the standard function to compute timing
> because the 5200 needs more timing parameters that are not handled
> by the generic call (ta and t4).

I'd rather the generic code was taught to compute any extra times you
need but it seems clean enough.
