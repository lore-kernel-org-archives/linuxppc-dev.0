Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AA461A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:32:26 +1100 (AEDT)
Message-ID: <1445571130.701.151.camel@freescale.com>
Subject: Re: [PATCH 9/9] powerpc: optimise csum_partial() call when len is
 constant
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>
Date: Thu, 22 Oct 2015 22:32:10 -0500
In-Reply-To: <df593a56e52ccd24b758b9d40ae3b414cb4e5372.1442876807.git.christophe.leroy@c-s.fr>
References: <cover.1442876807.git.christophe.leroy@c-s.fr>
 <df593a56e52ccd24b758b9d40ae3b414cb4e5372.1442876807.git.christophe.leroy@c-s.fr>
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

On Tue, 2015-09-22 at 16:34 +0200, Christophe Leroy wrote:
> csum_partial is often called for small fixed length packets
> for which it is suboptimal to use the generic csum_partial()
> function.
> 
> For instance, in my configuration, I got:
> * One place calling it with constant len 4
> * Seven places calling it with constant len 8
> * Three places calling it with constant len 14
> * One place calling it with constant len 20
> * One place calling it with constant len 24
> * One place calling it with constant len 32
> 
> This patch renames csum_partial() to __csum_partial() and
> implements csum_partial() as a wrapper inline function which
> * uses csum_add() for small 16bits multiple constant length
> * uses ip_fast_csum() for other 32bits multiple constant
> * uses __csum_partial() in all other cases
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/checksum.h | 80 ++++++++++++++++++++++++++--------
> ---
>  arch/powerpc/lib/checksum_32.S      |  4 +-
>  arch/powerpc/lib/checksum_64.S      |  4 +-
>  arch/powerpc/lib/ppc_ksyms.c        |  2 +-
>  4 files changed, 62 insertions(+), 28 deletions(-)

Benchmarks?

-Scott
