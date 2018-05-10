Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hYqZ577BzF15F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:24:57 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so971706pgc.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 06:24:57 -0700 (PDT)
Date: Thu, 10 May 2018 23:24:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada
 <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/5] powerpc/kbuild: set default generic machine type
 for 32-bit compile
Message-ID: <20180510232440.7374071f@roar.ozlabs.ibm.com>
In-Reply-To: <20180510131002.GN17342@gate.crashing.org>
References: <20180510051659.15356-1-npiggin@gmail.com>
 <20180510051659.15356-2-npiggin@gmail.com>
 <20180510131002.GN17342@gate.crashing.org>
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

On Thu, 10 May 2018 08:10:03 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Thu, May 10, 2018 at 03:16:55PM +1000, Nicholas Piggin wrote:
> > The 64-bit toolchain uses the wrong ISA variant for compiling 32-bit
> > kernels, eve with -m32. Set -mcpu=powerpc which is the generic 32-bit
> > powerpc machine type and scheduling model. 32-bit platforms and CPUs
> > can override this with -mcpu= options that come later on the command
> > line.
> > 
> > This fixes a lot of build failures due to incompatible assembly when
> > compiling 32-bit kernel with 64-bit toolchain.  
> 
> So what ISA is set for gas without this patch?  With what GCC version?

I'm not sure, how do I find that out?

> And, why is that wrong?

Some 32-bit platforms and CPU types do not provide -mcpu, so I assume
for 32-bit toolchains that must result in the "powerpc" machine. With
64-bit toolchains 

arch/powerpc/mm/hash_low_32.S:353: Error: missing operand

Which is,

        tlbie   r4

Is that v2.06?

Thanks,
Nick
