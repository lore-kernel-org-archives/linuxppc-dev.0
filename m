Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vfc04kgLzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 15:38:40 +1000 (AEST)
Date: Tue, 21 Aug 2018 15:38:39 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/Makefiles: Fix clang/llvm build
Message-ID: <20180821153839.6ce0a287@kryten>
In-Reply-To: <87ftz8mh60.fsf@concordia.ellerman.id.au>
References: <20180821010203.23213-1-anton@ozlabs.org>
 <87ftz8mh60.fsf@concordia.ellerman.id.au>
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

Hi Michael,

> This breaks GCC 4.6.3 at least, which we still support:
> 
>   Assembler messages:
>   Error: invalid switch -mpower8
>   Error: unrecognized option -mpower8
>   ../scripts/mod/empty.c:1:0: fatal error: error closing -: Broken
> pipe

Yuck. We have POWER8 instructions in our assembly code, and a toolchain
that doesn't understand the -mpower8 flag, but has support for
power8 instructions.

This is what I see on clang with -mpower7:

/tmp/sstep-2afa55.s:7584: Error: unrecognized opcode: `lbarx'
/tmp/sstep-2afa55.s:7626: Error: unrecognized opcode: `stbcx.'
/tmp/sstep-2afa55.s:8077: Error: unrecognized opcode: `lharx'
/tmp/sstep-2afa55.s:8140: Error: unrecognized opcode: `stbcx.'

Nick: any suggestions?

Thanks,
Anton
