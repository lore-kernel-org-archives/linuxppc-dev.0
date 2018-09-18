Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DlH52H08zDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 11:08:16 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id g13-v6so128312qki.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 18:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-3-joel@jms.id.au>
 <CAKwvOdmKvxmh+Vb1UcUzOsYOsK6gjn7v62X=SpwuhimBhdM7ng@mail.gmail.com>
 <20180914210840.GT23155@gate.crashing.org>
 <CAKwvOd=gf_G4SaZh3feqBZgZh=WXisRvJosrYzq20gtSOsao5Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=gf_G4SaZh3feqBZgZh=WXisRvJosrYzq20gtSOsao5Q@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 18 Sep 2018 10:38:03 +0930
Message-ID: <CACPK8XeWojwrQ08gzr7=YgCKFfgLt3H81V699W=9FYyyF32UZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] powerpc/boot: Fix crt0.S syntax for clang
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Sep 2018 at 06:11, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Sep 14, 2018 at 2:08 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Fri, Sep 14, 2018 at 10:47:08AM -0700, Nick Desaulniers wrote:
> > > On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> > > >  10:    addis   r12,r12,(-RELACOUNT)@ha
> > > > -       cmpdi   r12,RELACOUNT@l
> > > > +       cmpdi   r12,(RELACOUNT)@l
> > >
> > > Yep, as we can see above, when RELACOUNT is negated, it's wrapped in
> > > parens.
>
> Looks like this was just fixed in Clang-8:
> https://bugs.llvm.org/show_bug.cgi?id=38945
> https://reviews.llvm.org/D52188

Nice!

mpe, given we need the local references to labels fix which is also in
clang-8 I suggest we drop this patch.

Cheers,

Joel
