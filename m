Return-Path: <paul@paul-moore.com>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE5DC1A0A7C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 06:16:05 +1100 (AEDT)
Received: by mail-qc0-f175.google.com with SMTP id b13so4375313qcw.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Dec 2014 11:16:02 -0800 (PST)
Date: Mon, 08 Dec 2014 11:16:01 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH V3] powerpc: add little endian flag to syscall_get_arch()
Message-ID: <1643683.8UjTltLcbW@sifl>
In-Reply-To: <c1adfab2633f57a745f3e2e1b13b5a8f283c888a.1418055157.git.rgb@redhat.com>
References: <c1adfab2633f57a745f3e2e1b13b5a8f283c888a.1418055157.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: tonyj@suse.de, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-audit@redhat.com, anton@samba.org, eparis@parisplace.org,
 sgrubb@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, December 08, 2014 12:59:32 PM Richard Guy Briggs wrote:
> Since both ppc and ppc64 have LE variants which are now reported by uname,
> add that flag (__AUDIT_ARCH_LE) to syscall_get_arch() and add
> AUDIT_ARCH_PPC*LE variants.
> 
> Without this,  perf trace and auditctl fail.
> 
> Mainline kernel reports ppc64le (per a058801) but there is no matching
> AUDIT_ARCH_PPC64LE.
> 
> Since 32-bit PPC LE is not supported, throw a compiler error rather than
> return a bogus architecture to audit.
> 
> See:
> 	https://www.redhat.com/archives/linux-audit/2014-August/msg00082.html
> 	https://www.redhat.com/archives/linux-audit/2014-December/msg00004.html
> 
> v2 -> v3:
> 	Throw a compiler error on 32-bit LE.
> 
> v1 -> v2:
> 	Added ";" at the end of the #ifdef-protected line so it actually compiles
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  arch/powerpc/include/asm/syscall.h |    7 +++++++
>  include/uapi/linux/audit.h         |    1 +
>  2 files changed, 8 insertions(+), 0 deletions(-)

Looks reasonable to me from an audit perspective, but I'll let the ppc folks 
merge this patch into their tree.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/arch/powerpc/include/asm/syscall.h
> b/arch/powerpc/include/asm/syscall.h index 6fa2708..cf7fcab 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -90,6 +90,13 @@ static inline void syscall_set_arguments(struct
> task_struct *task,
> 
>  static inline int syscall_get_arch(void)
>  {
> +#ifdef __LITTLE_ENDIAN__
> +	return AUDIT_ARCH_PPC64LE;
> +#ifndef CONFIG_64BIT
> +#error PPC 32-bit Little Endian architecture not supported.
> +#endif /* CONFIG_64BIT */
> +#else /* __LITTLE_ENDIAN__ */
>  	return is_32bit_task() ? AUDIT_ARCH_PPC : AUDIT_ARCH_PPC64;
> +#endif /* __LITTLE_ENDIAN__ */
>  }
>  #endif	/* _ASM_SYSCALL_H */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 4d100c8..fa2a6af 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -365,6 +365,7 @@ enum {
>  #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_PPC		(EM_PPC)
>  #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
> +#define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_S390		(EM_S390)
>  #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_SH		(EM_SH)

-- 
paul moore
www.paul-moore.com
