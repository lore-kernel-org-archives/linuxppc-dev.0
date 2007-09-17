Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id F2D2DDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 15:33:19 +1000 (EST)
Date: Mon, 17 Sep 2007 07:33:14 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
Message-ID: <20070917053314.GA19538@nd47.coderock.org>
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
	<20070915122218.GB19857@nd47.coderock.org>
	<9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>
	<9e4733910709161205k15106ba1sd2f0597f2601f222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910709161205k15106ba1sd2f0597f2601f222@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 16/09/07 15:05 -0400, Jon Smirl wrote:
> This adjustment to the error counting is in the Efika patches and not
> in yours, should it be in yours too?

I know about this patch.

Error counting is reworked in newer anyway (mixing rmon and ieee
counters didn't look very nice to me).


	Domen

> 
> --- a/drivers/net/fec_mpc52xx/fec.c 2007-05-30 16:04:50.000000000 +0200
> +++ b/drivers/net/fec_mpc52xx/fec.c 2007-05-30 16:09:02.000000000 +0200
> @@ -411,7 +411,9 @@
> 
>  	stats->rx_bytes = in_be32(&fec->rmon_r_octets);
>  	stats->rx_packets = in_be32(&fec->rmon_r_packets);
> -	stats->rx_errors = stats->rx_packets - in_be32(&fec->ieee_r_frame_ok);
> +	stats->rx_errors = stats->rx_packets - (
> +			in_be32(&fec->ieee_r_frame_ok) +
> +			in_be32(&fec->rmon_r_mc_pkt));
>  	stats->tx_bytes = in_be32(&fec->rmon_t_octets);
>  	stats->tx_packets = in_be32(&fec->rmon_t_packets);
>  	stats->tx_errors = stats->tx_packets - (
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
