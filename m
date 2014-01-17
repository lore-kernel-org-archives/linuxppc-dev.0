Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D12EC2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:57:29 +1100 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 17 Jan 2014 11:57:24 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 34F371DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 08:57:22 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0HDupbA36438218
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 11:56:51 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0HDvLu3018076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 11:57:21 -0200
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/pseries: add Gen3 definitions for PCIE link speed
Date: Fri, 17 Jan 2014 11:56:52 -0200
Message-Id: <1389967012-7774-3-git-send-email-klebers@linux.vnet.ibm.com>
In-Reply-To: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
References: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rev3 of the PCI Express Base Specification defines a Supported Link
Speeds Vector where the bit definitions within this field are:

Bit 0 - 2.5 GT/s
Bit 1 - 5.0 GT/s
Bit 2 - 8.0 GT/s

This vector definition is used by the platform firmware to export the
maximum and current link speeds of the PCI bus via the
"ibm,pcie-link-speed-stats" device-tree property.

This patch updates pseries_root_bridge_prepare() to detect Gen3
speed buses (defined by 0x04).

Signed-off-by: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index a6f7a14..c413ec1 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -144,6 +144,9 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 	case 0x02:
 		bus->max_bus_speed = PCIE_SPEED_5_0GT;
 		break;
+	case 0x04:
+		bus->max_bus_speed = PCIE_SPEED_8_0GT;
+		break;
 	default:
 		bus->max_bus_speed = PCI_SPEED_UNKNOWN;
 		break;
@@ -156,6 +159,9 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 	case 0x02:
 		bus->cur_bus_speed = PCIE_SPEED_5_0GT;
 		break;
+	case 0x04:
+		bus->cur_bus_speed = PCIE_SPEED_8_0GT;
+		break;
 	default:
 		bus->cur_bus_speed = PCI_SPEED_UNKNOWN;
 		break;
-- 
1.7.1
