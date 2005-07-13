Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB1BA67A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 19:14:46 +1000 (EST)
Date: Wed, 13 Jul 2005 10:03:17 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: gqbenjamin@21cn.com
Message-Id: <20050713100317.5177bcae.ajz@cambridgebroadband.com>
In-Reply-To: <Q6949286895747.26323@webmail1.inner-21cn.com>
References: <Q6949286895747.26323@webmail1.inner-21cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: help: FCC_ENET OF MPC8250?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Jul 2005 10:42:52 +0800 (CST)
gqbenjamin@21cn.com wrote:

> Hi,
> 
> I use a device, like SMARTBITS, to test the Ethernet rate of mpc8250. The kernel is linux-2.4.20
> with CONFIG_FCC_LXT971 and CONFIG_USE_MDIO, and do 'cat "1">/proc/sys/net/ipv4/ip_forward'.
> 
> If the rate of sending IP packet been set too high, for example 100 Mbps Full Duplex and each
> packet is 1514 Bytes. Later, the kernel print '... Memory squeeze, dropping packet' on uart. Stop
> sending IP packet and do 'cat /proc/meminfo', the *MemFree* become small.
> 
> Try again, the *MemFree* become smaller, just look like some allocated memory (skbuf) do not be
> free.
> 
> Final, the kernel break down, because all memory have been used.


It sounds to me like the problem may be that fcc_enet_rx() is consuming all the memory.  This
function is called in interrupt context and spins round the rx buffer descriptor ring until it finds
an empty buffer descriptor.  There is no check to stop it going round more than once and each time
it finds a BD it does a dev_alloc_skb().

It is possible that you are receiving data at a high enough rate that fcc_enet_rx() never exits.

What is more likely is that there isn't enough time between rx interrupts for the CPU to tx all the
queued packets.


> 
> Q. How can I do to let kernel do not break down? Is it a kernel promblem?
> 

This is just a guess, but... it may help to move fcc_enet_rx() from the interrupt handler to a
bottom half.  If you do this you should also ensure that it cannot process the rx buffer descriptor
ring more than once per call.  This may give the CPU *more* chance to tx queued packets by lowering
the rx priority a little.

I don't know if this would work but I'd be interested to find out.

Alex
