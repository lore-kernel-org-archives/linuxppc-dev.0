Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 193E167C3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 04:39:26 +1000 (EST)
In-Reply-To: <20050711134713.D767067C13@ozlabs.org>
References: <20050711134713.D767067C13@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bd3bf2b4d8489c491b4c3cee2d38a4b2@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 11 Jul 2005 11:39:05 -0700
To: "Absolut Hunter" <absoluthunter@comcast.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.4.25 / MPC8280 / ram config vs Linux instability?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 11, 2005, at 6:38 AM, Absolut Hunter wrote:

> ..... However, my goal is
> to map SRAM <8ns speeds> down to the address 0x00000000, to map the 
> vector
> table, so I can achieve a very fast interrupt response time.

The things Linux does to cause interrupt latencies are going to ensure
you aren't going to see any differences to the "interrupt response 
time." :-)
 From a system perspective, you are going to be much better off using
your SRAM for CPM data buffering than for any general software use.

> Does anyone have any idea what would cause this instability?

Yeah, I can't find a way to actually map the memory as you have
described.  You actually have the SRAM and SDRAM multiply mapped
on top of one another, and depending upon which chip selects
are used and the values in their registers, you are selecting between
the two memories.  Several cases exist.  You are either mapping the
SRAM on top of the SDRAM, or vice versa.  You really have only 32M
of memory available, so any access to the "upper" 2M is wrapping
around to the lower memory.  Basically, you have a big mess ;-)

You need to map these memories to modulo their size, so to put
the 2M at low memory, you are going to have a hole up to a 32M
boundary before you can map the SDRAM.  It's possible to do
this, but not without some custom Linux modifications.

Thanks.

	-- Dan
