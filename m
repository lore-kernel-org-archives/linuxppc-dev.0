Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Kz325N6zDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 18:41:18 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i6so19811000pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 01:41:18 -0700 (PDT)
Date: Fri, 5 Aug 2016 18:41:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Fengguang Wu
 <fengguang.wu@intel.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160805184108.7fc3dbd0@roar.ozlabs.ibm.com>
In-Reply-To: <20160804170640.GC22744@gate.crashing.org>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <1880505.MpH3ISbtMJ@wuerfel>
 <20160804214713.4baa832e@roar.ozlabs.ibm.com>
 <2405930.iJXNaXEjI5@wuerfel>
 <20160804170640.GC22744@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 4 Aug 2016 12:06:41 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Thu, Aug 04, 2016 at 06:10:57PM +0200, Arnd Bergmann wrote:
> > On Thursday, August 4, 2016 9:47:13 PM CEST Nicholas Piggin wrote:
> >   
> > > +	__used							\
> > > +	__attribute__((section("___kentry" "+" #sym ",\"a\",@note #"), used)) \  
> > 
> > 
> > I've just started testing this, but the first problem I ran into
> > is that @ and # are special characters that have an architecture
> > specific meaning to the assembler. On ARM, you need "%note @" instead
> > of "@note #".  
> 
> That comment trick (I still feel guilty about it) causes more problems
> than it solves.  Please don't try to use it :-)

Yeah that's a funny hack. I don't think it's required though, but I'm just
running through some more tests.

I think I found an improvement with the thin archives as well -- we were
still building symbol table after removing the s option (that only avoids
index). "S" is required to not build symbol table.

I'll send out an RFC on a slightly more polished patch series shortly.

Thanks,
Nick
