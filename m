Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7914D2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 06:26:49 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <87k3w0y5yn.fsf@octavius.laptop.org>
Date: Tue, 11 Sep 2012 15:26:32 -0500
Message-Id: <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
To: Chris Ball <cjb@laptop.org>
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


On Sep 11, 2012, at 9:44 AM, Chris Ball wrote:

> Hi,
>=20
> On Tue, Sep 11 2012, Kumar Gala wrote:
>> In sdhci_add_host()
>>=20
>> We have the following
>>=20
>> ...
>>        mmc->caps |=3D MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | =
MMC_CAP_CMD23;
>>=20
>>        if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>>                host->flags |=3D SDHCI_AUTO_CMD12;
>>=20
>>        /* Auto-CMD23 stuff only works in ADMA or PIO. */
>>        if ((host->version >=3D SDHCI_SPEC_300) &&
>>            ((host->flags & SDHCI_USE_ADMA) ||
>>             !(host->flags & SDHCI_USE_SDMA))) {
>>                host->flags |=3D SDHCI_AUTO_CMD23;
>>                DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
>>        } else {
>>                DBG("%s: Auto-CMD23 unavailable\n", =
mmc_hostname(mmc));
>>        }
>>=20
>> ...
>>=20
>> I'm not clear what the difference is between mmc->caps & host->flags, =
but shouldn't we move setting MMC_CAP_CMD23 inside the 'Auto-CMD23' if =
check?
>=20
> The main answer is:  No, because CMD23 is distinct from Auto-CMD23.
>=20
> Multiblock transfers (CMD23) date back from MMC cards (which is why
> they're an MMC host capability) and can also be used in SDHCI.
>=20
> Auto-CMD23 is a new feature in SDHCI 3.0 that reduces the overhead
> of sending CMD23.  It doesn't work if we're using SDMA, though.
>=20
> As for capability vs. flags, the capability is more of an inherent
> property of the controller, and flags are runtime decisions on whether
> to use that capability, based on e.g. the presence of a quirk.
>=20
> So, I think the code's correct as written.  Feel free to ask more
> questions if you're investigating a specific problem that you haven't
> mentioned yet.

Chris,

thanks for the info.  Do you know what's required on controller side to =
handle cards that support CMD23?

I'm trying to figure out if older controller's on FSL SoCs are missing =
some feature to allow CMD23 to work (vs Auto-CMD23).


- k=
