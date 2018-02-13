Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zggn2741NzF0s6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 22:49:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
Date: Tue, 13 Feb 2018 22:49:22 +1100
Message-ID: <877erh2jp9.fsf@concordia.ellerman.id.au>
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

Guenter Roeck <linux@roeck-us.net> writes:

> If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
>
> arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> arch/powerpc/platforms/powernv/smp.c:236:4: error:
> 	implicit declaration of function 'crash_ipi_callback'
>
> Add dummy function calls, similar to kdump_in_progress(), to solve the
> problem.
>
> Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")

Personally I prefer these untruncated.

> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/powerpc/include/asm/kexec.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks. Nathan sent a fix for this a few days ago, but I like this
version because it uses the existing #ifdefs.

I've taken this version but used the subject from his patch.

cheers

> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 9dcbfa6bbb91..d8b1e8e7e035 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -140,6 +140,12 @@ static inline bool kdump_in_progress(void)
>  	return false;
>  }
>  
> +static inline void crash_ipi_callback(struct pt_regs *regs) { }
> +
> +static inline void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
> +{
> +}
> +
>  #endif /* CONFIG_KEXEC_CORE */
>  #endif /* ! __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
> -- 
> 2.7.4
