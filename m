Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 09C0CB7D61
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 00:12:24 +1000 (EST)
Received: by iwn8 with SMTP id 8so1879239iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jun 2010 07:12:23 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100608140917.25879.67745.stgit@angua>
References: <20100608140917.25879.67745.stgit@angua>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Jun 2010 08:12:03 -0600
Message-ID: <AANLkTilkT78iqlR6_E2uBLUC-OJnQZ6ax4d_lqUnjAw2@mail.gmail.com>
Subject: [PATCH 0/5] Merge common address translation code (ppc & mb)
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au, Wolfram Sang <w.sang@pengutronix.de>,
	linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These five patches merge common code for decoding address ranges from
the device tree. =A0Simple mechanical change. =A0There should be no functio=
nal
difference except for the last patch which restricts the no-ranges code
to be powerpc-only.

These patches are based on top of the IRQ merge which I posted earlier.
If you want to test them, I've pushed the commits out to the here:

git://git.secretlab.ca/git/linux-2.6 devicetree-test

Cheers,
g.

---

Grant Likely (5):
=A0 =A0 =A0of/address: merge of_iomap()
=A0 =A0 =A0of/address: merge of_address_to_resource()
=A0 =A0 =A0of/address: Merge all of the bus translation code
=A0 =A0 =A0of/address: little-endian fixes
=A0 =A0 =A0of/address: restrict 'no-ranges' kludge to powerpc


=A0arch/microblaze/include/asm/pci-bridge.h | =A0 =A05
=A0arch/microblaze/include/asm/prom.h =A0 =A0 =A0 | =A0 31 +-
=A0arch/microblaze/kernel/prom_parse.c =A0 =A0 =A0| =A0546 ----------------=
------------
=A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0| =A0 =A05
=A0arch/powerpc/include/asm/prom.h =A0 =A0 =A0 =A0 =A0| =A0 31 +-
=A0arch/powerpc/kernel/prom_parse.c =A0 =A0 =A0 =A0 | =A0573 --------------=
---------------
=A0drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
4
=A0drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1
=A0drivers/of/address.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0595 ++=
++++++++++++++++++++++++++++
=A0include/linux/of_address.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +
=A010 files changed, 634 insertions(+), 1169 deletions(-)
=A0create mode 100644 drivers/of/address.c
=A0create mode 100644 include/linux/of_address.h



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
