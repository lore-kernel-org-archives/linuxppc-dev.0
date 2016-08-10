Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es
 [IPv6:2001:720:418:ca00::4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8RDd37mXzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:48:49 +1000 (AEST)
Date: Wed, 10 Aug 2016 10:56:05 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Remove one insn in __bswapdi2
Message-ID: <20160810085605.GB2117@visitor2.iram.es>
References: <20160805112803.36D3B1A2399@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160805112803.36D3B1A2399@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2016 at 01:28:02PM +0200, Christophe Leroy wrote:
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/misc_32.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> index e025230..e18055c 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -578,9 +578,8 @@ _GLOBAL(__bswapdi2)
>  	rlwimi  r9,r4,24,0,7
>  	rlwimi  r10,r3,24,0,7
>  	rlwimi  r9,r4,24,16,23
> -	rlwimi  r10,r3,24,16,23
> +	rlwimi  r4,r3,24,16,23
>  	mr      r3,r9
> -	mr      r4,r10
>  	blr
>  

Hmmm, are you sure that it works? rlwimi is a bit special since the
first operand is both an input and an output of the instruction.


In other words, did you test the code?

    Gabriel
