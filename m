Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 439F467BCE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 23:33:46 +1100 (EST)
Date: Tue, 14 Nov 2006 15:33:13 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM_UART: tcdrain() is broken
Message-ID: <20061114153313.37513a39@vitb.ru.mvista.com>
In-Reply-To: <200611140928.00406.laurent.pinchart@tbox.biz>
References: <200611131656.23580.laurent.pinchart@tbox.biz>
	<3E143C92-0F1E-429C-861A-40566E7EF374@embeddedalley.com>
	<200611140928.00406.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 14 Nov 2006 09:28:00 +0100
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi Dan,
> 
> > > There is, however, a problem left. The SCC controllers have a 32-
> > > byte FIFO between the buffer descriptors and the wires.
> > > cpm_uart_tx_empty() checks if all buffer descriptors have been processed,
> > > but doesn't check if the transmit FIFO is actually empty.
> >
> > There is no way to determine if the hardware FIFO is empty.
> > It's buried under the CPM microcode.
> 
> I was hoping the information would be somewhere in the parameter RAM :-(
> 
> > > .....  I can't figure out how to do so from the datasheet.
> > > Does anyone have an idea ?
> >
> > The original versions of the SCC UART driver used to have a
> > timeout based on the maximum depth of this FIFO and baud rate.
> > After the last BD was empty, it would further wait this amount of
> > time.  Lots of these little details seem to have been lost over
> > the years of making a "better" driver :-)
> 
> That's a solution, but we might wait longer than necessary then. Vitaly, 
> what's your opinion ? We should at least set fifosize to a proper value (see 
> my previous mail). I'll submit a patch after we agree on the need for an 
> additional delay.
> 

Well, I also bothered Dan with the same question some time ago, getting the same answer :)
I think here we aught to have this delay ported, but under Kconfig option, so that those who are happy with current being, do not suffer from additional delays.

Patch appreciated :)
-- 
Sincerely, 
Vitaly
