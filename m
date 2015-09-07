Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 141021A2A7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 00:50:41 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc32: memcpy: only use dcbz once cache is enabled
In-Reply-To: <20150907142444.CA8F31A241A@localhost.localdomain>
References: <20150907142444.CA8F31A241A@localhost.localdomain>
Date: Mon, 07 Sep 2015 16:50:32 +0200
Message-ID: <87lhci472f.fsf@steelpick.2x.cz>
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

On Mon, Sep 07 2015, Christophe Leroy wrote:
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
> ---
> @Michal, can you please test it ?

Yes, it works.

Tested-by: Michal Sojka <sojkam1@fel.cvut.cz>

-Michal
