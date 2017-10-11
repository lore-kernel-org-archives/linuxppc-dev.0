Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBrNF1tYtzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 21:50:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH] powerpc/memkey: feature applies to PPC_BOOK3S_64 archs
 only
In-Reply-To: <20171010162240.GA5362@ram.oc3035372033.ibm.com>
References: <1507565506-17040-1-git-send-email-linuxram@us.ibm.com>
 <87zi8zwf6c.fsf@concordia.ellerman.id.au>
 <20171010161925.GB5334@ram.oc3035372033.ibm.com>
 <20171010162240.GA5362@ram.oc3035372033.ibm.com>
Date: Wed, 11 Oct 2017 21:50:03 +1100
Message-ID: <877ew2yn50.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> Currently protection key feature is erroneously configured to
> be enabled for any flavor of PPC64. This patch fixes it.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 7dee449..4b2b055 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -868,7 +868,7 @@ config PPC64_MEMORY_PROTECTION_KEYS
>  	prompt "PowerPC Memory Protection Keys"
>  	def_bool y
>  	# Note: only available in 64-bit mode
> -	depends on PPC64
> +	depends on PPC_BOOK3S_64
>  	select ARCH_USES_HIGH_VMA_FLAGS
>  	select ARCH_HAS_PKEYS

That didn't really help.

I needed the patch below to get it building.

cheers

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index da0d5e64ffab..28fad534333d 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_PPC64_PKEYS_H
 #define _ASM_PPC64_PKEYS_H
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+
 #include <asm/firmware.h>
 
 extern bool pkey_inited;
@@ -247,4 +249,7 @@ extern void thread_pkey_regs_restore(struct thread_struct *new_thread,
 			struct thread_struct *old_thread);
 extern void thread_pkey_regs_init(struct thread_struct *thread);
 extern void pkey_initialize(void);
+
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #endif /*_ASM_PPC64_PKEYS_H */
