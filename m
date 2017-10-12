Return-Path: <wangzhou.bry@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCS14521jzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 21:35:36 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id z80so5429745pff.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 03:35:36 -0700 (PDT)
Date: Thu, 12 Oct 2017 18:35:29 +0800
From: Sherlock Wang <wangzhou.bry@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lukas Wunner <lukas@wunner.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rongrong Zou <zourongrong@gmail.com>,
 Dave Airlie <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 0/2] vgaarb: Select fallback default VGA device
Message-ID: <20171012103529.GA5378@T440>
References: <20171006221358.12211.42879.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171006221358.12211.42879.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 06, 2017 at 05:24:20PM -0500, Bjorn Helgaas wrote:
> These patches are supposed to fix a problem Daniel Axtens found on the
> HiSilicon D05 board.  The VGA device there is behind a bridge that doesn't
> support PCI_BRIDGE_CTL_VGA, so the arbiter never selects the device as the
> default.
> 
> The first patch extends the arbiter so that if it can't find an enabled VGA
> device with legacy resources, it selects the first enabled device *without*
> legacy resources (this is what fixes the D05).  If that fails, it selects
> the first device that isn't enabled.  The combination of both changes
> should make the current powerpc fixup_vga() quirk unnecessary.
> 
> N.B. It changes the powerpc behavior: if there are several enabled VGA
> devices, the current quirk selects the last one, while this patch selects
> the first one.  If this is a problem, I can drop that part of the patch and
> keep the quirk.
> 
> The second patch pulls out this fallback device detection (and the EFI
> override) from vga_arb_device_init() to make it easier to read.

Hi Bjorn,

I tested this series in:

        D05 board based on HiSilicon SoC Hip07.
        And HiSilicon SoC Hip08 based board.

Both of these two SoCs' PCIe host bridge don't support PCI_BRIDGE_CTL_VGA. One
VGA device which does not support legacy resources has been connected to these
two PCIe host bridges to test. Default VGA device can be selected in above two
systems.

Tested-by: Zhou Wang <wangzhou1@hisilicon.com>
(sorry for my HiSilicon E-mail box miss this serias, so here I have to use my
gmail box)

Thanks,
Zhou

> 
> ---
> 
> Bjorn Helgaas (2):
>       vgaarb: Select a default VGA device even if there's no legacy VGA
>       vgaarb: Factor out EFI and fallback default device selection
> 
> 
>  arch/powerpc/kernel/pci-common.c |   12 ------
>  drivers/gpu/vga/vgaarb.c         |   72 +++++++++++++++++++++++++++++---------
>  2 files changed, 55 insertions(+), 29 deletions(-)
