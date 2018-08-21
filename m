Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vf8R5MztzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 15:18:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/Makefiles: Fix clang/llvm build
In-Reply-To: <20180821010203.23213-1-anton@ozlabs.org>
References: <20180821010203.23213-1-anton@ozlabs.org>
Date: Tue, 21 Aug 2018 15:18:15 +1000
Message-ID: <87ftz8mh60.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@ozlabs.org> writes:

> From: Anton Blanchard <anton@samba.org>
>
> Commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type to POWER4")
> passes -mpower4 to the assembler. We have more recent instructions in our
> assembly files, but gas permits them. The clang/llvm integrated assembler
> is more strict, and we get a build failure.
>
> Fix this by calling the assembler with -mcpu=power8

This breaks GCC 4.6.3 at least, which we still support:

  Assembler messages:
  Error: invalid switch -mpower8
  Error: unrecognized option -mpower8
  ../scripts/mod/empty.c:1:0: fatal error: error closing -: Broken pipe


cheers
