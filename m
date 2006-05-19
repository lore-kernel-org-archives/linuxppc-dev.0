Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C16B67A40
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 15:24:36 +1000 (EST)
Subject: pci-OF-bus-map deprecation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 15:24:28 +1000
Message-Id: <1148016268.13249.14.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For 32 bits machines with Open Firmware, we used to create a
pci-OF-bus-map property in the device-tree that provided a mapping
between linux and Open Firmware PCI bus numbers (since on some platforms
like PowerMac, we still renumber PCI busses).

This property is no longer necessary as

 - Nowadays, we have sysfs and the PCI devices in there do have a full
Open Firmware device path exposed as a "devspec" file in their sysfs
directories
 - I don't think anybody ever used that property in userland :)

This mail is mostly to make sure of the later. I intend to get rid of it
in 2.6.18 (that's early, but as I said, I think nobody uses it anyway. I
intended to use it in some X stuff I never ended up actually
implementing...)

It only concerns 32 bits ppc machines with OF, and only the ones that
renumber busses, which means basically only PowerMacs.

Ben.
