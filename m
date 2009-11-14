Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B30851007D1
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 08:41:18 +1100 (EST)
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF76EB2F89.E66EDF7B-ONC125766E.00687237-C125766E.006921DF@transmode.se>
References: <1258195348-2861-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<8F89F37D-4EC1-4B1B-AA89-5BFF5707E5F8@embeddedalley.com>
	<OF76EB2F89.E66EDF7B-ONC125766E.00687237-C125766E.006921DF@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 15 Nov 2009 08:41:06 +1100
Message-ID: <1258234866.2140.451.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-14 at 20:08 +0100, Joakim Tjernlund wrote:
> Dan Malek <dan@embeddedalley.com> wrote on 14/11/2009 19:08:43:
> > On Nov 14, 2009, at 2:42 AM, Joakim Tjernlund wrote:
> >
> > > ..... Avoid this by always pinning
> > > kernel instruction TLB space.
> >
> > You may as well map the data space, too, since you have
> > reserved the entries.  Take advantage of that performance.
> > Also, some processor variants have very few TLB entries,
> > and may only reserve two entries (although the flag says
> > reserve 4).  Ensure there are sufficient resources to do
> > what you want.  This is the reason the option is configurable.
> 
> Scott had some concerns about pinning the data space too. That is
> is why I left the data TLB pinning behind the the config option.
> 
> How to make better use of the remaining ITLB slots is tricky.
> Somehow one would want to map at lest one to modules but I cannot see how.

No. If you use modules, you pay the price. Sane embedded solutions
running in "tight" environments don't use modules :-) No point pinning
TLB entries on the vmalloc space, really.

What -might- be more useful is to look at Grant work on re-doing the
early ioremap and providing a way to provide what the old
io_block_mapping() did, but with dynamically chosen virtual addresses,
to have a pinned entry covering most common IOs.

Cheers,
Ben.
