Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id A310ADDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 21:10:01 +1100 (EST)
Subject: Re: [PATCH] Fix ucc_geth MII master selection
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
In-Reply-To: <1203009081-10966-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1203009081-10966-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain
Date: Fri, 15 Feb 2008 11:09:59 +0100
Message-Id: <1203070199.5419.101.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-02-14 at 18:11 +0100, Joakim Tjernlund wrote:
> Remove bogus UCC regs range test and correct
> off by one error in call to ucc_set_qe_mux_mii_mng()
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
> 
> I am not 100% sure this is the correct fix, please ACK or NACK
> 
>  drivers/net/ucc_geth_mii.c |   26 +++++++++++---------------
>  1 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
> index 6c257b8..472d5a1 100644
> --- a/drivers/net/ucc_geth_mii.c
> +++ b/drivers/net/ucc_geth_mii.c
> @@ -200,21 +200,17 @@ static int uec_mdio_probe(struct of_device *ofdev, const struct of_device_id *ma
>  		if (err)
>  			goto bus_register_fail;
>  
> -		/* if our mdio regs fall within this UCC regs range */
> -		if ((res.start >= tempres.start) &&
> -		    (res.end <= tempres.end)) {
> -			/* set this UCC to be the MII master */
> -			const u32 *id = of_get_property(tempnp, "device-id", NULL);
> -			if (id == NULL)
> -				goto bus_register_fail;
> -
> -			ucc_set_qe_mux_mii_mng(*id - 1);
> -
> -			/* assign the TBI an address which won't
> -			 * conflict with the PHYs */
> -			out_be32(&regs->utbipar, UTBIPAR_INIT_TBIPA);
> -			break;
> -		}
> +		/* set this UCC to be the MII master */
> +		const u32 *id = of_get_property(tempnp, "device-id", NULL);
> +		if (id == NULL)
> +			goto bus_register_fail;
> +
> +		ucc_set_qe_mux_mii_mng(*id);
> +
> +		/* assign the TBI an address which won't
> +		 * conflict with the PHYs */
> +		out_be32(&regs->utbipar, UTBIPAR_INIT_TBIPA);
> +		break;
>  	}
>  
>  	err = mdiobus_register(new_bus);

This patch is crap, turns out that ucc_set_qe_mux_mii_mng(2) always
works even if UCC3 isn't used at all. I can't figured out why not 1 
or 3 works.

 Jocke
