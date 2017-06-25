Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwGqy4WSbzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 12:49:50 +1000 (AEST)
Date: Sat, 24 Jun 2017 21:49:39 -0500
From: Scott Wood <oss@buserror.net>
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: roy.pledge@nxp.com, linux-kernel@vger.kernel.org,
 claudiu.manoil@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20170625024939.3adaysgmblwhyeyf@home.buserror.net>
References: <1493971556-14918-1-git-send-email-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493971556-14918-1-git-send-email-karim.eshapa@gmail.com>
Subject: Re: drivers:soc:fsl:qbman:qman.c: Change a comment for an entry
 check inside drain_mr_fqrni function
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 05, 2017 at 10:05:56AM +0200, Karim Eshapa wrote:
> Change the comment for an entry check inside function
> drain_mr_fqrni() with sleep for sufficient period
> of time instead of long time proccessor cycles.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 18d391e..636a7d7 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1071,18 +1071,19 @@ static int drain_mr_fqrni(struct qm_portal *p)
>  	msg = qm_mr_current(p);
>  	if (!msg) {
>  		/*
> -		 * if MR was full and h/w had other FQRNI entries to produce, we
> -		 * need to allow it time to produce those entries once the
> -		 * existing entries are consumed. A worst-case situation
> -		 * (fully-loaded system) means h/w sequencers may have to do 3-4
> -		 * other things before servicing the portal's MR pump, each of
> -		 * which (if slow) may take ~50 qman cycles (which is ~200
> -		 * processor cycles). So rounding up and then multiplying this
> -		 * worst-case estimate by a factor of 10, just to be
> -		 * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
> -		 * one entry at a time, so h/w has an opportunity to produce new
> -		 * entries well before the ring has been fully consumed, so
> -		 * we're being *really* paranoid here.
> +		 * if MR was full and h/w had other FQRNI entries to
> +		 * produce, we need to allow it time to produce those
> +		 * entries once the existing entries are consumed.
> +		 * A worst-case situation (fully-loaded system) means
> +		 * h/w sequencers may have to do 3-4 other things
> +		 * before servicing the portal's MR pump, each of
> +		 * which (if slow) may take ~50 qman cycles
> +		 * (which is ~200 processor cycles). So sleep with
> +		 * 1 ms would be very efficient, after this period
> +		 * we can check if there is something produced.
> +		 * NB, we consume one entry at a time, so h/w has
> +		 * an opportunity to produce new entries well before
> +		 * the ring has been fully consumed.

Do you mean "sufficient" here rather than "efficient"?  It's far less
inefficient than what the code was previously doing, but still...

Otherwise, looks good.

-Scott
