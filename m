Subject: Re: MPC7455 DMA buffer strangeness
From: Adrian Cox <adrian@humboldt.co.uk>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40EA6739.2040408@fh-landshut.de>
References: <Pine.LNX.4.58.0407051018590.388@corpster2>
	 <1089102844.937.57.camel@localhost>  <40EA6739.2040408@fh-landshut.de>
Content-Type: text/plain
Message-Id: <1089106451.937.85.camel@localhost>
Mime-Version: 1.0
Date: Tue, 06 Jul 2004 10:34:12 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-07-06 at 09:47, Oliver Korpilla wrote:
> The buffer is not written to in kernel space, but in user space. An ioctl() is
> made for triggering the DMA. The user space mapping will lead to direct writes
> to that physical buffer address, so the DMA engine of my PCI-VME-bridge chip
> should see only what I wrote in user space, regardless of the kernel mapping.
> (But it doesn't in reality!)

It's certainly possible that part of the page has ended up in cache.

Why are you trying to turn off cache coherency? This should all work if
your userspace mapping is cache coherent.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
