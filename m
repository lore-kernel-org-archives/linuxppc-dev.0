Return-Path: <joel.stan@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BKrN29zLzF3TK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 12:55:15 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id n6-v6so7474629qtl.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 19:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180910085714.4834-1-joel@jms.id.au>
 <20180910085714.4834-2-joel@jms.id.au>
 <20180911113228.GF23155@gate.crashing.org>
In-Reply-To: <20180911113228.GF23155@gate.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 14 Sep 2018 12:25:01 +0930
Message-ID: <CACPK8XdNRXTnuRk5vuBxiHu_5bFcg5jG84c3YzQLZk_eGjqPoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/boot: Fix crt0.S syntax for clang
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 Sep 2018 at 21:02, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Sep 10, 2018 at 06:57:13PM +1000, Joel Stanley wrote:
> > Clang's assembler does not like the syntax of the cmpdi:
> >
> >  arch/powerpc/boot/crt0.S:168:22: error: unexpected modifier on variable reference
> >          cmpdi   12,RELACOUNT@l
> >                               ^
> >  arch/powerpc/boot/crt0.S:168:11: error: unknown operand
> >          cmpdi   12,RELACOUNT@l
> >                    ^
> > Enclosing RELACOUNT in () makes it is happy. Tested with GCC 8 and Clang
> > 8 (trunk).
>
> Is clang going to fix this?  You also might want to add a comment that
> this is a workaround for that broken assembler.

I am not sure that we need a comment, it doesn't look too out of place
compared to the other uses of wrapping symbols in ().

I did open a bug against clang though in the hope that they can fix
the behaviour:

 https://bugs.llvm.org/show_bug.cgi?id=38945

Cheers,

Joel
