Return-Path: <will.deacon@arm.com>
Received: from foss-mx-na.foss.arm.com (foss-mx-na.foss.arm.com
 [217.140.108.86])
 by lists.ozlabs.org (Postfix) with ESMTP id 2E31C1A0ED0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 22:30:16 +1100 (AEDT)
Date: Wed, 7 Jan 2015 11:30:05 +0000
From: Will Deacon <will.deacon@arm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] jump_label: Allow asm/jump_label.h to be included in
 assembly
Message-ID: <20150107113004.GJ7485@arm.com>
References: <1420626958-31254-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420626958-31254-1-git-send-email-anton@samba.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "liuj97@gmail.com" <liuj97@gmail.com>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "jbaron@akamai.com" <jbaron@akamai.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "mmarek@suse.cz" <mmarek@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2015 at 10:35:56AM +0000, Anton Blanchard wrote:
> Wrap asm/jump_label.h for all archs with #ifndef __ASSEMBLY__.
> Since these are kernel only headers, we don't need #ifdef __KERNEL__
> so can simplify things a bit.
> 
> If an architecture wants to use jump labels in assembly, it
> will still need to define a macro to create the __jump_table
> entries (see ARCH_STATIC_BRANCH in the powerpc asm/jump_label.h
> for an example).
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/arm/include/asm/jump_label.h   | 5 ++---
>  arch/arm64/include/asm/jump_label.h | 8 ++++----
>  arch/mips/include/asm/jump_label.h  | 7 +++----
>  arch/s390/include/asm/jump_label.h  | 3 +++
>  arch/sparc/include/asm/jump_label.h | 5 ++---
>  arch/x86/include/asm/jump_label.h   | 5 ++---
>  6 files changed, 16 insertions(+), 17 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 076a1c7..c0e5165 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -18,11 +18,12 @@
>   */
>  #ifndef __ASM_JUMP_LABEL_H
>  #define __ASM_JUMP_LABEL_H
> +
> +#ifndef __ASSEMBLY__
> +
>  #include <linux/types.h>
>  #include <asm/insn.h>
>  
> -#ifdef __KERNEL__
> -
>  #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
>  
>  static __always_inline bool arch_static_branch(struct static_key *key)
> @@ -39,8 +40,6 @@ l_yes:
>  	return true;
>  }
>  
> -#endif /* __KERNEL__ */
> -
>  typedef u64 jump_label_t;
>  
>  struct jump_entry {
> @@ -49,4 +48,5 @@ struct jump_entry {
>  	jump_label_t key;
>  };
>  
> +#endif  /* __ASSEMBLY__ */
>  #endif	/* __ASM_JUMP_LABEL_H */

The arm64 bit looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
