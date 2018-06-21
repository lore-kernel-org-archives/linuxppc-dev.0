Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BKDS0sSZzF0tX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 21:27:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/32: Remove left over function prototypes
In-Reply-To: <20180620190038.3250-1-malat@debian.org>
References: <20180408194821.19682-1-malat@debian.org>
 <20180620190038.3250-1-malat@debian.org>
Date: Thu, 21 Jun 2018 21:27:18 +1000
Message-ID: <87602cfkh5.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <malat@debian.org> writes:

> In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")

I don't have that commit ^ ?

That might be because I squashed some of your fixes together or something?

> diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
> index 35ca309848d7..829ed66f0a40 100644
> --- a/arch/powerpc/kernel/setup.h
> +++ b/arch/powerpc/kernel/setup.h
> @@ -19,9 +19,6 @@ void irqstack_early_init(void);
>  void setup_power_save(void);
>  unsigned long __init early_init(unsigned long dt_ptr);
>  void __init machine_init(u64 dt_ptr);
> -int __init ppc_setup_l2cr(char *str);
> -int __init ppc_setup_l3cr(char *str);
> -int __init ppc_init(void);
>  #else
>  static inline void setup_power_save(void) { };
>  #endif

I have:

#ifdef CONFIG_PPC32
void setup_power_save(void);
#else
static inline void setup_power_save(void) { };
#endif


cheers
