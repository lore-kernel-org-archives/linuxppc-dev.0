Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 3F2DDDDDE3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 22:41:08 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-34.bayarea.dialup.o1.com [66.81.71.34])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mADBdYFT018467
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 03:40:59 -0800 (PST)
Message-ID: <491C11B2.1060909@hypersurf.com>
Date: Thu, 13 Nov 2008 03:38:26 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: pmac_zilog debugging ...
References: <4914B549.9010805@hypersurf.com>
	<1226096603.13603.74.camel@pasglop>
In-Reply-To: <1226096603.13603.74.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2008-11-07 at 13:38 -0800, Kevin Diggs wrote:
> 
>>to connect an 8600 to a laptop via ppp the link will lock up in short
>>order from "payloaded" pings. Any advice on how to figure out where it
>>is locking up? This command works fine to connect two x86 laptops. At
>>1200 it does take a while for an xterm to show up, though.
> 
> 
> Flow control might be busted. You may need to revert the polarity of the
> CTS line sampling. Let me know what you find out.
> 
> Cheers,
> Ben.
> 
I put the YDL 2.1 disk with it's 2.4.31 kernel back in the beast. With the
macserial driver ppp works flawlessly. I can connect to my ISP using one of
those Global Village modems. I can also torture a Nec VersaM100 laptop at
115200.

Using 2.6.27 and pmac_zilog I can't even run:

	xdpyinfo -display pm8600bs:0

after telnetting into afore mentioned abused laptop.

There are some debug macros that are in pmac_zilog. I have also added a few
new ones in an attempt to see where it is locking up. The following lines
are the result of the DEBUG_HARD macro (interrupt debug):

pmac_zilog 0.00013000:ch-b: irq, r3: 2
pmac_zilog 0.00013000:ch-b: irq done.
pmac_zilog 0.00013000:ch-b: irq, r3: 4
pmac_zilog 0.00013000:ch-b: pmz_receive_chars() -> 1 (loops 1)
pmac_zilog 0.00013000:ch-b: irq done.
pmac_zilog 0.00013000:ch-b: irq, r3: 0
pmac_zilog 0.00013000:ch-b: irq done.
pmac_zilog 0.00013000:ch-b: irq, r3: 2
pmac_zilog 0.00013000:ch-b: irq done.

I think r3 is the interrupt status register. Note the '0' for the next to
last interrupt. I think this is a pattern: a 0 (???), a 2 (tx), then
locked.

Here are some metrics.

2.4.31 macserial @ 115,200:

pppstats:  47,389,911 bytes in? 46,540 packets; 2,925,937 bytes out?

45,831 rxdma interrupts
658,825 SCC interrupts

2.6.27 pmac_zilog @ 4800:

pppstats:  10,653 bytes in? 145 packets; 13,089 bytes out? 195 packets
/proc/tty/driver/ttyPZ:  tx: 6,227; rx: 5,986 (!= pppstats???)

12,206 PowerMac Zilog interrupts

Interrupt load is higher without the DMA support.

Is it possible that this hardware was not meant to be used without the
DMA (i.e. it does not work quite right?)?

kevin
