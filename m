Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F046E1A0872
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 09:21:48 +1000 (EST)
Message-ID: <1407367308.8507.41.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc: Add POWER8 features to CPU_FTRS_POSSIBLE/ALWAYS
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 07 Aug 2014 09:21:48 +1000
In-Reply-To: <1407303737-29529-1-git-send-email-mpe@ellerman.id.au>
References: <1407303737-29529-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Joel Stanley <joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 15:42 +1000, Michael Ellerman wrote:
> We have been a bit slack about updating the CPU_FTRS_POSSIBLE and
> CPU_FTRS_ALWAYS masks. When we added POWER8, and also POWER8E we forgot
> to update the ALWAYS mask. And when we added POWER8_DD1 we forgot to
> update both the POSSIBLE and ALWAYS masks.
>=20
> Luckily this hasn't caused any actual bugs AFAICS. Failing to update the
> ALWAYS mask just forgoes a potential optimisation opportunity. Failing
> to update the POSSIBLE mask for POWER8_DD1 is also OK because it only
> removes a bit rather than adding any.
>=20
> Regardless they should all be in both masks so as to avoid any future
> bugs when the set of ALWAYS/POSSIBLE bits changes, or the masks
> themselves change.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

CCing Joel but FWIW

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  arch/powerpc/include/asm/cputable.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index af5598688daf..d696eeb2def0 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -458,7 +458,8 @@ extern const char *powerpc_base_platform;
>  #define CPU_FTRS_POSSIBLE	\
>  	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
>  	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
> -	     CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_VSX)
> +	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
> +	     CPU_FTRS_PA6T | CPU_FTR_VSX)
>  #endif
>  #else
>  enum {
> @@ -508,7 +509,8 @@ enum {
>  #define CPU_FTRS_ALWAYS		\
>  	    (CPU_FTRS_POWER4 & CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
>  	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
> -	     CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
> +	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
> +	     CPU_FTRS_POWER8_DD1 & CPU_FTRS_POSSIBLE)
>  #endif
>  #else
>  enum {
