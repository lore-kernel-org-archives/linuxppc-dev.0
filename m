Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 5D41C1A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 17:15:08 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc32: memset: only use dcbz once cache is enabled
In-Reply-To: <20150914062159.353701A2413@localhost.localdomain>
References: <20150914062159.353701A2413@localhost.localdomain>
Date: Mon, 14 Sep 2015 09:15:00 +0200
Message-ID: <87bnd5xyiz.fsf@steelpick.2x.cz>
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

On Mon, Sep 14 2015, Christophe Leroy wrote:
> memset() uses instruction dcbz to speed up clearing by not wasting time
> loading cache line with data that will be overwritten.
> Some platform like mpc52xx do no have cache active at startup and
> can therefore not use memset(). Allthough no part of the code
> explicitly uses memset(), GCC may makes calls to it.
>
> This patch modifies memset() such that at startup, memset()
> unconditionally jumps to simple_memset() which doesn't use
> the dcbz instruction.

I tested both v3 patches (memcpy and memset) and they work for me.

Thanks
-Michal
