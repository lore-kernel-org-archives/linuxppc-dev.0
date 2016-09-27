Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjhwr1NwrzDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 10:46:35 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8R0hGSg134804
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:46:33 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q5mky0aa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:46:33 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 21:46:31 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id AF701352006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:46:04 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8R0kSCL25362694
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 21:46:28 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8R0kRjT010778
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 21:46:28 -0300
Date: Mon, 26 Sep 2016 21:46:18 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>, joy.latten@canonical.com
Subject: Re: [PATCH] crypto: sha1-powerpc: little-endian support
References: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
Message-Id: <20160927004618.GA5010@dublin>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fri, Sep 23, 2016 at 04:31:56PM -0300, Marcelo Cerri wrote:
> The driver does not handle endianness properly when loading the input
> data.

Indeed. I tested in both endianesses and it's working fine. Thanks!

Herbert, can we go ahead with this fix?

> 
> Signed-off-by: Marcelo Cerri <marcelo.cerri@canonical.com>
> ---
>  arch/powerpc/crypto/sha1-powerpc-asm.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
> index 125e165..82ddc9b 100644
> --- a/arch/powerpc/crypto/sha1-powerpc-asm.S
> +++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
> @@ -7,6 +7,15 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> 
> +#ifdef __BIG_ENDIAN__
> +#define LWZ(rt, d, ra)	\
> +	lwz	rt,d(ra)
> +#else
> +#define LWZ(rt, d, ra)	\
> +	li	rt,d;	\
> +	lwbrx	rt,rt,ra
> +#endif
> +
>  /*
>   * We roll the registers for T, A, B, C, D, E around on each
>   * iteration; T on iteration t is A on iteration t+1, and so on.
> @@ -23,7 +32,7 @@
>  #define W(t)	(((t)%16)+16)
> 
>  #define LOADW(t)				\
> -	lwz	W(t),(t)*4(r4)
> +	LWZ(W(t),(t)*4,r4)
> 
>  #define STEPD0_LOAD(t)				\
>  	andc	r0,RD(t),RB(t);		\
> @@ -33,7 +42,7 @@
>  	add	r0,RE(t),r15;			\
>  	add	RT(t),RT(t),r6;		\
>  	add	r14,r0,W(t);			\
> -	lwz	W((t)+4),((t)+4)*4(r4);	\
> +	LWZ(W((t)+4),((t)+4)*4,r4);	\
>  	rotlwi	RB(t),RB(t),30;			\
>  	add	RT(t),RT(t),r14
> 
> -- 
> 2.7.4
> 

-- 
Paulo Flabiano Smorigo
IBM Linux Technology Center
