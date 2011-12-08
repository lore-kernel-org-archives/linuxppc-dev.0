Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4755E1007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 20:48:36 +1100 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
 by fallback.mail.elte.hu with esmtp (Exim) id 1RYZE5-0004XV-Ms
 from <mingo@elte.hu>
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Dec 2011 09:21:09 +0100
Date: Thu, 8 Dec 2011 09:16:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH] PPC: Add __SANE_USERSPACE_TYPES__ to asm/types.h for LL64
Message-ID: <20111208081614.GA19697@elte.hu>
References: <4EE05FC5.9000701@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EE05FC5.9000701@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Matt Evans <matt@ozlabs.org> wrote:

> PPC64 uses long long for u64 in the kernel, but powerpc's asm/types.h
> prevents 64-bit userland from seeing this definition, instead defaulting
> to u64 == long in userspace.  Some user programs (e.g. kvmtool) may actually
> want LL64, so this patch adds a check for __SANE_USERSPACE_TYPES__ so that,
> if defined, int-ll64.h is included instead.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  arch/powerpc/include/asm/types.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
> index 8947b98..d82e94e 100644
> --- a/arch/powerpc/include/asm/types.h
> +++ b/arch/powerpc/include/asm/types.h
> @@ -5,8 +5,11 @@
>   * This is here because we used to use l64 for 64bit powerpc
>   * and we don't want to impact user mode with our change to ll64
>   * in the kernel.
> + *
> + * However, some user programs are fine with this.  They can
> + * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.
>   */
> -#if defined(__powerpc64__) && !defined(__KERNEL__)
> +#if !defined(__SANE_USERSPACE_TYPES__) && defined(__powerpc64__) && !defined(__KERNEL__)

Acked-by: Ingo Molnar <mingo@elte.hu>

Any other name would work too i guess.

Thanks,

	Ingo
