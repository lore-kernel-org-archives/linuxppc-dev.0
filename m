Return-Path: <Robert.Richter@caviumnetworks.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0060.outbound.protection.outlook.com [157.56.111.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DF901A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 00:01:01 +1100 (AEDT)
Date: Tue, 2 Feb 2016 12:26:42 +0100
From: Robert Richter <robert.richter@caviumnetworks.com>
To: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-ia64@vger.kernel.org>, <linux-metag@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <Will.Deacon@arm.com>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <grant.likely@linaro.org>,
 <leif.lindholm@linaro.org>, <rfranz@cavium.com>, <ard.biesheuvel@linaro.org>,
 <msalter@redhat.com>, <steve.capper@linaro.org>, <hanjun.guo@linaro.org>,
 <al.stone@linaro.org>, <arnd@arndb.de>, <pawel.moll@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, <rjw@rjwysocki.net>,
 <lenb@kernel.org>, <marc.zyngier@arm.com>, <lorenzo.pieralisi@arm.com>,
 <bhelgaas@google.com>, <tony.luck@intel.com>, <fenghua.yu@intel.com>,
 <james.hogan@imgtec.com>, <benh@kernel.crashing.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
 <jonathan@jonmasters.org>, <Prasun.Kapoor@caviumnetworks.com>,
 <gpkulkarni@gmail.com>
Subject: Re: [PATCH v10 0/8] arm64, numa: Add numa support for arm64 platforms
Message-ID: <20160202112642.GE24726@rric.localdomain>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02.02.16 15:39:15, Ganapatrao Kulkarni wrote:

> Ganapatrao Kulkarni (8):
>   arm64, numa: adding numa support for arm64 platforms.
>   Documentation, dt, numa: dt bindings for numa.
>   dt, numa: adding numa dt binding implementation.
>   arm64, numa : Enable numa dt for arm64 platforms.
>   arm64, dt, thunderx: Add initial dts for Cavium Thunderx in 2 node
>     topology.
>   arm64, mm, numa: Adding numa balancing support for arm64.
>   topology, cleanup: Avoid redefinition of cpumask_of_pcibus in asm
>     header files.
>   numa, mm, cleanup: remove redundant NODE_DATA macro from asm header
>     files.

I have tested the whole series on single and dual node systems for
devicetree and acpi (with Hanjun's acpi numa v3 patches ported on
top).

Tested-by: Robert Richter <rrichter@cavium.com>

-Robert

> 
>  Documentation/devicetree/bindings/numa.txt      | 272 ++++++++
>  arch/arm64/Kconfig                              |  26 +
>  arch/arm64/boot/dts/cavium/Makefile             |   2 +-
>  arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts  |  83 +++
>  arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi | 806 ++++++++++++++++++++++++
>  arch/arm64/include/asm/mmzone.h                 |  10 +
>  arch/arm64/include/asm/numa.h                   |  45 ++
>  arch/arm64/include/asm/pgtable.h                |  18 +
>  arch/arm64/include/asm/topology.h               |   7 +
>  arch/arm64/kernel/pci.c                         |  10 +
>  arch/arm64/kernel/setup.c                       |   4 +
>  arch/arm64/kernel/smp.c                         |   4 +
>  arch/arm64/mm/Makefile                          |   1 +
>  arch/arm64/mm/init.c                            |  34 +-
>  arch/arm64/mm/mmu.c                             |   1 +
>  arch/arm64/mm/numa.c                            | 404 ++++++++++++
>  arch/ia64/include/asm/topology.h                |   4 -
>  arch/m32r/include/asm/mmzone.h                  |   4 +-
>  arch/metag/include/asm/mmzone.h                 |   4 +-
>  arch/metag/include/asm/topology.h               |   3 -
>  arch/powerpc/include/asm/mmzone.h               |   8 +-
>  arch/powerpc/include/asm/topology.h             |   4 -
>  arch/s390/include/asm/mmzone.h                  |   6 +-
>  arch/s390/include/asm/pci.h                     |   2 +-
>  arch/s390/include/asm/topology.h                |   1 +
>  arch/sh/include/asm/mmzone.h                    |   4 +-
>  arch/sh/include/asm/topology.h                  |   3 -
>  arch/sparc/include/asm/mmzone.h                 |   6 +-
>  arch/tile/include/asm/pci.h                     |   2 -
>  arch/tile/include/asm/topology.h                |   3 +
>  arch/x86/include/asm/mmzone.h                   |   3 +-
>  arch/x86/include/asm/mmzone_32.h                |   5 -
>  arch/x86/include/asm/mmzone_64.h                |  17 -
>  arch/x86/include/asm/pci.h                      |   2 +-
>  arch/x86/include/asm/topology.h                 |   1 +
>  drivers/of/Kconfig                              |  11 +
>  drivers/of/Makefile                             |   1 +
>  drivers/of/of_numa.c                            | 207 ++++++
>  include/asm-generic/mmzone.h                    |  24 +
>  include/asm-generic/topology.h                  |   4 +-
>  include/linux/of.h                              |   4 +
>  41 files changed, 1986 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/numa.txt
>  create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts
>  create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi
>  create mode 100644 arch/arm64/include/asm/mmzone.h
>  create mode 100644 arch/arm64/include/asm/numa.h
>  create mode 100644 arch/arm64/mm/numa.c
>  delete mode 100644 arch/x86/include/asm/mmzone_64.h
>  create mode 100644 drivers/of/of_numa.c
>  create mode 100644 include/asm-generic/mmzone.h
> 
> -- 
> 1.8.1.4
> 
