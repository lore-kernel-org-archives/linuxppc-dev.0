Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 9C856DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 16:01:06 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	l4A5fxeM023532
	for <linuxppc-dev@ozlabs.org> (envelope-from y-goto@jp.fujitsu.com);
	Thu, 10 May 2007 14:42:00 +0900
Date: Thu, 10 May 2007 14:41:07 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Section mismatch warnings (was Re: [PATCH] early_pfn_to_nid needs
	to be __meminit)
In-Reply-To: <1178740693.3086.81.camel@zod.rchland.ibm.com>
References: <20070509194503.GZ4452@austin.ibm.com>
	<1178740693.3086.81.camel@zod.rchland.ibm.com>
Message-Id: <20070510141827.A967.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add to CC: Sam-san. :-)

> On Wed, 2007-05-09 at 14:45 -0500, Linas Vepstas wrote:
> > On Wed, May 09, 2007 at 06:51:15PM +0200, Gabriel Paubert wrote:
> > > On Thu, May 10, 2007 at 02:25:52AM +1000, Stephen Rothwell wrote:
> > > > This removes a section mismatch warning in those circumstances.
> > > 
> > > Speaking of this, I just tried to compile an official (Linus' git tree) 
> > > kernel for my old PMac G4 and I get a lot of section mismatch warnings at 
> > > the end of the compilation:
> > > 
> > > WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference to .init.text:early_get_page from .text between 'pte_alloc_one_kernel' (at offset 0xf50) and 'v_mapped_by_bats'
> > > 
> > > I find these 50 or so warnings so scary that I've not yet tried 
> > > to boot the kernel. Note that this is a non-modular kernel.
> > 
> > I'm getting oodles of these on an older -mm2 tree. The kernels seem to
> > work fine. Yes, they should be fixed but I'm up to my proverbial eyballs
> > in alligators.
> 
> Yeah, I see all kinds of this too.  Does anyone have an idea why they're
> being spit out?  Or if it's related to a particular binutils version,
> etc?

These warnings are showed by scripts/mod/modposts.c. 
It checks section mismatch stricter than before.

Some of them are not defined as __init even if it's called at just
boottime. This is simple to fix.

Second case is that the functions judge which functions
should call (boottime or normal) by themselves.
pte_alloc_one_kernel() looks its case.
In this case, they must be registered in whitelist of modpost.c

Other possibility is they are just rare called functions.
It should be investigated....

Bye.

-- 
Yasunori Goto 
