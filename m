Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EAE90DDE07
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 21:05:58 +1100 (EST)
Message-Id: <20090330100241.346785618@denx.de>
Date: Mon, 30 Mar 2009 12:02:41 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH v4 0/4] NAND: Multi-chip support for FSL-UPM for TQM8548
	modules
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is my forth version of the patch series adding generic support
for multi-chip NAND devices to the FSL-UPM driver and support for
the Micron MT29F8G08FAB NAND flash memory on the TQM8548 modules.
It addresses the issues reported on the mailing list, e.g. the new
bindings are now documented as well:

 NAND: FSL-UPM: add multi chip support
 NAND: FSL-UPM: Add wait flags to support board/chip specific delays
 powerpc: NAND: FSL UPM: document new bindings
 powerpc/85xx: TQM8548: Update DTS file for multi-chip support

Changes since v3:
  - As Grant suggested, the property "fsl,upm-addr-line-cs-offsets"
    is now used to define multi-chip support using dedicated address
    lines for chip selection. This make the properties "num-chips"
    and "chip-offset" obsolte.

  - As Grant suggested, I added the string "tqc,tqm8548-upm-nand" to
    the list of compatible devices for the TQM8548 modules in case it
    turns out in the future that the "fsl,upm-addr-line-cs-offsets"
    method is not generic enough.

  - For multi-chip chip devices, the name "mchip" is now used in the
    code to avoid confusion with the normal NAND "chip".

  - Coding style fixes as pointed out by Anton.

Patch 3 and 4 should go through the powerpc maintainer(s).

Hope this patch series is fine now for inclusion into 2.6.30.

Thanks,

Wolfgang.
