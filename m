Return-Path: <SRS0+53cd420187fdf1da6eba+1703+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 436E1DE09B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 04:49:31 +1000 (EST)
Subject: Re: [PATCH] MTD: fix partition scan control logic in physmap_of
	and fsl_elbc_nand
From: David Woodhouse <dwmw2@infradead.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1204201051-13107-1-git-send-email-leoli@freescale.com>
References: <1204201051-13107-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 19:49:22 +0100
Message-Id: <1208890162.9212.646.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-02-28 at 20:17 +0800, Li Yang wrote:
> The generic rule for partition scan is to try all supported
> partition types before an usable partition table is found.
> However the original code returns unsuccessful when there is
> an error in any of the partition types.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> ---
> I later found that Stefan has proposed a similar patch for physmap_of
> and Peter proposed another patch to fix cmdlinepart instead.
> I'd say that even after cmdlinepart patch is applied the scan control
> logic still needs to be fixed.

I'm not convinced. I think the partition code should return an error if
it hits a hard error, like a failure to read from the device. And return
zero when it doesn't find anything.

-- 
dwmw2
