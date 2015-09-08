Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EEAC1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 13:56:37 +1000 (AEST)
Message-ID: <1441684596.14597.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc32: memcpy: only use dcbz once cache is enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, scottwood@freescale.com, sojkam1@fel.cvut.cz,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 08 Sep 2015 13:56:36 +1000
In-Reply-To: <20150907142444.CA8F31A241A@localhost.localdomain>
References: <20150907142444.CA8F31A241A@localhost.localdomain>
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

On Mon, 2015-09-07 at 16:24 +0200, Christophe Leroy wrote:
> memcpy() uses instruction dcbz to speed up copy by not wasting time
> loading cache line with data that will be overwritten.
> Some platform like mpc52xx do no have cache active at startup and
> can therefore not use memcpy(). Allthough no part of the code
> explicitly uses memcpy(), GCC makes calls to it.
> 
> This patch modifies memcpy() such that at startup, the 'dcbz'
> instruction is replaced by 'dcbt' which is harmless if cache is not
> enabled, and which helps a bit (allthough not as much as dcbz) if
> cache is already enabled.
> 
> Once the initial MMU is setup, in machine_init() we patch memcpy()
> by replacing the temporary 'dcbt' by 'dcbz'
> 
> Reported-by: Michal Sojka <sojkam1@fel.cvut.cz>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>


Is there some reason you can't use the normal cpu feature sections? See
arch/powerpc/lib/memcpy_64.S for an example of what I mean.

cheers
