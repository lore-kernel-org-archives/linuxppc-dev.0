Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJWfZ2zZRzDvgr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 15:36:06 +1100 (AEDT)
Message-ID: <1479270952.2608.82.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9 DD1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 Nov 2016 15:35:52 +1100
In-Reply-To: <20161116041820.28433-1-mikey@neuling.org>
References: <20161116041820.28433-1-mikey@neuling.org>
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

On Wed, 2016-11-16 at 15:18 +1100, Michael Neuling wrote:
> +               asm volatile("isync \n"
> +                            PPC_SLBIA(0x7)
> +                            : : :"memory");
>         return;
>  }
> 
We probably don't need the isync's

> @@ -83,6 +87,10 @@ static inline void _tlbiel_va(unsigned long va,
> unsigned long pid,
>         asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>                      : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs)
> : "memory");
>         asm volatile("ptesync": : :"memory");
> +       if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +               asm volatile("isync \n"
> +                            PPC_SLBIA(0x7)
> +                            : : :"memory");
>  }
