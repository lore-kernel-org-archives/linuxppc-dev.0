Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZWzJ2XT6zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 13:38:20 +1100 (AEDT)
Message-ID: <1459305500.25307.11.camel@ellerman.id.au>
Subject: Re: [PATCH] perf jit: genelf makes assumptions about endian
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, eranian@google.com,
 sukadev@linux.vnet.ibm.com, acme@redhat.com, cel@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Mar 2016 13:38:20 +1100
In-Reply-To: <20160329175944.33a211cc@kryten>
References: <20160329175944.33a211cc@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-29 at 17:59 +1100, Anton Blanchard wrote:

> Commit 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> incorrectly assumed that PowerPC is big endian only.
> 
> Simplify things by consolidating the define of GEN_ELF_ENDIAN and checking
> for __BYTE_ORDER == __BIG_ENDIAN.
> 
> The PowerPC checks were also incorrect, they do not match what gcc
> emits. We should first look for __powerpc64__, then __powerpc__.
> 
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Signed-off-by: Anton Blanchard <anton@samba.org>

The diff's a little hard to read because you're pulling the endian logic out,
if I remove that I get something like:

>  #elif defined(__i386__)
>  #define GEN_ELF_ARCH	EM_386
>  #define GEN_ELF_CLASS	ELFCLASS32
> -#elif defined(__ppcle__)
> -#define GEN_ELF_ARCH	EM_PPC
> -#define GEN_ELF_CLASS	ELFCLASS64
> -#elif defined(__powerpc__)
> -#define GEN_ELF_ARCH	EM_PPC64
> -#define GEN_ELF_CLASS	ELFCLASS64
> -#elif defined(__powerpcle__)
> +#elif defined(__powerpc64__)
>  #define GEN_ELF_ARCH	EM_PPC64
>  #define GEN_ELF_CLASS	ELFCLASS64
> +#elif defined(__powerpc__)
> +#define GEN_ELF_ARCH	EM_PPC
> +#define GEN_ELF_CLASS	ELFCLASS32
>  #else
>  #error "unsupported architecture"
>  #endif

Which looks correct to me.

And the consolidation of the endian logic is "obviously correct", so:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
