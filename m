Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8F111007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 19:30:38 +1100 (EST)
In-Reply-To: <1259032363.16367.108.camel@pasglop>
References: <Received>	
	<1257843644-8496-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1259032363.16367.108.camel@pasglop>
Subject: Re: [PATCH] zlib: Optimize inffast when copying direct from output
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF23DC26B5.C444DA5A-ONC125767A.002E6FF8-C125767A.002EB4D0@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 26 Nov 2009 09:30:09 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 24/11/2009 04:12:43:
>
> On Tue, 2009-11-10 at 10:00 +0100, Joakim Tjernlund wrote:
> > JFFS2 uses lesser compression ratio and inflate always
> > ends up in "copy direct from output" case.
> > This patch tries to optimize the direct copy procedure.
> > Uses get_unaligned() but only in one place.
> > The copy loop just above this one can also use this
> > optimization, but I havn't done so as I have not tested if it
> > is a win there too.
> > On my MPC8321 this is about 17% faster on my JFFS2 root FS
> > than the original.
> > ---
> >
> >  Would like some testing of the PowerPC boot wrapper and
> >  a LE target before sending it upstream.
>
> Well, you should probably submit that patch to lkml then :-)

I have(with LE fixes), Andrew Morton has it.

>
> I'm not sure its going to work to use get_unaligned() like that on all
> archs .. it might be definitely something to discuss on some more
> appropriate mailing list.

Oh, why not? Is that because I am using it wrongly or because xx_unaligned
is impl. incorrectly on some archs?

      Jocke
