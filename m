Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEA50DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:11 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/9] powerpc/pci: clean up direct access to sysdata
Date: Thu, 30 Apr 2009 08:09:59 -0500
Message-Id: <1241096999-11164-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't be accessing sysdata directly.  In the future we might have
sysdata be a device_node on ppc32 to match ppc64.  Direct access would make that
a bit difficult.

If someone can look at the iseries code I would appreciate that:

arch/powerpc/platforms/iseries/pci.c:           iomm_table[current_iomm_table_entry] = dev->sysdata;
arch/powerpc/platforms/iseries/pci.c:                   iseries_ds_addr(dev->sysdata) | (bar_num << 24);
arch/powerpc/platforms/iseries/pci.c:   pdev->sysdata = node;

- k
