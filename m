Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6809967B9F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 22:36:56 +1100 (EST)
Date: Mon, 20 Nov 2006 11:42:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
Message-ID: <20061120114248.60bb0869@localhost.localdomain>
In-Reply-To: <200611201200.36780.ml@stefan-roese.de>
References: <200611201200.36780.ml@stefan-roese.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 20 Nov 2006 12:00:36 +0100
Stefan Roese <ml@stefan-roese.de> wrote:

> This patch fixes a problem seen on multiple 4xx platforms, where
> the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
> on those systems to not use an real interrupt but the timer based
> implementation.

NAK.

Zero means "no interrupt" in the Linux space. If you have a physical IRQ
0 remap it to a convenient number (eg map IRQ's + 1, or stick it on the
end). The logical and physical IRQ numbering in Linux don't have to match
up - and given some platforms have IRQ numbering per bus and the like
clearly doesn't in many cases.
