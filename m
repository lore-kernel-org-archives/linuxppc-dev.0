Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914DB1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 14:35:20 +1100 (AEDT)
Message-ID: <1444102518.16909.3.camel@ellerman.id.au>
Subject: Re: Missing operand for tlbie instruction on Power7
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Tue, 06 Oct 2015 14:35:18 +1100
In-Reply-To: <560EA623.1040300@redhat.com>
References: <560EA623.1040300@redhat.com>
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

On Fri, 2015-10-02 at 08:43 -0700, Laura Abbott wrote:
> Hi,
> 
> We received a report (https://bugzilla.redhat.com/show_bug.cgi?id=1267395) of bad assembly
> when compiling on powerpc with little endian

...

> After some discussion with the binutils folks, it turns out that the tlbie
> instruction actually requires another operand and binutils was updated to
> check for this https://sourceware.org/ml/binutils/2015-05/msg00133.html .
> 
> The code sequence in arch/powerpc/include/asm/ppc_asm.h now needs to be updated:
> 
> #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
> #define tlbia                                   \
>          li      r4,1024;                        \
>          mtctr   r4;                             \
>          lis     r4,KERNELBASE@h;                \
> 0:      tlbie   r4;                             \
>          addi    r4,r4,0x1000;                   \
>          bdnz    0b
> #endif
> 
> I don't know enough ppc assembly to properly fix this but I can test.

How are you testing? This code is fairly old and I'm dubious if it still works.

These days we have a ppc_md hook for flushing the TLB, ppc_md.flush_tlb().
Ideally the swsusp code would use that.

cheers
