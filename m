From: hollis@austin.ibm.com
Date: Wed, 2 Jan 2002 14:04:59 -0600
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to gt64260 interrupt support code
Message-ID: <20020102200459.GG469@austin.ibm.com>
References: <200112271744.MAA03341@missioncriticallinux.com> <20020102123046.U25200@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020102123046.U25200@altus.drgw.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 02, 2002 at 12:30:46PM -0600, Troy Benjegerdes wrote:
>
> We **REALLY** need a better way to deal with cascaded 8259's than adding
> an offset.. I think Dan Malek had some good ideas on what to do about
> this, but I don't know that anyone has got any currently running code that
> solves this problem nicely.

The ppc64 port has an array of virtual irq's which is used to index to the
real irq. In the interests of easy debugging (eg when drivers print out their
irq number) the virtual irq is kept identical to the actual whenever possible.

arch/ppc64/prom.c sets up the map (virt_irq_to_real_map), and
arch/ppc64/xics.c (the interrupt controller) uses it.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
