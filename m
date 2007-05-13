Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CDC7DDE2A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 09:46:12 +1000 (EST)
Message-ID: <4647A35B.40407@genesi-usa.com>
Date: Mon, 14 May 2007 00:46:35 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 3/9] powerpc/ppc32: Update mpc52xx_psc structure with
	B	revision changes
References: <11790019171838-git-send-email-tnt@246tNt.com>	<11790019223299-git-send-email-tnt@246tNt.com>	<11790019223880-git-send-email-tnt@246tNt.com>
	<11790019223925-git-send-email-tnt@246tNt.com>
In-Reply-To: <11790019223925-git-send-email-tnt@246tNt.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Would a note next to these new fields be worth it? "5200B only" or
"reserved on 5200" or even create a new PSC structure for the old
processor and recast it in drivers that really want to support both
revisions of the CPU?

Real nitpick:

Setting the CCR on the MPC5200 (not B) now means you need to left
shift your required CCR values by 16 bits before applying them into
the field for the desired effect.

If you were being lazy and just wanted to set some low-order bits
in the CCR on the 5200, with the old structure that's fine. With
the new structure, it will be writing into previously reserved
space on the 5200. The 5200B might work fine, unless it's a driver
someone missed, and is programming a value that should be in the
upper 16 bits of the new CCR, in which case now you have to left
shift by 16 bits.. :)

I don't suppose it matters a great deal (who uses an original MPC5200?),
but it would be an intrusive change if any drivers did actually use the
CCR already.. it's nice to mention somewhere though, I guess.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Sylvain Munaut wrote:
> On the mpc5200b the ccr register is 32 bits wide while on the
> mpc5200 it's only 16 bits. It's up to the driver to use the
> correct format depending on the chip it's running on.
> 
> The 5200b also offers some more registers & status in AC97
> mode. Again, if not running on a 5200b the driver should not
> use those.
> 
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  include/asm-ppc/mpc52xx_psc.h |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-ppc/mpc52xx_psc.h b/include/asm-ppc/mpc52xx_psc.h
> index 9d850b2..c82b8d4 100644
> --- a/include/asm-ppc/mpc52xx_psc.h
> +++ b/include/asm-ppc/mpc52xx_psc.h
> @@ -28,6 +28,10 @@
>  #define MPC52xx_PSC_MAXNUM	6
>  
>  /* Programmable Serial Controller (PSC) status register bits */
> +#define MPC52xx_PSC_SR_UNEX_RX	0x0001
> +#define MPC52xx_PSC_SR_DATA_VAL	0x0002
> +#define MPC52xx_PSC_SR_DATA_OVR	0x0004
> +#define MPC52xx_PSC_SR_CMDSEND	0x0008
>  #define MPC52xx_PSC_SR_CDE	0x0080
>  #define MPC52xx_PSC_SR_RXRDY	0x0100
>  #define MPC52xx_PSC_SR_RXFULL	0x0200
> @@ -132,8 +136,10 @@ struct mpc52xx_psc {
>  	u8		reserved5[3];
>  	u8		ctlr;		/* PSC + 0x1c */
>  	u8		reserved6[3];
> -	u16		ccr;		/* PSC + 0x20 */
> -	u8		reserved7[14];
> +	u32		ccr;		/* PSC + 0x20 */
> +	u32		ac97_slots;	/* PSC + 0x24 */
> +	u32		ac97_cmd;	/* PSC + 0x28 */
> +	u32		ac97_data;	/* PSC + 0x2c */
>  	u8		ivr;		/* PSC + 0x30 */
>  	u8		reserved8[3];
>  	u8		ip;		/* PSC + 0x34 */
