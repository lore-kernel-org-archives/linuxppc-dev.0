Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTkpm5hRhzDqcH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:30:40 +1000 (AEST)
Message-ID: <1495189806.3092.111.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of
 whole rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Joel
 Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 May 2017 20:30:06 +1000
In-Reply-To: <20170515130754.59363-5-ivan@de.ibm.com>
References: <20170515130754.59363-5-ivan@de.ibm.com>
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

On Mon, 2017-05-15 at 16:07 +0300, Ivan Mikhaylov wrote:
> +#ifdef CONFIG_FSP2
> +       /*
> +        * Prevent a kernel panic caused by unintentionally clearing TCR
> +        * watchdog bits.  At this point in the kernel boot, the watchdog has
> +        * already been enabled by u-boot.  The original code's attempt to
> +        * write to the TCR register results in an inadvertent clearing of the
> +        * watchdog configuration bits, causing the 440 to reset.
> +        */
> +       tcr = mfspr(SPRN_TCR);
> +       tcr &= TCR_WP_MASK; /* clear all bits except for TCR[WP] */
> +       tcr |= TCR_DIE; /* enable decrementer */
> +       mtspr(SPRN_TCR, tcr);
> +#else

This should be a runtime test, not a compile time option.

Cheers,
Ben.
