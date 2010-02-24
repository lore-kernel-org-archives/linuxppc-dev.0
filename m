Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 2AC31B7CFB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 07:52:02 +1100 (EST)
Date: Wed, 24 Feb 2010 23:51:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: PCI on 834x
Message-ID: <20100224205159.GA6555@oksana.dev.rtsoft.ru>
References: <4B854A93.7030405@mlbassoc.com> <4B85746F.3020200@freescale.com>
	<4B857AA8.9000208@mlbassoc.com> <4B857EA1.6030605@freescale.com>
	<4B858243.8010908@mlbassoc.com> <4B858B6C.4020809@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B858B6C.4020809@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Gary Thomas <gary@mlbassoc.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 24, 2010 at 02:26:20PM -0600, Scott Wood wrote:
> Gary Thomas wrote:
> >Yes, I'm using the exact same kernel with these two different PCI
> >setups (done by the boot loader).
> >
> >Restricting the memory via mem=128M has no effect - the PCI layout
> >is the same.
> >
> >I think the outbound window size is required because of how the Linux PCI
> >remaps the space (note in my dumps that it put the MMIO of the
> >boards starting
> >at 0xD0000000 when the inbound window is 0x10000000)
> 
> I see where the amount of RAM is mattering -- Linux is assigning
> outbound I/O space to the PCI controller itself (device 00:00.0) and
> the amount that it asks for seems to differ based on memory size.
> Linux ought to skip that device when assigning resources.  Some
> platforms do this (search for pci_exclude_device), but it seems to
> be missing on 83xx.

Actually, 83xx had these exclude_device hooks, but they were removed:

commit d8f1324a5063c833862328ceafabc53ac3cc4f71
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Wed Sep 12 22:14:10 2007 -0500

    [POWERPC] 83xx: Removed PCI exclude of PHB

    Now that the generic code doesn't assign resources for Freescale
    PHBs we dont have to explicitly exclude it.

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>


May be the generic code started to assign the resources again?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
