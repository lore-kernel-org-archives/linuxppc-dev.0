Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0105.outbound.protection.outlook.com [157.56.110.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 675361A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 12:34:32 +1000 (AEST)
Message-ID: <1430793259.16357.231.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: fix the dependency issue for CRASH_DUMP
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 4 May 2015 21:34:19 -0500
In-Reply-To: <20150505022743.GB24874@pek-khao-d1.corp.ad.wrs.com>
References: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
 <1430396997-14656-2-git-send-email-haokexin@gmail.com>
 <1430777837.16357.227.camel@freescale.com>
 <20150505022743.GB24874@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 10:27 +0800, Kevin Hao wrote:
> On Mon, May 04, 2015 at 05:17:17PM -0500, Scott Wood wrote:
> > On Thu, 2015-04-30 at 20:29 +0800, Kevin Hao wrote:
> > > In the current code, the RELOCATABLE will be forcedly enabled when
> > > enabling CRASH_DUMP. But for ppc32, the RELOCABLE also depend on
> > > ADVANCED_OPTIONS and select NONSTATIC_KERNEL. This will cause build
> > > error when CRASH_DUMP=y && ADVANCED_OPTIONS=n. Even there is no such
> > > issue for ppc64, but select is only for non-visible symbols and for
> > > symbols with no dependencies. As for a symbol like RELOCATABLE, it is
> > > definitely not suitable to select it. So choose to depend on it.
> > 
> > Why is it "definitely not suitable to select it", provided the
> > ADVANCED_OPTIONS dependency is removed, and the FLATMEM dependency is
> > moved to places that select RELOCATABLE?
> 
> Even with this change, the definition of RELOCATABLE still be something like
> this:
>     config RELOCATABLE
>            bool "Build a relocatable kernel"
>            depends on (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
>            select NONSTATIC_KERNEL

That matches the cases where CRASH_DUMP selects RELOCATABLE.

> Quoted form Documentation/kbuild/kconfig-language.txt:
>         select should be used with care. select will force
>         a symbol to a value without visiting the dependencies.
>         By abusing select you are able to select a symbol FOO even
>         if FOO depends on BAR that is not set.
>         In general use select only for non-visible symbols
>         (no prompts anywhere) and for symbols with no dependencies.
>         That will limit the usefulness but on the other hand avoid
>         the illegal configurations all over.
> 
> So it is always error prone to select a kernel option like this.

Yes, but these days Kbuild does warn about selecting a symbol with unmet
dependencies, which IIRC wasn't the case when that was written.

> >  It seems wrong that the user
> > should have to enable ADVANCED_OPTIONS to even see the option to build a
> > crash kernel.
> 
> Yes, it seems ridiculous. But this is fixed in the patch 2.

OK...  Still non-obvious, but at least not *as* bad.

-Scott
