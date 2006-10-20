Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out01.orange.fr (unknown [193.252.23.120])
	by ozlabs.org (Postfix) with ESMTP id AB38367B99
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 17:40:52 +1000 (EST)
Date: Fri, 20 Oct 2006 09:36:53 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020073653.GB17286@powerlinux.fr>
References: <20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<1161328372.10524.170.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161328372.10524.170.camel@localhost.localdomain>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, Olaf Hering <olaf@aepfle.de>, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 05:12:52PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Exact, it is not about poluting, but about rationalizing. The fact is that
> > these are the two infos that are the most necessary to userland, then why
> > disseminate the info in thousand different places, instead of making it easily
> > available in a canonical place in a standard format for everyone ? 
> 
> Why would that be absolutely necessary to userland ? We've lived very
> well without that so far.

Because i already coded at least 4 times in 4 different places, code which
does the differentiation for userland, and it is only in debian. All other
distributions have this kind of code in their own individual way.

And if there is a new hardware coming out you didn't think about, it is not
enough to add support in the kernel, but you have to change all those userland
tools all over the place, with load of chances to forget something and break
them.

The kernel knows about this, and it would be easy enough to pass that
information clearly to userland. /proc/device-tree is indeed a solution for
this part.

> > > About 32bit/64bit, maybe VmallocTotal from /proc/meminfo can be used.
> > > incredible large numer == must be a 64bit kernel
> > > No idea how reliable it is. There are those 36bit systems, but I bet
> > > they dont run a distro.
> > 
> > This sounds like the ugliest hack i have seen around, and is prone to break. A
> > proper /proc/cpuinfo flag would be most welcome to solve this cleanly.
> 
> uname is your friend... damn, and if you want to be real sure, then just
> try to run a 64 bits binary and see what happens :)

Why not say it directly in a standard way ? So we avoid all distros and/or
different tools who need to know, to implement their own slightly different
way ? 

Friendly,

Sven Luther
