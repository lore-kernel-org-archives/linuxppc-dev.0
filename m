Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hYXS0gKhzF2Cp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:11:51 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id u6-v6so1283432pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 06:11:51 -0700 (PDT)
Date: Thu, 10 May 2018 23:11:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada
 <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/5] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
Message-ID: <20180510231137.2a042713@roar.ozlabs.ibm.com>
In-Reply-To: <878t8rzmr7.fsf@concordia.ellerman.id.au>
References: <20180510051659.15356-1-npiggin@gmail.com>
 <20180510051659.15356-5-npiggin@gmail.com>
 <878t8rzmr7.fsf@concordia.ellerman.id.au>
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

On Thu, 10 May 2018 23:03:08 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The powerpc toolchain can compile combinations of 32/64 bit and
> > big/little endian, so it's convenient to consider, e.g.,
> >
> >   `CC -m64 -mbig-endian`
> >
> > To be the C compiler for the purpose of invoking it to build target
> > artifacts. So overriding the the CC variable to include thse flags
> > works for this purpose.
> >
> > Unfortunately that is not compatible with the way the proposed new
> > Kconfig macro language will work.
> >
> > After previous patches in this series, these flags can be carefully
> > passed in using flags instead.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/Makefile   | 16 +++++++++-------
> >  scripts/recordmcount.pl |  8 ++++++++  
> 
> We should probably at least Cc Rostedt on the recordmcount.pl change.

Sure I'll send another iteration after some more time for reviews and
cc him on it.

> 
> > diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> > index 191eb949d52c..919711dd9d6c 100755
> > --- a/scripts/recordmcount.pl
> > +++ b/scripts/recordmcount.pl
> > @@ -274,6 +274,14 @@ if ($arch eq "x86_64") {  
> 
> Despite what the above says you're patching the powerpc entry AFAICS, so
> I guess that's pretty harmless.

Yeah I didn't think it was worth a separate patch.

> 
> >      if ($bits == 64) {
> >  	$type = ".quad";
> >      }
> > +    $ld .= " -EB ";
> > +    if ($endian eq "big") {
> > +	    $cc .= " -mbig-endian ";
> > +	    $ld .= " -EB ";  
> 
> Don't we end up with two "-EB"s for the big endian case?
> 
> Or do I understand perl even less than I thought I did?

No I was testing things and that's leaked into the commit. Good eye. I
think it worked for le because the next -EL will override the first -EB,
but I'll take that out.

Thanks,
Nick
