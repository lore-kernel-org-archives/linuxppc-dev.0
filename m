Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3C97C301.B5A95C8B@mvista.com>
Date: Tue, 19 Mar 2002 18:00:17 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203200043.AA08228@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> Mark A. Greer <mgreer@mvista.com> wrote:
>
> > I like what Michael has done but want to add more and change the
> > BI_GT64260_ETH_CFG to a more generic BI_ETH_CFG.
>
> I disagree. I don't see how a generic BI_ETH_CFG is possible. See how I've
> implemented BI_GT64260_ETH_CFG in arch/ppc/kernel/setup.c:parse_bootinfo: it
> injects the information from this record directly into the gt64260_eth driver,
> which is where this information is needed.

My point is that "you way" would change to a more generic way for all enet driver.

The BI_ETH_CFG has already been shot down so we don't need to worry about it
anyway.

> Next when someone wants to do the same for, say, 8260 Ethernet, they'll have to
> add BI_8260_ETH_CFG or whatever. I don't see any other way: what if I built a
> board with an 8260 CPU and a GT-64260 attached to the 60x bus coming out of the
> 8260 (such a board was in the works at SBS before I left) and both 8260 and GT
> Ethernets are used? What will parse_bootinfo() do with a BI_ETH_CFG then? Is it
> going to inject the MAC address into the 8260 Ethernet driver, into the GT
> Ethernet driver, or where? How do you make sure that each Ethernet interface
> gets the MAC address that belongs to it?

This is a good point and this is an issue with any generic ethernet bi_rec
scheme.  At this point, I'm back to preferring what you've done since...well...its
done and I don't see anyone else caring much about this for other drivers.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
