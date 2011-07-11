Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8484EB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 05:39:16 +1000 (EST)
Date: Mon, 11 Jul 2011 14:38:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH] powerpc/85xx: fix mpic configuration in CAMP mode
Message-ID: <20110711143859.0e6c95d8@schlenkerla.am.freescale.net>
In-Reply-To: <CABkP77e6vLmLxk3wCP39GJ7+yKnJZFc7BPUZ1OkdA8d7KkBCiw@mail.gmail.com>
References: <CABkP77e6vLmLxk3wCP39GJ7+yKnJZFc7BPUZ1OkdA8d7KkBCiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 10 Jul 2011 20:55:32 +0200
Fabio Baltieri <fabio.baltieri@gmail.com> wrote:

> Change the string to check for CAMP mode boot on MPC85xx (eg. P2020) to match
> the one in the corresponding dts files (p2020rdb_camp_core{0,1}.dts).
> 
> Without this fix the mpic is configured as in the SMP boot mode, which causes
> the first core to report a protected source interrupt error for devices
> of the other core and lock up.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> index 088f30b..a1e5e70 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -58,7 +58,7 @@ void __init mpc85xx_rdb_pic_init(void)
>  		return;
>  	}
> 
> -	if (of_flat_dt_is_compatible(root, "fsl,85XXRDB-CAMP")) {
> +	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
>  		mpic = mpic_alloc(np, r.start,
>  			MPIC_PRIMARY |
>  			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,

Shouldn't we be setting MPIC_SINGLE_DEST_CPU in this case (as we do for
the other case)?

Or just drop this and specify pic-no-reset in the mpic node.

-Scott
