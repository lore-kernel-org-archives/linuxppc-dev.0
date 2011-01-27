Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C2631007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 20:51:10 +1100 (EST)
Received: by ewy19 with SMTP id 19so657445ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 01:51:04 -0800 (PST)
Date: Thu, 27 Jan 2011 12:51:00 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Alex Dubov <oakad@yahoo.com>
Subject: Re: [PATCH] gianfar: Fall back to software tcp/udp checksum on
	older controllers
Message-ID: <20110127095100.GA5411@oksana.dev.rtsoft.ru>
References: <468529.34173.qm@web37605.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <468529.34173.qm@web37605.mail.mud.yahoo.com>
Cc: linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, mlcreech@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Alex,

On Thu, Jan 27, 2011 at 12:14:21AM -0800, Alex Dubov wrote:
> As specified by errata eTSEC49 of MPC8548 and errata eTSEC12 of MPC83xx,
> older revisions of gianfar controllers will be unable to calculate a TCP/UDP
> packet checksum for some aligments of the appropriate FCB. This patch checks
> for FCB alignment on such controllers and falls back to software checksumming
> if the aligment is known to be bad.
> 
> Signed-off-by: Alex Dubov <oakad@yahoo.com>
> ---
> This is my, somewhat different approach to Matthew Creech proposed solution.
> 
>  drivers/net/gianfar.c |   21 +++++++++++++++++++--
>  drivers/net/gianfar.h |    1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index 5ed8f9f..b4f0e99 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -950,6 +950,11 @@ static void gfar_detect_errata(struct gfar_private *priv)
>  			(pvr == 0x80861010 && (mod & 0xfff9) == 0x80c0))
>  		priv->errata |= GFAR_ERRATA_A002;
>  
> +	/* MPC8313 Rev < 2.0, MPC8548 rev 2.0 */
> +	if ((pvr == 0x80850010 && mod == 0x80b0 && rev < 0x0020)
> +	    || (pvr == 0x80210020 && mod == 0x8030 && rev == 0x0020))

Please indent it like the above: with two tabs. This is
to keep things consistent.

> +		priv->errata |= GFAR_ERRATA_12;
> +
>  	if (priv->errata)
>  		dev_info(dev, "enabled errata workarounds, flags: 0x%x\n",
>  			 priv->errata);
> @@ -2156,8 +2161,20 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* Set up checksumming */
>  	if (CHECKSUM_PARTIAL == skb->ip_summed) {
>  		fcb = gfar_add_fcb(skb);
> -		lstatus |= BD_LFLAG(TXBD_TOE);
> -		gfar_tx_checksum(skb, fcb);
> +		switch (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12))
> +			? 1 : 0) {

The switch construction is quite bizarre. ;-) Why not

if (gfar_has_errata() && (ulong)fcb % 0x20 > 18) {
	csum_help();
} else {
	lstatus |=...
	tx_csum();
}

?

Thanks,

> +		case 1:
> +			/* as specified by errata */
> +			if (((unsigned long)fcb % 0x20) > 0x18) { 
> +				__skb_pull(skb, GMAC_FCB_LEN);
> +				skb_checksum_help(skb);
> +				break;
> +			}
> +			/* otherwise, fall through */
> +		default:
> +			lstatus |= BD_LFLAG(TXBD_TOE);
> +			gfar_tx_checksum(skb, fcb);
> +		}
>  	}

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
