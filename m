Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 120471A035E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 20:56:09 +1000 (EST)
Date: Mon, 16 Jun 2014 11:46:16 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling()
 into a library function
Message-ID: <20140616104615.GA10701@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Barry Song <baohua@kernel.org>, Anton Vorontsov <anton@enomsg.org>,
 Stephen Warren <swarren@wwwdotorg.org>, spear-devel@list.st.com,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Viresh Kumar <viresh.linux@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
 linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2014 at 08:08:07PM +0100, Russell King wrote:
> @@ -1507,25 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  			host->ops->set_clock(host, host->clock);
>  		}
>  
> -		if (host->ops->set_uhs_signaling)
> -			host->ops->set_uhs_signaling(host, ios->timing);
> -		else {
> -			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -			/* Select Bus Speed Mode for host */
> -			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> -			if ((ios->timing == MMC_TIMING_MMC_HS200) ||
> -			    (ios->timing == MMC_TIMING_UHS_SDR104))
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR12)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR25)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR50)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> -			else if (ios->timing == MMC_TIMING_UHS_DDR50)
> -				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> -			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> -		}
> +		host->ops->set_uhs_signaling(host, ios->timing);
>  
>  		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>  				((ios->timing == MMC_TIMING_UHS_SDR12) ||

Whoever decided to poorly pick these patches up against my will has
slightly messed this patch up - whereas my original patch left the
code correctly formatted, when whoever applied this patch did so, they
left an additional blank line in the above.

The other thing I'd ask is that the MMC people learn C precedence
rules, and realise that it's not necessary (and actively harmful)
to add additional parenthesis around simple if() conditions.  Testing
for timing being one of two values does not need anything more than
one set of parenthesis - it does not need if ((a == b) || (a == c)) -
if (a == b || a == c) does just fine, and is less confusing when
encountering more complex statements, such as:

	if ((((a == b) || (a == c)) && ((d > a) || (d < c))) || (z == f))

compared with:

	if (((a == b || a == c) && (d > a || d < c)) || z == f)

With the former "style", I normally end up having to pull the file into
the editor, and rewrite the damned statement to work out what the
grouping is, because the excessive use of parenthesis is detrimental to
readability.  Don't do it.  Learn the C precedence rules and keep code
readable.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
