Return-Path: <danielwa@cisco.com>
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlCC43N2gzDr2Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 06:33:52 +1000 (AEST)
From: Daniel Walker <danielwa@cisco.com>
Subject: t1040 IFC flash driver Extended Chip Select
To: Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Jaiprakash Singh <b44839@freescale.com>, Scott Wood
 <scottwood@freescale.com>,
 Lijun Pan <Lijun.Pan@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>
Message-ID: <577D68B8.8020305@cisco.com>
Date: Wed, 6 Jul 2016 13:23:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We are using the t1040 platform, and we have found that we need to 
populate this register. In the Technical Reference Manual it's 
description is section 24.3.2. This option appears in the driver, but it 
doesn't appears to be used anyplace.

We we're considered adding something to the device tree to allow 
populating this value, but I'm wondering if any of you have specific 
considerations on how this is done. Or maybe it's not needed at all, and 
we're just missing something.

(not a good patch, just an example.)

diff --git 
a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt 
b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
index 89427b0..b506001 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
@@ -24,6 +24,8 @@ Properties:
  - ranges : Each range corresponds to a single chipselect, and covers
             the entire access window as configured.

+- cspr_ext : This value sets the extended chip select for all banks.
+
  Child device nodes describe the devices connected to IFC such as NOR (e.g.
  cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
  like FPGAs, CPLDs, etc.


Daniel
