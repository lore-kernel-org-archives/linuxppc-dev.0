Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0172.hostedemail.com
 [216.40.44.172])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D16C1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 04:37:22 +1100 (AEDT)
Message-ID: <1454175435.7329.22.camel@perches.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
From: Joe Perches <joe@perches.com>
To: "Maciej W. Rozycki" <macro@imgtec.com>, Brian Norris
 <computersforpeace@gmail.com>
Cc: Michal Marek <mmarek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Date: Sat, 30 Jan 2016 09:37:15 -0800
In-Reply-To: <alpine.DEB.2.00.1601301413370.5958@tp.orcam.me.uk>
References: <20160107185406.GA65420@google.com>
 <1452195444.4028.21.camel@perches.com> <568EC026.2020207@suse.com>
 <1452196651.4028.31.camel@perches.com> <20160107201826.GA120952@google.com>
 <alpine.DEB.2.00.1601301413370.5958@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-01-30 at 14:20 +0000, Maciej W. Rozycki wrote:
> On Thu, 7 Jan 2016, Brian Norris wrote:
> 
> > > Perhaps most uses of -Werror without some CONFIG_ guard
> > > should be removed or replaced by some other mechanism.
> > 
> > +1000. I'd personally like to see all one-off uses of -Werror removed.
> > 
> > > $ git grep -E "=\s*\-Werror" | grep -v CONFIG
> > > [...]
> > > arch/alpha/lib/Makefile:ccflags-y := -Werror
> > > arch/alpha/mm/Makefile:ccflags-y := -Werror
> > > arch/alpha/oprofile/Makefile:ccflags-y := -Werror -Wno-sign-compare
> > > arch/metag/oprofile/Makefile:ccflags-y	+= -Werror
> > > arch/mips/Kbuild:subdir-ccflags-y := -Werror
> > 
> > ^^ I always patch this one out when build-testing MIPS, since I like to
> > turn up warning levels (e.g., W=1), but not kill the build entirely.
> 
>  The MIPS port switched on -Werror years ago, because people submitted 
> awful code and couldn't be bothered unless the build crashed.  You're 
> welcome to patch your own tree, however I maintain it was a very good 
> decision, and TBH I think -Werror should be on globally.

That'd be easy to do with some CONFIG_COMPILER_ERROR type
rather than in specific directory Makefiles
