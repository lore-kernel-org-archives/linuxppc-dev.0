Return-Path: <Maciej.Rozycki@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id EB92F1A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 01:21:34 +1100 (AEDT)
Date: Sat, 30 Jan 2016 14:20:24 +0000
From: "Maciej W. Rozycki" <macro@imgtec.com>
To: Brian Norris <computersforpeace@gmail.com>
CC: Joe Perches <joe@perches.com>, Michal Marek <mmarek@suse.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@au1.ibm.com>, Ian
 Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Olof
 Johansson <olof@lixom.net>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
In-Reply-To: <20160107201826.GA120952@google.com>
Message-ID: <alpine.DEB.2.00.1601301413370.5958@tp.orcam.me.uk>
References: <20160107185406.GA65420@google.com>
 <1452195444.4028.21.camel@perches.com> <568EC026.2020207@suse.com>
 <1452196651.4028.31.camel@perches.com> <20160107201826.GA120952@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 7 Jan 2016, Brian Norris wrote:

> > Perhaps most uses of -Werror without some CONFIG_<FOO> guard
> > should be removed or replaced by some other mechanism.
> 
> +1000. I'd personally like to see all one-off uses of -Werror removed.
> 
> > $ git grep -E "=\s*\-Werror" | grep -v CONFIG
> > [...]
> > arch/alpha/lib/Makefile:ccflags-y := -Werror
> > arch/alpha/mm/Makefile:ccflags-y := -Werror
> > arch/alpha/oprofile/Makefile:ccflags-y := -Werror -Wno-sign-compare
> > arch/metag/oprofile/Makefile:ccflags-y	+= -Werror
> > arch/mips/Kbuild:subdir-ccflags-y := -Werror
> 
> ^^ I always patch this one out when build-testing MIPS, since I like to
> turn up warning levels (e.g., W=1), but not kill the build entirely.

 The MIPS port switched on -Werror years ago, because people submitted 
awful code and couldn't be bothered unless the build crashed.  You're 
welcome to patch your own tree, however I maintain it was a very good 
decision, and TBH I think -Werror should be on globally.

  Maciej
