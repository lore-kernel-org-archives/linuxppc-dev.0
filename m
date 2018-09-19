Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FX3X6XpJzF3Hm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 17:46:00 +1000 (AEST)
Received: by mail-qk1-x742.google.com with SMTP id g197-v6so2503363qke.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 00:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-5-joel@jms.id.au>
 <CAKwvOd=-22J2=QvCTOAxkWw-WV8C4VY6Yvx91Rif5STmiXMtMg@mail.gmail.com>
In-Reply-To: <CAKwvOd=-22J2=QvCTOAxkWw-WV8C4VY6Yvx91Rif5STmiXMtMg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Sep 2018 17:15:46 +0930
Message-ID: <CACPK8XdF=orE8UtGu_K=p612L=iuDsnmrVrXJ6CNn6iDXi8znQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] powerpc: Fix duplicate const clang warning in user
 access code
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 15 Sep 2018 at 03:27, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Anton Blanchard <anton@samba.org>
> >
> > This re-applies b91c1e3e7a6f which was reverted in f2ca80905929
> > d466f6c5cac1 f84ed59a612d (powerpc/sparse: Constify the address pointer
> > ...").
> >
> > We see a large number of duplicate const errors in the user access
> > code when building with llvm/clang:
> >
> >   include/linux/pagemap.h:576:8: warning: duplicate 'const' declaration specifier
> >       [-Wduplicate-decl-specifier]
> >         ret = __get_user(c, uaddr);
> >
> > The problem is we are doing const __typeof__(*(ptr)), which will hit the
> > warning if ptr is marked const.
> >
> > Removing const does not seem to have any effect on GCC code generation.
>
> I wouldn't expect it to for a local variable with such localized
> usage.  I myself am quite liberal in applying `const` to everything,
> so I will try to fix this in Clang as well, but this should silence
> the warning for users of older versions of Clang and results in no
> functional change.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Nick has written a clang patch that suppresses the warning in the same
way as GCC. Assuming it gets merged, as we depend on clang-8 we could
chose to not merge the kernel patch.

https://reviews.llvm.org/D52248

Cheers,

Joel
