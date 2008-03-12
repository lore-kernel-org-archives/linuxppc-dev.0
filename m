Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A527DE0C4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 07:45:04 +1100 (EST)
Date: Wed, 12 Mar 2008 21:44:51 +0100
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
Message-ID: <20080312204451.GA11426@Chamillionaire.breakpoint.cc>
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
	<47D7FD9D.2040202@freescale.com>
	<20080312172024.GB7255@Chamillionaire.breakpoint.cc>
	<47D82542.8020000@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47D82542.8020000@freescale.com>
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

* Timur Tabi | 2008-03-12 13:47:30 [-0500]:

>Sebastian Siewior wrote:
>
>> I need to hold src & dst each with one and two bytes makes four
>> channels. And then I need one for normal transfers. So I guess I have to
>> talk to my HW ppl that we have to change something :)
>
>What kind of driver are you writing that needs four simultaneous DMA transfers?
Multiple drivers and those transfers may or may not happen
simultaneously. I have an USB driver that does slave dma only. For that
one I need the normal memcpy. Than there is the FPGA. That one gives me
a few components, for instance a few SPI channels. Every SPI channel has
two FIFOs, one for write and one for read. Those FIFOs have either 8, 16
or 32 bits. For those few I need the (different) [S|D]AHTS bits. I thing
you have the picture.

Now. My understanding of the DMA engine API is that multiple clients may
use the same channel simultaneously and they rebalence oneself. The xHE
bits are one per channel so the USB driver can't share the DMA channel
with the SPI driver.
In order to share them, I have to lock a channel, set the required bits
and after the transfer is done, the channel could be unlocked again.
Locking channels isn't currently possible because everyone can call
dma_async_client_chan_request() and get every channel that is suitable.
Adding DMA_MEMCPY_HOLD_[S|D]_{8|16|32} creates more possibilities than
available channel. A nicer solution would be to add DMA_MEMCPY_HOLD and
set the required bits for every request but this is unfortunately not
possible.

What is left... Ah I could lock the channel via DMA_RESOURCE_REMOVED, do
my transfer and then give it back. The channels are not freed
immediately so transfers from the interrupt handler could be
problematic.

Do you recommend another solution? Or did I miss an important part of
the API that solves this kind of problem.

>Timur Tabi
>Linux kernel developer at Freescale

 Sebastian
