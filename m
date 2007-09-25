Return-Path: <fenkes@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2AEFEDDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 22:11:07 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8PCB3Bc422612
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 12:11:03 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8PCB2Dm2703466
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 13:11:02 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8PCAkBc006701
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 13:10:46 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] PowerPC: ibmebus refactoring and fixes
Date: Tue, 25 Sep 2007 14:10:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251410.29780.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan-Bernd Themann <themann@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patchset will merge the ibmebus and of_platform bus drivers by basing a
lot of ibmebus functionality on of_platform code and adding the features
specific to ibmebus on top of that.

I split the actual ibmebus rework into three patches (2/5-4/5) for easier
readability. The kernel will compile during the intermediate states, and
ibmebus will not crash, but not work either.

As a side-effect of patch 3/5, a problem with bus_id collisions in case of
two devices sharing the same location code is resolved -- the bus_id is now
determined differently.

[1/5] moves of_device allocation into of_device.[ch]
[2/5] removes the old bus match/probe/remove functions
[3/5] adds device creation and bus probing based on of_device
[4/5] finally moves to of_device and of_platform_driver by changing
      ibmebus.h and matching the eHCA and eHEA drivers
[5/5] just changes a nit in ibmebus_store_probe()

These patches should apply cleanly, in order, against 2.6.23-rc5 and against
Linus' git. Please review and comment them, and queue them up for 2.6.24 if
you think they're okay.

Thanks and regards,
  Joachim

 arch/powerpc/kernel/ibmebus.c             |  263 ++++++++-----------------=
=2D---
 arch/powerpc/kernel/of_device.c           |   80 +++++++++
 arch/powerpc/kernel/of_platform.c         |   70 +--------
 drivers/infiniband/hw/ehca/ehca_classes.h |    2 +-
 drivers/infiniband/hw/ehca/ehca_eq.c      |    6 +-
 drivers/infiniband/hw/ehca/ehca_main.c    |   32 ++--
 drivers/net/ehea/ehea.h                   |    2 +-
 drivers/net/ehea/ehea_main.c              |   72 ++++----
 include/asm-powerpc/ibmebus.h             |   38 +----
 include/asm-powerpc/of_device.h           |    4 +
 include/linux/of_device.h                 |    5 +
 11 files changed, 226 insertions(+), 348 deletions(-)

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com
