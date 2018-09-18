Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F0Gj1wwwzDq61
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 20:53:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, Nick Desaulniers <ndesaulniers@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/boot: Fix crt0.S syntax for clang
In-Reply-To: <CACPK8XeWojwrQ08gzr7=YgCKFfgLt3H81V699W=9FYyyF32UZw@mail.gmail.com>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-3-joel@jms.id.au>
 <CAKwvOdmKvxmh+Vb1UcUzOsYOsK6gjn7v62X=SpwuhimBhdM7ng@mail.gmail.com>
 <20180914210840.GT23155@gate.crashing.org>
 <CAKwvOd=gf_G4SaZh3feqBZgZh=WXisRvJosrYzq20gtSOsao5Q@mail.gmail.com>
 <CACPK8XeWojwrQ08gzr7=YgCKFfgLt3H81V699W=9FYyyF32UZw@mail.gmail.com>
Date: Tue, 18 Sep 2018 20:53:48 +1000
Message-ID: <87sh27axfn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> writes:

> On Tue, 18 Sep 2018 at 06:11, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Fri, Sep 14, 2018 at 2:08 PM Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> >
>> > On Fri, Sep 14, 2018 at 10:47:08AM -0700, Nick Desaulniers wrote:
>> > > On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
>> > > >  10:    addis   r12,r12,(-RELACOUNT)@ha
>> > > > -       cmpdi   r12,RELACOUNT@l
>> > > > +       cmpdi   r12,(RELACOUNT)@l
>> > >
>> > > Yep, as we can see above, when RELACOUNT is negated, it's wrapped in
>> > > parens.
>>
>> Looks like this was just fixed in Clang-8:
>> https://bugs.llvm.org/show_bug.cgi?id=38945
>> https://reviews.llvm.org/D52188
>
> Nice!
>
> mpe, given we need the local references to labels fix which is also in
> clang-8 I suggest we drop this patch.

OK, no worries.

cheers
