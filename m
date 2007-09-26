Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B7B6DDE32
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 19:43:31 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q9hQdX462516
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 09:43:26 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q9hQFA1925138
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:43:26 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q9hPRO007015
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:43:26 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] [REPOST] PowerPC: ibmebus refactoring and fixes
MIME-Version: 1.0
Date: Wed, 26 Sep 2007 11:43:24 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261143.24735.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
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

This is a repost of my previous patchset incorporating Arnd's comments.

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


 arch/powerpc/kernel/ibmebus.c             |  267 ++++++++-----------------=
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
 11 files changed, 228 insertions(+), 350 deletions(-)

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com
