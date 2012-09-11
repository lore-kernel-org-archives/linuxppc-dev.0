Return-Path: <cjb@laptop.org>
Received: from void.printf.net (void.printf.net [89.145.121.20])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A95242C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 01:04:28 +1000 (EST)
From: Chris Ball <cjb@laptop.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
Date: Tue, 11 Sep 2012 10:44:32 -0400
In-Reply-To: <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org> (Kumar
 Gala's message of "Tue, 11 Sep 2012 07:49:04 -0500")
Message-ID: <87k3w0y5yn.fsf@octavius.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mmc@vger.kernel.org, Huang Changming-R66093 <R66093@freescale.com>,
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

Hi,

On Tue, Sep 11 2012, Kumar Gala wrote:
> In sdhci_add_host()
>
> We have the following
>
> ...
>         mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>
>         if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>                 host->flags |= SDHCI_AUTO_CMD12;
>
>         /* Auto-CMD23 stuff only works in ADMA or PIO. */
>         if ((host->version >= SDHCI_SPEC_300) &&
>             ((host->flags & SDHCI_USE_ADMA) ||
>              !(host->flags & SDHCI_USE_SDMA))) {
>                 host->flags |= SDHCI_AUTO_CMD23;
>                 DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
>         } else {
>                 DBG("%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc));
>         }
>
> ...
>
> I'm not clear what the difference is between mmc->caps & host->flags, but shouldn't we move setting MMC_CAP_CMD23 inside the 'Auto-CMD23' if check?

The main answer is:  No, because CMD23 is distinct from Auto-CMD23.

Multiblock transfers (CMD23) date back from MMC cards (which is why
they're an MMC host capability) and can also be used in SDHCI.

Auto-CMD23 is a new feature in SDHCI 3.0 that reduces the overhead
of sending CMD23.  It doesn't work if we're using SDMA, though.

As for capability vs. flags, the capability is more of an inherent
property of the controller, and flags are runtime decisions on whether
to use that capability, based on e.g. the presence of a quirk.

So, I think the code's correct as written.  Feel free to ask more
questions if you're investigating a specific problem that you haven't
mentioned yet.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
