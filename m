Return-Path: <acme@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb0mG0tCyzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 08:15:26 +1100 (AEDT)
Date: Wed, 30 Mar 2016 18:15:22 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, eranian@google.com,
 sukadev@linux.vnet.ibm.com, cel@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jit: genelf makes assumptions about endian
Message-ID: <20160330211522.GC2793@redhat.com>
References: <20160329175944.33a211cc@kryten>
 <1459305500.25307.11.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459305500.25307.11.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Mar 30, 2016 at 01:38:20PM +1100, Michael Ellerman escreveu:
> On Tue, 2016-03-29 at 17:59 +1100, Anton Blanchard wrote:
> 
> > Commit 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> > incorrectly assumed that PowerPC is big endian only.
> > 
> > Simplify things by consolidating the define of GEN_ELF_ENDIAN and checking
> > for __BYTE_ORDER == __BIG_ENDIAN.
> > 
> > The PowerPC checks were also incorrect, they do not match what gcc
> > emits. We should first look for __powerpc64__, then __powerpc__.
> > 
> > Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> The diff's a little hard to read because you're pulling the endian logic out,
> if I remove that I get something like:

Yeah, I'm taking this patch, but would be better next time to break it
down in two, one doing the reorg, the other doing the actual fix...

Thanks,

- Arnaldo
 
> >  #elif defined(__i386__)
> >  #define GEN_ELF_ARCH	EM_386
> >  #define GEN_ELF_CLASS	ELFCLASS32
> > -#elif defined(__ppcle__)
> > -#define GEN_ELF_ARCH	EM_PPC
> > -#define GEN_ELF_CLASS	ELFCLASS64
> > -#elif defined(__powerpc__)
> > -#define GEN_ELF_ARCH	EM_PPC64
> > -#define GEN_ELF_CLASS	ELFCLASS64
> > -#elif defined(__powerpcle__)
> > +#elif defined(__powerpc64__)
> >  #define GEN_ELF_ARCH	EM_PPC64
> >  #define GEN_ELF_CLASS	ELFCLASS64
> > +#elif defined(__powerpc__)
> > +#define GEN_ELF_ARCH	EM_PPC
> > +#define GEN_ELF_CLASS	ELFCLASS32
> >  #else
> >  #error "unsupported architecture"
> >  #endif
> 
> Which looks correct to me.
> 
> And the consolidation of the endian logic is "obviously correct", so:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> cheers
