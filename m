Return-Path: <clg@kaod.org>
Received: from 10.mo177.mail-out.ovh.net (10.mo177.mail-out.ovh.net
 [46.105.73.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKpvh6d1KzF0TY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 21:08:13 +1100 (AEDT)
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 42EED96211
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 10:51:14 +0100 (CET)
Subject: Re: [PATCH] powerpc/xive: Properly use static keyword for inline
 function
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20171226130020.23626-1-malat@debian.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <24525a62-208e-b30e-6a53-0f97a2a8fae7@kaod.org>
Date: Mon, 15 Jan 2018 10:51:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171226130020.23626-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/26/2017 02:00 PM, Mathieu Malaterre wrote:
> Fix fatal warning during compilation:
> 
> In file included from arch/powerpc/xmon/xmon.c:54:0:
> ./arch/powerpc/include/asm/xive.h:157:20: error: no previous prototype for ‘xive_smp_prepare_cpu’ [-Werror=missing-prototypes]
>  extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
>                     ^
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 

> ---
>  arch/powerpc/include/asm/xive.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> index 371fbebf1ec9..83dc2cc320a3 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -154,7 +154,7 @@ static inline bool xive_enabled(void) { return false; }
>  static inline bool xive_spapr_init(void) { return false; }
>  static inline bool xive_native_init(void) { return false; }
>  static inline void xive_smp_probe(void) { }
> -extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
> +static inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
>  static inline void xive_smp_setup_cpu(void) { }
>  static inline void xive_smp_disable_cpu(void) { }
>  static inline void xive_kexec_teardown_cpu(int secondary) { }
> 
