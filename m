Date: Thu, 25 Sep 2003 15:20:11 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Roland Dreier <roland@topspin.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
In-Reply-To: <20030925125653.A16002@home.com>
Message-ID: <Pine.LNX.4.44.0309251459441.12966-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 25 Sep 2003, Matt Porter wrote:
> On Thu, Sep 25, 2003 at 01:15:15PM -0500, Bret Indrelee wrote:
> > I've read through the old thread about short DMAs, but still there are
> > things that aren't clear to me.
> >
> > What exactly is the issue?
>
> The issue is confined to processors which do not support hardware
> snooping of the external bus.  In this case, management of the
> caches is performed in software.

It is trying to figure out which systems have these sort of issues
that I'm currently puzzling through. Where the heck should I expect
to find this in the databooks for the various products?

[ snip ]
> > Right now, I'm interested in the PPC and x86 compatible (Pentium,
> > Pentium 4, Geode) systems, trying to understand the differences and
> > requirements of each.
>
> Which PPCs?  Classic PPC != PPC8xx != PPC40x != Book E PPC. :)

My immediate concern is 8245 and the Intel/Pentium style processors.

In the near term for PPC, the 8245 and maybe 405E.

> PPC8xx and PPC4xx require software cache coherency.  If you want
> your products to work on PPC44x (I hope you do, they are targetted
> at markets where qlogic storage controllers are used) ensuring that
> your DMA buffers are cacheline aligned at the head/tail is
> important.

It looked like on the PPC if I aligned for 32 byes (0x20), that should
handle it for now. This is for embedded, not the HBA controller, so I
shouldn't need to worry about CONFIG_PPC64BRIDGE.

On Pentium, I have to figure out if they do the snooping or not. I
suspect that they do, but finding cache coherency problems is bad
enough that I need a more definitive answer than that.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
