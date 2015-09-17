Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 485DD1A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
In-Reply-To: <ca5390a60d9249e4a02ebf0b83009f3ceceba806.1442335197.git.christophe.leroy@c-s.fr>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com,
 sojkam1@fel.cvut.cz
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v4,2/2] powerpc32: memset: only use dcbz once cache is enabled
Message-Id: <20150917051328.00D411401DA@ozlabs.org>
Date: Thu, 17 Sep 2015 15:13:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-16-09 at 10:04:53 UTC, LEROY Christophe wrote:
> memset() uses instruction dcbz to speed up clearing by not wasting time
> loading cache line with data that will be overwritten.
> Some platform like mpc52xx do no have cache active at startup and
> can therefore not use memset(). Allthough no part of the code
> explicitly uses memset(), GCC may make calls to it.
> 
> This patch modifies memset() such that at startup, memset()
> unconditionally skip the optimised bloc that uses dcbz instruction.
> 
> Once the initial MMU is set up, in machine_init() we patch memset()
> by replacing this inconditional jump by a NOP
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/400c47d81ca383fc87d5a393

cheers
