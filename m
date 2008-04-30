Return-Path: <scottwood@freescale.com>
Date: Wed, 30 Apr 2008 10:00:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
Subject: Re: SKB corruption on heavy traffic
Message-ID: <20080430150053.GB23545@ld0162-tx32.am.freescale.net>
References: <20080429191510.GC8955@ld0162-tx32.am.freescale.net>
	<56DEE2D3217CD946B290399093C8FA7C212E1F@PTLIEXC001.nsn-intra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56DEE2D3217CD946B290399093C8FA7C212E1F@PTLIEXC001.nsn-intra.net>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 09:43:33AM +0100, Franca, Jose (NSN - PT/Portugal - MiniMD) wrote:
> 	It't quite dificult to say if the problem exists without our
> 	changes, since the all software is dependent on this changes so
> 	to work with the hardware. I can't answer to that right now on
> 	that, but I forgot to add one thing: we have ring buffer full
> 	problems on our fcc_enet driver from time to time. So, I think
> 	the problem could be on linux configurations (related to hw)
> 	because there is a lot of posts on the web related to problems
> 	similar to this (none of them has really solved the bottom
> 	problem).

One thing you could try is to enable slab debugging, rather than your
custom debugging code; this will poison the memory upon free, making it
more likely that whatever is accessing it will crash immediately rather
than just cause corruption.  Or, if you want to mantain the delay, do the
poisoning yourself.

Of course, this won't help if the access is write-only, or if the
corruption is happening via DMA.

When you say you have a full ring buffer, do you mean tx or rx?  Does it
recover gracefully?  Do you think it's caused by something other than
sending data faster than the line can support (tx) or receiving packets
faster than the cpu can handle (rx)?

Are any of the other problem reports from recent, unmodified kernels (2.4
is very old)?

-Scott
