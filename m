Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 879FCB7D43
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 07:21:41 +1000 (EST)
Received: by gyf2 with SMTP id 2so1218051gyf.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jun 2010 14:21:39 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100604205930.2762.17131.stgit@angua>
References: <20100604205930.2762.17131.stgit@angua>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 4 Jun 2010 15:13:35 -0600
Message-ID: <AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
Subject: [PATCH 0/2] Replace of_device with platform_device
To: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michal Simek <monstr@monstr.eu>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is based on Linus' current tree. =A0It eliminate struct
of_device in preparation for the merge of of_platform_bus_type and
platform_bus_type.

Assuming there are no objections, I'll be putting these to linux-next
to stew sometime next week.

g.

---

Grant Likely (2):
=A0 =A0 =A0sparc/of: Move of_device fields into struct pdev_archdata
=A0 =A0 =A0of: kill struct of_device


=A0arch/microblaze/include/asm/of_device.h | =A0 10 ----------
=A0arch/powerpc/include/asm/of_device.h =A0 =A0| =A0 11 -----------
=A0arch/powerpc/include/asm/smu.h =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
=A0arch/sparc/include/asm/device.h =A0 =A0 =A0 =A0 | =A0 =A09 +++++++--
=A0arch/sparc/include/asm/floppy_64.h =A0 =A0 =A0| =A0 =A04 ++--
=A0arch/sparc/include/asm/of_device.h =A0 =A0 =A0| =A0 19 -----------------=
--
=A0arch/sparc/include/asm/parport.h =A0 =A0 =A0 =A0| =A0 =A04 ++--
=A0arch/sparc/kernel/of_device_32.c =A0 =A0 =A0 =A0| =A0 28 ++++++++++++---=
-------------
=A0arch/sparc/kernel/of_device_64.c =A0 =A0 =A0 =A0| =A0 24 ++++++++++-----=
---------
=A0arch/sparc/kernel/of_device_common.c =A0 =A0| =A0 =A04 ++--
=A0arch/sparc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0arch/sparc/kernel/pci_psycho.c =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++++----
=A0arch/sparc/kernel/pci_sabre.c =A0 =A0 =A0 =A0 =A0 | =A0 =A08 ++++----
=A0arch/sparc/kernel/pci_schizo.c =A0 =A0 =A0 =A0 =A0| =A0 20 ++++++++++---=
-------
=A0arch/sparc/kernel/power.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0drivers/atm/fore200e.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
=A0drivers/input/serio/i8042-sparcio.h =A0 =A0 | =A0 =A08 ++++----
=A0drivers/net/myri_sbus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0drivers/net/niu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06=
 +++---
=A0drivers/net/niu.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04=
 ++--
=A0drivers/net/sunbmac.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0drivers/net/sunhme.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +=
++---
=A0drivers/net/sunlance.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
=A0drivers/net/sunqe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +=
++---
=A0drivers/parport/parport_sunbpp.c =A0 =A0 =A0 =A0| =A0 =A02 +-
=A0drivers/sbus/char/bbc_i2c.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +++---
=A0drivers/sbus/char/uctrl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0drivers/scsi/qlogicpti.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
=A0drivers/scsi/sun_esp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
=A0drivers/serial/sunhv.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++-=
-
=A0drivers/serial/sunsab.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0drivers/serial/sunsu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
=A0drivers/serial/sunzilog.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10 +++++----=
-
=A0drivers/watchdog/cpwd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0include/linux/of_device.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 +++++++++=
++++++++
=A0sound/sparc/amd7930.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
=A0sound/sparc/cs4231.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +++=
++++-------
=A0sound/sparc/dbri.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +-
=A038 files changed, 120 insertions(+), 146 deletions(-)

--
Signature



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
