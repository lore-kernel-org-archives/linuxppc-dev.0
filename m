Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 6DE5EDDE1A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 06:49:04 +1000 (EST)
Date: Sun, 3 May 2009 22:51:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: unexpected non-allocatable section
Message-ID: <20090503205103.GA1506@uranus.ravnborg.org>
References: <20090502224126.641c63bf@lappy.seanm.ca>
	<20090503204546.691ec6e7.sfr@canb.auug.org.au>
	<20090503123959.0cc5c967@lappy.seanm.ca>
	<20090503193316.E72BC83420E8@gemini.denx.de>
	<20090503200701.GA32601@uranus.ravnborg.org>
	<20090503201940.82D3083420E8@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090503201940.82D3083420E8@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I ran the tests on a LE machine:
> 
> Linux gemini.denx.de 2.6.27.15-170.2.24.fc10.i686 #1 SMP Wed Feb 11 23:58:12 EST 2009 i686 i686 i386 GNU/Linux
> 
> > I will push the patch in a few minutes.
> > 
> > For reference it is below:
> > 
> > 	Sam
> > 
> > From: Anders Kaseorg <andersk@MIT.EDU>
> > Subject: [PATCH] kbuild, modpost: fix unexpected non-allocatable section when cross compiling
> > 
> > The missing TO_NATIVE(sechdrs[i].sh_flags) was causing many
> > unexpected non-allocatable section warnings when cross-compiling
> > for an architecture with a different endianness.
> 
> I'm confused. Why didn't I see this, then?

Maybe they just scrolled past the screen first time?
You need to do "rm vmlinux.o" to reproduce it.

The warnings are shown when we do section mismatch analysis on vmlinux.o
which is part of the final steps in creating vmlinux.
But you will force the check again if you only delete vmlinux.

You need to delete vmlinux.o to see them.

I hope this is the explanation - otherwise I have no good idea.

	Sam
