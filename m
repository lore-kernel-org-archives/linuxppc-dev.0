Return-Path: <ml@stefan-roese.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 7F63C67A3B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 23:10:14 +1100 (EST)
Date: Mon, 20 Nov 2006 12:54:32 +0100 (MET)
From: Stefan Roese <ml@stefan-roese.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
References: <200611201200.36780.ml@stefan-roese.de>
	<20061120114248.60bb0869@localhost.localdomain>
In-Reply-To: <20061120114248.60bb0869@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Message-Id: <200611201255.37754.ml@stefan-roese.de>
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

On Monday 20 November 2006 12:42, Alan wrote:
> On Mon, 20 Nov 2006 12:00:36 +0100
>
> Stefan Roese <ml@stefan-roese.de> wrote:
> > This patch fixes a problem seen on multiple 4xx platforms, where
> > the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
> > on those systems to not use an real interrupt but the timer based
> > implementation.
>
> NAK.

I knew it. ;-)

> Zero means "no interrupt" in the Linux space. If you have a physical IRQ
> 0 remap it to a convenient number (eg map IRQ's + 1, or stick it on the
> end). The logical and physical IRQ numbering in Linux don't have to match
> up - and given some platforms have IRQ numbering per bus and the like
> clearly doesn't in many cases.

Let's see, if I got this right. You mean that on such a platform, where 0 is a 
valid physical IRQ, we should assign another value as virtual IRQ number (not 
0 and not -1 of course). And then the platform "pic" implementation should 
take care of the remapping of these virtual IRQ numbers to the physical 
numbers.

Correct?

Best regards,
Stefan
