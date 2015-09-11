Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7511D1A2BAE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2015 07:35:31 +1000 (AEST)
Message-ID: <1442007315.2909.49.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc32: memcpy: only use dcbz once cache is enabled
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <sojkam1@fel.cvut.cz>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 11 Sep 2015 16:35:15 -0500
In-Reply-To: <20150911143348.F1D9F1A2420@localhost.localdomain>
References: <20150911143348.F1D9F1A2420@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-09-11 at 16:33 +0200, Christophe Leroy wrote:
> memcpy() uses instruction dcbz to speed up copy by not wasting time
> loading cache line with data that will be overwritten.
> Some platform like mpc52xx do no have cache active at startup and
> can therefore not use memcpy(). Allthough no part of the code
> explicitly uses memcpy(), GCC makes calls to it.
> 
> This patch modifies memcpy() such that at startup, memcpy()
> unconditionally jumps to generic_memcpy() which doesn't use
> the dcbz instruction.
> 
> Once the initial MMU is set up, in machine_init() we patch memcpy()
> by replacing this inconditional jump by a NOP
> 
> Reported-by: Michal Sojka <sojkam1@fel.cvut.cz>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> changes in v2:
>   Using feature-fixups instead of hardcoded call to patch_instruction()
>   Handling of memset() added
> changes in v3:
>   Not using anymore feature-fixups
>   Handling of memset() removed

Why was handling of memset() removed?

-Scott
