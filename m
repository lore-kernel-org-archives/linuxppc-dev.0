Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E76967D3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 19:28:28 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kAE8SJ7E019554
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Nov 2006 09:28:21 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: CPM_UART: tcdrain() is broken
Date: Tue, 14 Nov 2006 09:28:00 +0100
References: <200611131656.23580.laurent.pinchart@tbox.biz>
	<3E143C92-0F1E-429C-861A-40566E7EF374@embeddedalley.com>
In-Reply-To: <3E143C92-0F1E-429C-861A-40566E7EF374@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611140928.00406.laurent.pinchart@tbox.biz>
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

Hi Dan,

> > There is, however, a problem left. The SCC controllers have a 32-
> > byte FIFO between the buffer descriptors and the wires.
> > cpm_uart_tx_empty() checks if all buffer descriptors have been processed,
> > but doesn't check if the transmit FIFO is actually empty.
>
> There is no way to determine if the hardware FIFO is empty.
> It's buried under the CPM microcode.

I was hoping the information would be somewhere in the parameter RAM :-(

> > .....  I can't figure out how to do so from the datasheet.
> > Does anyone have an idea ?
>
> The original versions of the SCC UART driver used to have a
> timeout based on the maximum depth of this FIFO and baud rate.
> After the last BD was empty, it would further wait this amount of
> time.  Lots of these little details seem to have been lost over
> the years of making a "better" driver :-)

That's a solution, but we might wait longer than necessary then. Vitaly, 
what's your opinion ? We should at least set fifosize to a proper value (see 
my previous mail). I'll submit a patch after we agree on the need for an 
additional delay.

Cheers,

Laurent Pinchart
