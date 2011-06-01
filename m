Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DFF5B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 13:49:13 +1000 (EST)
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <alpine.DEB.2.01.1105311959000.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<1306887942.29297.10.camel@pasglop>
	<alpine.DEB.2.01.1105311744000.21697@trent.utfs.org>
	<alpine.DEB.2.01.1105311959000.21697@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Jun 2011 13:49:03 +1000
Message-ID: <1306900143.29297.13.camel@pasglop>
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-31 at 20:02 -0700, Christian Kujau wrote:
> (Cc'in Linus)
> 
> On Tue, 31 May 2011 at 17:48, Christian Kujau wrote:
> > In the meantime, "git bisect" behaves kinda weird, I don't know what went 
> > wrong here:
> > 
> >  $ git bisect start
> >  $ git bisect good         # Linux 2.6.39
> >  $ git bisect bad v3.0-rc1 # Linux 3.0-rc1
> >  $ git bisect bad          # c44dead70a...
> >  $ git bisect bad          # d93515611b..
> > 
> > ...yet the ./Makefile shows[0] that I'm already way behind: 2.6.39-rc2. 
> > Maybe "git bisect" got confused with that whole 2.6.x -> 3.0 renaming?
> 
> Hm, I tried again, from a clean v3.0-rc1 (git reset --hard), but after the 
> 2nd "git bad" I'm at 2.6.39-rc2 again - while I /should/ be somwhere 
> inbetween v2.6.39..v3.0-rc1, right?

Kernel version is totally irrelevant when bisecting. You are not walking
through a linear series of patches but a complex tree of merges which
might have forked off different versions in the first place.

Cheers,
Ben.
