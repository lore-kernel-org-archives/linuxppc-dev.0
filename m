Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5660DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 05:04:51 +1000 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4SJ4kxp015495
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 May 2007 21:04:47 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <465B27BE.10000@246tNt.com>
Date: Mon, 28 May 2007 21:04:30 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grzegorz Bernacki <gjb@semihalf.com>
Subject: Re: [PATCH] mpc52xx: Correct calculation of FEC RX errors.
References: <46560B34.2070800@semihalf.com>
In-Reply-To: <46560B34.2070800@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Nice catch,
I knew something was wrong ( 4 billion errors ;) but I never bothered to
look
it up.

Sylvain

Grzegorz Bernacki wrote:
> 'ifconfig eth0' command for mpc5200B-based cards shows error for RX.
> However none of RX MIB counters is set to value greater than zero.
> Number of errors is equal to number of multicast packet. In linux 2.4
> calculation of RX errors is slightly different and takes into account
> number of multicast packet. This change is a port of calculation method
> of RX errors for FEC controller from linux 2.4 to 2.6.
>
> Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
> ---
>
>  drivers/net/fec_mpc52xx/fec.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/fec_mpc52xx/fec.c b/drivers/net/fec_mpc52xx/fec.c
> index f0ce87e..d2087f6 100644
> --- a/drivers/net/fec_mpc52xx/fec.c
> +++ b/drivers/net/fec_mpc52xx/fec.c
> @@ -395,7 +395,9 @@ static struct net_device_stats *fec_get_stats(struct
> net_device *dev)
>
>         stats->rx_bytes = in_be32(&fec->rmon_r_octets);
>         stats->rx_packets = in_be32(&fec->rmon_r_packets);
> -       stats->rx_errors = stats->rx_packets -
> in_be32(&fec->ieee_r_frame_ok);
> +       stats->rx_errors = stats->rx_packets - (
> +                       in_be32(&fec->ieee_r_frame_ok) +
> +                       in_be32(&fec->rmon_r_mc_pkt));
>         stats->tx_bytes = in_be32(&fec->rmon_t_octets);
>         stats->tx_packets = in_be32(&fec->rmon_t_packets);
>         stats->tx_errors = stats->tx_packets - (
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
