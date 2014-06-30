Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6424C1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 00:01:08 +1000 (EST)
Message-ID: <1404136867.18325.8.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Check for IRQHAPPENED before sleeping
From: Michael Neuling <mikey@neuling.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 30 Jun 2014 09:01:07 -0500
In-Reply-To: <20140630062404.29315.23382.stgit@preeti.in.ibm.com>
References: <20140630062404.29315.23382.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-30 at 11:54 +0530, Preeti U Murthy wrote:
> Commit 8d6f7c5a: "powerpc/powernv: Make it possible to skip the IRQHAPPEN=
ED
> check in power7_nap()" added code that prevents even cores which enter sl=
eep
> on idle, from checking for pending interrupts. Fix this.
>=20
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>=20
>  arch/powerpc/kernel/idle_power7.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle=
_power7.S
> index 2480256..5cf3d36 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
> @@ -131,7 +131,7 @@ _GLOBAL(power7_nap)
> =20
>  _GLOBAL(power7_sleep)
>  	li	r3,1
> -	li	r4,0
> +	li	r4,1
>  	b	power7_powersave_common
>  	/* No return */
> =20
>=20
