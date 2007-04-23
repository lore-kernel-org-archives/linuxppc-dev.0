Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F6DADDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 02:20:33 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3NGKSMa050820
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 16:20:28 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3NGKSl32261096
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 18:20:28 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3NGKRkZ022221
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 18:20:28 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Date: Mon, 23 Apr 2007 18:20:27 +0200
MIME-Version: 1.0
Subject: [PATCH] ib_core: Add missing device link to class device
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704231820.27752.fenkes@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the missing device link from /sys/class/infiniband/* to the actual devi=
ce.


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
=2D--

 sysfs.c |    1 +
 1 file changed, 1 insertion(+)

=2D-- linux-2.6.20/drivers/infiniband/core/sysfs.c.old    2007-04-23 15:37:=
37.000000000 +0200
+++ linux-2.6.20/drivers/infiniband/core/sysfs.c        2007-04-23 15:38:22=
=2E000000000 +0200
@@ -683,6 +683,7 @@ int ib_device_register_sysfs(struct ib_d

        class_dev->class      =3D &ib_class;
        class_dev->class_data =3D device;
+       class_dev->dev        =3D device->dma_device;
        strlcpy(class_dev->class_id, device->name, BUS_ID_SIZE);

        INIT_LIST_HEAD(&device->port_list);

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com =A0-- =A0Phone: +49 7031 16 1239
