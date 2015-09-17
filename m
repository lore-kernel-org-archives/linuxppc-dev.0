Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 120F11A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
In-Reply-To: <a7cc8a844159fdb7edb97089ba376f525aa7842e.1442335197.git.christophe.leroy@c-s.fr>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com,
 sojkam1@fel.cvut.cz
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v4,1/2] powerpc32: memcpy: only use dcbz once cache is enabled
Message-Id: <20150917051327.C91901401EF@ozlabs.org>
Date: Thu, 17 Sep 2015 15:13:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-16-09 at 10:04:51 UTC, LEROY Christophe wrote:
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

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1cd03890ea64795e53f17a94

cheers
