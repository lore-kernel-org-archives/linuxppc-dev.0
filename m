Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C88B1A02E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 02:10:58 +1000 (EST)
Received: by mail-qc0-f179.google.com with SMTP id x3so6866539qcv.24
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 09:10:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
 <20140616104615.GA10701@n2100.arm.linux.org.uk>
 <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
Date: Mon, 16 Jun 2014 18:10:55 +0200
Message-ID: <CAPDyKFoeZLMCNpMMyLKKES+CUmTXt1g1rCPLB6HKXy9AMw1Zng@mail.gmail.com>
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling() into
 a library function
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: Barry Song <baohua@kernel.org>, Anton Vorontsov <anton@enomsg.org>,
 Stephen Warren <swarren@wwwdotorg.org>, spear-devel@list.st.com,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Viresh Kumar <viresh.linux@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16 June 2014 14:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 June 2014 12:46, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Wed, Apr 23, 2014 at 08:08:07PM +0100, Russell King wrote:
>>> @@ -1507,25 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>>                       host->ops->set_clock(host, host->clock);
>>>               }
>>>
>>> -             if (host->ops->set_uhs_signaling)
>>> -                     host->ops->set_uhs_signaling(host, ios->timing);
>>> -             else {
>>> -                     ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> -                     /* Select Bus Speed Mode for host */
>>> -                     ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
>>> -                     if ((ios->timing == MMC_TIMING_MMC_HS200) ||
>>> -                         (ios->timing == MMC_TIMING_UHS_SDR104))
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_SDR12)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_SDR25)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_SDR50)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_DDR50)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>> -                     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>> -             }
>>> +             host->ops->set_uhs_signaling(host, ios->timing);
>>>
>>>               if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>>>                               ((ios->timing == MMC_TIMING_UHS_SDR12) ||
>>
>> Whoever decided to poorly pick these patches up against my will has
>> slightly messed this patch up - whereas my original patch left the
>> code correctly formatted, when whoever applied this patch did so, they
>> left an additional blank line in the above.
>

[snip]

> Please, feel free to send a patch to fixup my misstake. I will happily apply it.

I had a second look to fix it up myself, but I just can't find that
your patch was different than the one I applied (beside the conflict I
resolved).

If you do find any other issue regarding the patches in this patchset
- please let me know and I will try to help.

Kind regards
Uffe
