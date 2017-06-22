Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthfl0L11zDqjH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:06:23 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y7so2856114pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:06:22 -0700 (PDT)
Date: Thu, 22 Jun 2017 23:06:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/6] powerpc64/elfv1: Validate function pointer
 address in the function descriptor
Message-ID: <20170622230604.0b0d5338@roar.ozlabs.ibm.com>
In-Reply-To: <87d19ws2xm.fsf@concordia.ellerman.id.au>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <701603cefa05559fec722e6cb809ae6afd0648e6.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622132224.58edf1f5@roar.ozlabs.ibm.com>
 <87d19ws2xm.fsf@concordia.ellerman.id.au>
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

On Thu, 22 Jun 2017 20:59:49 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Thu, 22 Jun 2017 00:08:37 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >  
> >> Currently, we assume that the function pointer we receive in
> >> ppc_function_entry() points to a function descriptor. However, this is
> >> not always the case. In particular, assembly symbols without the right
> >> annotation do not have an associated function descriptor. Some of these
> >> symbols are added to the kprobe blacklist using _ASM_NOKPROBE_SYMBOL().
> >> When such addresses are subsequently processed through
> >> arch_deref_entry_point() in populate_kprobe_blacklist(), we see the
> >> below errors during bootup:
> >>     [    0.663963] Failed to find blacklist at 7d9b02a648029b6c
> >>     [    0.663970] Failed to find blacklist at a14d03d0394a0001
> >>     [    0.663972] Failed to find blacklist at 7d5302a6f94d0388
> >>     [    0.663973] Failed to find blacklist at 48027d11e8610178
> >>     [    0.663974] Failed to find blacklist at f8010070f8410080
> >>     [    0.663976] Failed to find blacklist at 386100704801f89d
> >>     [    0.663977] Failed to find blacklist at 7d5302a6f94d00b0
> >> 
> >> Fix this by checking if the address in the function descriptor is
> >> actually a valid kernel address. In the case of assembly symbols, this
> >> will almost always fail as this ends up being powerpc instructions. In
> >> that case, return pointer to the address we received, rather than the
> >> dereferenced value.
> >> 
> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/code-patching.h | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> >> index abef812de7f8..ec54050be585 100644
> >> --- a/arch/powerpc/include/asm/code-patching.h
> >> +++ b/arch/powerpc/include/asm/code-patching.h
> >> @@ -83,8 +83,16 @@ static inline unsigned long ppc_function_entry(void *func)
> >>  	 * On PPC64 ABIv1 the function pointer actually points to the
> >>  	 * function's descriptor. The first entry in the descriptor is the
> >>  	 * address of the function text.
> >> +	 *
> >> +	 * However, we may have received a pointer to an assembly symbol
> >> +	 * that may not be a function descriptor. Validate that the entry
> >> +	 * points to a valid kernel address and if not, return the pointer
> >> +	 * we received as is.
> >>  	 */
> >> -	return ((func_descr_t *)func)->entry;
> >> +	if (kernel_text_address(((func_descr_t *)func)->entry))
> >> +		return ((func_descr_t *)func)->entry;
> >> +	else
> >> +		return (unsigned long)func;  
> >
> > What if "func" is a text section label (bare asm function)?
> > Won't func->entry load the random instruction located there
> > and compare it with a kernel address?  
> 
> Yes, that's the problem.
> 
> > I don't know too much about the v1 ABI, but should we check for
> > func belonging in the .opd section first and base the check on
> > that? Alternatively I if "func" is in the kernel text address,
> > we can recognize it's not in the .opd section... right?  
> 
> That sounds like a more robust solution. But I suspect it won't work for
> modules.

kernel_text_address() seems to check for module text as well, so it
might work I think?
