Return-Path: <a.korud@vector.com.pl>
Received: from 3bit.vector.com.pl (3bit.vector.com.pl [81.210.9.37])
	by ozlabs.org (Postfix) with ESMTP id 6CDB967B3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 23:18:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 6 May 2005 15:18:33 +0200
Message-ID: <60E856FD577CC04BA3727AF4122D3F16113578@3bit.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@ozlabs.org>
Subject: PCI mapping problems? (440EP/Bamboo)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, I'm trying to make PCI on Bamboo usable at 33MHz and have the =
following problem:
Kernel 2.6.11 with Bamboo patches (either from the list or my own) =
boots, PCI is scanned fine:

PCI: Probing PCI hardware
Scanning bus 00
Found 00:20 [1260/3890] 000280 00
Fixups for bus 00
Bus scan for 00 returning with max=3D00
PCI fixup irq: (0000:00:04.0) got 25
PCI: bridge rsrc 0..ffff (100), parent c01b0f80
PCI: bridge rsrc a0000000..afffffff (200), parent c01b0f64
PCI:0000:00:04.0: Resource 0: afffe000-afffffff (f=3D200)

lspci is also working fine, but when trying to load any driver, kernel =
crashes on first actual device access, i.e. on writew() operation.
When tried to look which address it's trying to access - 0xd1058000 in =
my case - seems confusing for me - should not this address be withing =
PCI address range - 0xa... and withing this device address range - =
0xafffe000-afffffff?
Tracking deeper I've found that this address is taken from calling =
pci_resource_start(pdev, 0) whithing probe function in driver.=20

This problem is generic - at least 3 different pci drivers crash when =
trying to writew() to bad address.

Can anybody give some advice in which direction should I continue my =
debugging?

Thanks in advance,

--

Andriy Korud
