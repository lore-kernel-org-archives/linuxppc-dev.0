Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 09B401A0725
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 02:50:21 +1000 (AEST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] PCI: arm64/powerpc: Fix parsing of linux,
 pci-probe-only
Date: Fri,  4 Sep 2015 17:50:07 +0100
Message-Id: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pci-host-generic driver parses the linux,pci-probe-only property,
and assumes that it will have a boolean parameter.

Turns out that the Seattle DTS file has a naked "linux,pci-probe-only"
property, which leads to the driver dereferencing some unsuspecting
memory location. Nothing really bad happens (we end up reading some
other bit of DT, fortunately), but that not a reason to keep it this
way. Turns out that the Pseries code (where this code was lifted from)
may suffer from the same issue.

The first patch introduces a common (and fixed) version of that check
that can be used by drivers and architectures that require it. The two
following patches change the pci-host-generic driver and the powerpc
code to use it.

Finally, the bad property is removed from the Seatle DTS, because it
is simply not necessary (it actually prevents me from using SR-IOV,
which otherwise runs fine without the probe-only thing).

This has been tested on the offending Seattle board.

* From v3:
  - Restrict the property lookup to /chosen (Rob)
  - Acked-by on patch #4 from Suravee
  - I swear this is the last time I rework these patches! ;-)

* From v2:
  - Use of_property_read_u32 to safely read the property (Rob)
  - Add a log message to indicate when we enable probe-only
    (probably quite useful for debugging)

* From v1:
  - Consolidate the parsing in of_pci.c (Bjorn)

Marc Zyngier (4):
  of/pci: Add of_pci_check_probe_only to parse "linux,pci-probe-only"
  PCI: pci-host-generic: Fix lookup of linux,pci-probe-only property
  powerpc: PCI: Fix lookup of linux,pci-probe-only property
  arm64: dts: Drop linux,pci-probe-only from the Seattle DTS

 arch/arm64/boot/dts/amd/amd-overdrive.dts |  1 -
 arch/powerpc/platforms/pseries/setup.c    | 14 ++------------
 drivers/of/of_pci.c                       | 28 ++++++++++++++++++++++++++++
 drivers/pci/host/pci-host-generic.c       |  9 +--------
 include/linux/of_pci.h                    |  3 +++
 5 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.1.4
