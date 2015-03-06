Return-Path: <robherring2@gmail.com>
Received: from mail-we0-x230.google.com (mail-we0-x230.google.com
 [IPv6:2a00:1450:400c:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F234A1A0358
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 01:20:15 +1100 (AEDT)
Received: by wevk48 with SMTP id k48so16287026wev.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2015 06:20:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1425634426-437-17-git-send-email-wangyijing@huawei.com>
References: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
 <1425634426-437-17-git-send-email-wangyijing@huawei.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 6 Mar 2015 08:19:51 -0600
Message-ID: <CAL_JsqJqpbTThfm2yctHr-gyySyxsJT3HS8rxm6oY+ZYVT5vvQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/29] powerpc/pci: Use pci_scan_host_bridge() for
 simplicity
To: Yijing Wang <wangyijing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ia64@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Rusty Russell <rusty@rustcorp.com.au>, linux-m68k@lists.linux-m68k.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiang Liu <jiang.liu@linux.intel.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2015 at 3:33 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Now we could use pci_scan_host_bridge() to scan
> pci buses, provide powerpc specific pci_host_bridge_ops.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/machdep.h       |    2 +-
>  arch/powerpc/kernel/pci-common.c         |   63 ++++++++++++++++++------------
>  arch/powerpc/platforms/pseries/pci.c     |    8 ++--
>  arch/powerpc/platforms/pseries/pseries.h |    2 +-
>  4 files changed, 44 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 8e7f2a8..b811d12 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -129,7 +129,7 @@ struct machdep_calls {
>         void            (*pcibios_fixup)(void);
>         int             (*pci_probe_mode)(struct pci_bus *);
>         void            (*pci_irq_fixup)(struct pci_dev *dev);
> -       int             (*pcibios_set_root_bus_speed)(struct pci_host_bridge
> +       void            (*pcibios_set_root_bus_speed)(struct pci_host_bridge
>                                 *bridge);

Shouldn't this be part of patch 15?

Rob
