Return-Path: <jstancek@redhat.com>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC57D1A0736
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 06:12:40 +1100 (AEDT)
Date: Sat, 17 Oct 2015 15:12:31 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, thuth@redhat.com,
 dgibson@redhat.com, benh@kernel.crashing.org, stable@vger.kernel.org
Message-ID: <625231787.33064563.1445109151681.JavaMail.zimbra@redhat.com>
In-Reply-To: <1444958435-18808-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1444958435-18808-1-git-send-email-stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] PPC: fix LOGMPP instruction opcode and inline asm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





----- Original Message -----
> From: "Stewart Smith" <stewart@linux.vnet.ibm.com>
> To: linuxppc-dev@lists.ozlabs.org
> Cc: paulus@samba.org, thuth@redhat.com, jstancek@redhat.com, dgibson@redhat.com, benh@kernel.crashing.org, "Stewart
> Smith" <stewart@linux.vnet.ibm.com>, stable@vger.kernel.org
> Sent: Friday, 16 October, 2015 3:20:35 AM
> Subject: [PATCH] PPC: fix LOGMPP instruction opcode and inline asm
> 
> Back in 9678cda when we started using the Micro Partition Prefetch Engine
> in POWER8 for KVM, there were two mistakes introduced from the original
> patch used for investigation and microbenchmarks.
> 
> One mistake was that the opcode was constructed incorrectly, putting
> the register in the wrong field in the opcode, meaning that we were
> asking the chip to read the memory address from some other register than
> what we intended - probably r0. For those unfortunate enough to have r0
> point somewhere in memory they cared about, the prefetch engine would
> gleefully trash all over it leading to some data you cared about being
> replaced with a list of physical addresses.
> 
> In addition, the logmpp inline function incorrectly used R1 rather than
> %0, leading to even if we got the construction of the instruction right,
> we'd still generate the wrong thing, looking at the address in r1 rather
> than whatever we were asked to look at.
> 
> So, this patch fixes the following:
> - the inline logmpp function's inline asm to be correct
> - puts the register in the right field of the instruction
> 
> This bug would overwrite a single 64k page.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1269653
> https://bugzilla.redhat.com/show_bug.cgi?id=1271997
> 
> Cc: stable@vger.kernel.org
> Fixes: 9678cda ("Use the POWER8 Micro Partition Prefetch Engine in KVM HV")
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Tested-by: Jan Stancek <jstancek@redhat.com>

After running a kernel with this patch for 36+ hours, I can no longer
reproduce the user-space corruption I have been seeing.

Previously it reproduced fairly quickly (within hour, on IBM Power S814
[8286-41A], 16GB RAM) by starting/stopping couple KVM guests in loop.

> ---
>  arch/powerpc/include/asm/cache.h      | 2 +-
>  arch/powerpc/include/asm/ppc-opcode.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cache.h
> b/arch/powerpc/include/asm/cache.h
> index 34a05a1a990b..3af1c1e35435 100644
> --- a/arch/powerpc/include/asm/cache.h
> +++ b/arch/powerpc/include/asm/cache.h
> @@ -43,7 +43,7 @@ extern struct ppc64_caches ppc64_caches;
>  
>  static inline void logmpp(u64 x)
>  {
> -	asm volatile(PPC_LOGMPP(R1) : : "r" (x));
> +	asm volatile(PPC_LOGMPP(%0) : : "r" (x));
>  }
>  
>  #endif /* __powerpc64__ && ! __ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h
> b/arch/powerpc/include/asm/ppc-opcode.h
> index 65136928a572..0dc2f6f9b445 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -304,8 +304,8 @@
>  #define PPC_LDARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LDARX | \
>  					___PPC_RT(t) | ___PPC_RA(a) | \
>  					___PPC_RB(b) | __PPC_EH(eh))
> -#define PPC_LOGMPP(b)		stringify_in_c(.long PPC_INST_LOGMPP | \
> -					__PPC_RB(b))
> +#define PPC_LOGMPP(a)		stringify_in_c(.long PPC_INST_LOGMPP | \
> +					___PPC_RA(a))
>  #define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
>  					___PPC_RT(t) | ___PPC_RA(a) | \
>  					___PPC_RB(b) | __PPC_EH(eh))
> --
> 2.1.4
> 
> 
