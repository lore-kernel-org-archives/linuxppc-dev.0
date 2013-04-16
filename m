Return-Path: <andrew.murray@arm.com>
Date: Tue, 16 Apr 2013 11:30:06 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
Message-ID: <20130416103005.GB12726@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
Cc: "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, "paulus@samba.org" <paulus@samba.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
 "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
> The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> property of a PCI host device, is found in both Microblaze and PowerPC
> architectures. These implementations are nearly identical. This patch
> moves this common code to a common place.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/pci-bridge.h |    5 +-
>  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
>  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
>  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------

Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?

I've tested that it builds on powerpc with a variety of configs (some which
include fsl_pci.c implementation). Though I don't have hardware to verify that
it works.

I haven't tested this builds or runs on MIPS.

You shouldn't see any difference in behaviour or new warnings and PCI devices
should continue to operate as before.

Andrew Murray
