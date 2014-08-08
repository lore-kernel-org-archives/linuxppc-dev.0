Return-Path: <pawel.moll@arm.com>
Received: from collaborate-mta1.arm.com (fw-tnat.austin.arm.com
 [217.140.110.23])
 by lists.ozlabs.org (Postfix) with ESMTP id 406D21A0A68
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 02:36:42 +1000 (EST)
Message-ID: <1407515785.31897.28.camel@hornet>
Subject: Re: [PATCH 3/5] mmc: sdhci-pltfm: Do not use parent as the host's
 device
From: Pawel Moll <pawel.moll@arm.com>
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Ulf
 Hansson <ulf.hansson@linaro.org>
Date: Fri, 08 Aug 2014 17:36:25 +0100
In-Reply-To: <1406298233-27876-3-git-send-email-pawel.moll@arm.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-3-git-send-email-pawel.moll@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "paul@pwsan.com" <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "arm@kernel.org" <arm@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>,
 Olof Johansson <olof@lixom.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-07-25 at 15:23 +0100, Pawel Moll wrote:
> The code selecting a device for the sdhci host has been
> continuously tweaked (4b711cb13843f5082e82970dd1e8031383134a65
> "mmc: sdhci-pltfm: Add structure for host-specific data" and
> a4d2177f00a5252d825236c5124bc1e9918bdb41 "mmc: sdhci-pltfm: dt
> device does not pass parent to sdhci_alloc_host") while there
> does not seem to be any reason to use platform device's parent
> in the first place.
> 
> The comment saying "Some PCI-based MFD need the parent here"
> seem to refer to Timberdale FPGA driver (the only MFD driver
> registering SDHCI cell, drivers/mfd/timberdale.c) but again,
> the only situation when parent device matter is runtime PM,
> which is not implemented for Timberdale.
> 
> Cc: Chris Ball <chris@printf.net>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> 
> This patch is a part of effort to remove references to platform_bus
> and make it static.
> 
> Chris, Anton, Ulf - could you please advise if the assumptions
> above are correct or if I'm completely wrong? Do you know what
> where the real reasons to use parent originally? The PCI comment
> seems like a red herring to me...

Can I take the silence as a suggestion that the change looks ok-ish for
you?

Paweł
