Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C13C4DDEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 09:47:21 +1000 (EST)
Date: Tue, 10 Jul 2007 01:47:14 +0200 (MEST)
Message-Id: <200707092347.l69NlElB023451@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linuxppc-dev@ozlabs.org
Subject: [2.6.22] powerpc: section mismatch for macmodes.c:mac_find_mode()
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A vanilla 2.6.22 built for ppc32 and configured with CONFIG_FB_MACMODES=y, CONFIG_HOTPLUG=n,
and CONFIG_MODULES=y, triggers the following warning from modpost:

WARNING: drivers/built-in.o(__ksymtab+0x3b0): Section mismatch: reference to .init.text:mac_find_mode (between '__ksymtab_mac_find_mode' and '__ksymtab_mac_map_monitor_sense')

There's an EXPORT_SYMBOL(mac_find_mode), but mac_find_mode() is __devinit
and thus __init in this kernel.

/Mikael
