Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1C29679FA
	for <linuxppc-dev@ozlabs.org>; Mon, 30 May 2005 13:41:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 30 May 2005 13:35:54 +1000
Message-Id: <1117424155.5228.28.camel@gaston>
Mime-Version: 1.0
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: [PATCH] ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, the patch is now getting "good enough" for wider testing. It applies
on current "git" tree (or 2.6.12-rc6 when/if that is ever released). It
requires one other patch to be applied first:

http://gate.crashing.org/~benh/ppc32-remove-macserial.diff

The PM patch itself can be found at:

http://gate.crashing.org/~benh/ppc32-rework-pm.diff

This patch completely reworks both suspend-to-ram and suspend-to-disk
support on PowerMac:

 - suspend-to-ram code is moved away from the via-pmu.c driver
 - both suspend-to-disk & to-ram consolidated to use the same
infrastructure and code base in a new pmac_pm.c file
 - significants fixes & improvements to suspend-to-disk
 - for now (may change), use the "refrigerator" with suspend-to-ram as
well as suspend-to-disk. This may help make it a bit more robust vs.
userland activity during the sleep process
 - CONFIG_PMAC_PBOOK is gone. CONFIG_PMAC_MEDIABAY is new and controls
wether the powerbook hostwap bay driver is included. The rest of bits
formerly under CONFIG_PMAC_PBOOK control are now either always on
(like /dev/pmu interface on PMU based machines) or dependent on other
config options (like CONFIG_PM, CONFIG_PPC_PMAC, ...)

The patch will not be in 2.6.12 (though will probably apply on top of
it). I aim for a 2.6.13 release, knowing that the patch changes a bunch
of non-ppc-specific power management bits, and thus may need some time
to be fully merged upstream.
