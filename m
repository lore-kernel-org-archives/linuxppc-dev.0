Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0133.outbound.protection.outlook.com [65.55.169.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F37F21A017A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 13:35:27 +1000 (AEST)
Date: Thu, 1 Oct 2015 22:35:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>
CC: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <madalin.bucur@freescale.com>,
 <pebolle@tiscali.nl>, <joakim.tjernlund@transmode.se>, <ppc@mindchasers.com>,
 <stephen@networkplumber.org>, <davem@davemloft.net>
Subject: Re: [v5, 2/6] fsl/fman: Add FMan support
Message-ID: <20151002033506.GA8067@home.buserror.net>
References: <1443085838-7539-1-git-send-email-igal.liberman@freescale.com>
 <1443085838-7539-3-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1443085838-7539-3-git-send-email-igal.liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2015 at 12:10:34PM +0300, igal.liberman@freescale.com wrote:
> +int fman_get_rx_extra_headroom(void)
> +{
> +	static bool fm_check_rx_extra_headroom;
> +
> +	if (!fm_check_rx_extra_headroom) {
> +		if (fsl_fm_rx_extra_headroom > FSL_FM_RX_EXTRA_HEADROOM_MAX ||
> +		    fsl_fm_rx_extra_headroom < FSL_FM_RX_EXTRA_HEADROOM_MIN) {
> +			pr_warn("Invalid fsl_fm_rx_extra_headroom value (%d) in bootargs, valid range is %d-%d. Falling back to the default (%d)\n",
> +				fsl_fm_rx_extra_headroom,
> +				FSL_FM_RX_EXTRA_HEADROOM_MIN,
> +				FSL_FM_RX_EXTRA_HEADROOM_MAX,
> +				FSL_FM_RX_EXTRA_HEADROOM);
> +			fsl_fm_rx_extra_headroom = FSL_FM_RX_EXTRA_HEADROOM;
> +		}
> +
> +		fsl_fm_rx_extra_headroom = true;

I think you mean "fm_check_rx_extra_headroom = true".

> +		fsl_fm_rx_extra_headroom = ALIGN(fsl_fm_rx_extra_headroom, 16);
> +	}
> +
> +	return fsl_fm_rx_extra_headroom;
> +}
> +EXPORT_SYMBOL(fman_get_rx_extra_headroom);

Please just check things like this once during module init. 
Init-on-first-use is unnecessarily complicated, and race-prone.

-Scott
