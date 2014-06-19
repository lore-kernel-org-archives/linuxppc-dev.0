Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B701A0339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 02:07:03 +1000 (EST)
Message-ID: <53A30852.2090405@wwwdotorg.org>
Date: Thu, 19 Jun 2014 09:57:06 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling() into
 a library function
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
 <20140616104615.GA10701@n2100.arm.linux.org.uk>
 <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
 <20140619122830.GP32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140619122830.GP32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Barry Song <baohua@kernel.org>, Anton Vorontsov <anton@enomsg.org>,
 spear-devel@list.st.com, linux-mmc <linux-mmc@vger.kernel.org>,
 Chris Ball <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>,
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

On 06/19/2014 06:28 AM, Russell King - ARM Linux wrote:
> On Mon, Jun 16, 2014 at 02:17:30PM +0200, Ulf Hansson wrote:
>> Anyway, we did get some folks to test the patches and was thus fairly
>> confident that we could merge them. Chris asked me to try to collect
>> them in a PR for him, so I did. Sorry if I managed to screw some
>> things up, there were several conflicts and actual regressions, which
>> I tried to take care of.
>>
>> The mmc people were also very helping in sending patches to fixup
>> related regressions, immediately after we merged your patchset. Thus
>> together I think we managed to pull it off.
> 
> I tend to look through slightly less rose-tinted glasses.
> 
> The fact is... there's loads of ARM platforms which now fail in Olof's
> build/boot testing, and they all seem to have a very similar pattern:
> 
> hummingboard:
> [    1.149688] sdhci: Secure Digital Host Controller Interface driver
> [    1.155901] sdhci: Copyright(c) Pierre Ossman
> ...
> [    1.253630] Waiting for root device /dev/mmcblk0p2...
> [   60.325469] imx-sdma 20ec000.sdma: firmware not found
> ~$off
> # PYBOOT: Exception: timeout
> 
> jetson:
> [    2.261355] Waiting for root device /dev/mmcblk0p1...
> 
> wandboard:
> [    1.186870] sdhci: Secure Digital Host Controller Interface driver
> [    1.193075] sdhci: Copyright(c) Pierre Ossman
> ...
> [    1.291064] Waiting for root device /dev/mmcblk0p2...

Any SDHCI failures in Linus' tree (but not linux-next) that occur only
in multi_v7_defconfig are likely solved by:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/264012.html

[PATCH] ARM: multi_v7_defconfig: re-enable SDHCI drivers

> Whether these are caused by the patch set or not is anyone's guess,
> because we (a) don't know what's causing these failures, and (b)
> my patch series was never tested on anything but iMX6.

I thought that I'd tested at least some of it on Tegra.
