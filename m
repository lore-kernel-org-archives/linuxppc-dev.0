Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vgfR6pX5zF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 16:25:51 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id u24-v6so7981262pfn.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 23:25:51 -0700 (PDT)
Date: Tue, 21 Aug 2018 16:25:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/Makefiles: Fix clang/llvm build
Message-ID: <20180821162543.30e7f4b2@roar.ozlabs.ibm.com>
In-Reply-To: <20180821153839.6ce0a287@kryten>
References: <20180821010203.23213-1-anton@ozlabs.org>
 <87ftz8mh60.fsf@concordia.ellerman.id.au>
 <20180821153839.6ce0a287@kryten>
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

On Tue, 21 Aug 2018 15:38:39 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> Hi Michael,
> 
> > This breaks GCC 4.6.3 at least, which we still support:
> > 
> >   Assembler messages:
> >   Error: invalid switch -mpower8
> >   Error: unrecognized option -mpower8
> >   ../scripts/mod/empty.c:1:0: fatal error: error closing -: Broken
> > pipe  
> 
> Yuck. We have POWER8 instructions in our assembly code, and a toolchain
> that doesn't understand the -mpower8 flag, but has support for
> power8 instructions.
> 
> This is what I see on clang with -mpower7:
> 
> /tmp/sstep-2afa55.s:7584: Error: unrecognized opcode: `lbarx'
> /tmp/sstep-2afa55.s:7626: Error: unrecognized opcode: `stbcx.'
> /tmp/sstep-2afa55.s:8077: Error: unrecognized opcode: `lharx'
> /tmp/sstep-2afa55.s:8140: Error: unrecognized opcode: `stbcx.'
> 
> Nick: any suggestions?

 cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-mpower8,-Wa$(comma)-mpower4)

?

Thanks,
Nick
