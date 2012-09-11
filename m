Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 388A62C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 22:49:17 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
Date: Tue, 11 Sep 2012 07:49:04 -0500
Message-Id: <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
To: Huang Changming-R66093 <R66093@freescale.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In sdhci_add_host()

We have the following

...
        mmc->caps |=3D MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;

        if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
                host->flags |=3D SDHCI_AUTO_CMD12;

        /* Auto-CMD23 stuff only works in ADMA or PIO. */
        if ((host->version >=3D SDHCI_SPEC_300) &&
            ((host->flags & SDHCI_USE_ADMA) ||
             !(host->flags & SDHCI_USE_SDMA))) {
                host->flags |=3D SDHCI_AUTO_CMD23;
                DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
        } else {
                DBG("%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc));
        }

...

I'm not clear what the difference is between mmc->caps & host->flags, =
but shouldn't we move setting MMC_CAP_CMD23 inside the 'Auto-CMD23' if =
check?

- k=
