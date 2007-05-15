Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0DD5DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 10:06:26 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705150139.41722.arnd@arndb.de>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<200705141637.19572.arnd@arndb.de>
	<1179176381.32247.98.camel@localhost.localdomain>
	<200705150139.41722.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 15 May 2007 10:06:17 +1000
Message-Id: <1179187577.32247.140.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> An interesting case is the frame buffer, most fb drivers use hardcoded
> register numbers for the VGA ports, without calling check_legacy_ioport,
> but rely on PCI probing to detect the presence of the device.
> Some IDE drivers do the same, but libata does not. Apparently, these
> are already broken if you plug such hardware into a secondary PCI bus.

VGA is on my todo list for a fix. A lot of framebuffers don't access
legacy VGA ports though. I'm pretty sure none of the ATI or nvidia ones
do nowadays.

We need three different things I beleive:

 - A clean/generic way to obtain the pci_dev for vgacon/vesafb
 - A nice hook to provide an IO "offset" for a given PCI bus for legacy
   accesses (which is allowed to fail if that bus cannot do it).
 - Same for VGA memory

Ben.
