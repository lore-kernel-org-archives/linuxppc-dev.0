Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29CE1B7CC3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 18:47:52 +1100 (EST)
In-Reply-To: <1263412963.724.223.camel@pasglop>
References: <20100112022150.GE12666@kryten>	
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location of
	autoconf.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 14 Jan 2010 08:47:11 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 13/01/2010 21:02:43:
>
> On Wed, 2010-01-13 at 12:54 -0600, Kumar Gala wrote:
>
> > >
> > > BOOTCFLAGS   += -I$(obj) -I$(srctree)/$(obj)
> > > -BOOTCFLAGS   += -include include/linux/autoconf.h -Iarch/powerpc/include
> > > -BOOTCFLAGS   += -Iinclude
> > > +BOOTCFLAGS   += -include include/generated/autoconf.h
> > > +BOOTCFLAGS   += -I$(srctree)/arch/powerpc/include -I$(srctree)/include
> > >
> > > DTS_FLAGS   ?= -p 1024
> > >
> >
> > Ack, this works for me (seeing as -rc4 doesn't generate uImages w/o it :)
> >
>
> I sent a different patch to Linus yesterday for that.

Seen it now as it is in Linus tree:

1) IMHO it would have been nicer to use #ifdef __KERNEL__
   instead of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
   as then arches that don't define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
   at all will never use the new optimization or was that what you intended?

2) You really should add an comment in the Makefile about not using
   autoconf.h/-D__KERNEL__
