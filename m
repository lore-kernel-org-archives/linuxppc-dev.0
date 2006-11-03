Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 795B267D8E
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 03:47:32 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA3GlN1f062956
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 16:47:26 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA3GoKV82814180
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 17:50:20 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA3GlMCv030317
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 17:47:22 +0100
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.19-rc4 1/3] ehea: Nullpointer dereferencation fix
Date: Fri, 3 Nov 2006 17:47:20 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611031747.21667.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix: Must check for nullpointer before dereferencing it - not afterwards.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---

diff -Nurp git.netdev-2.6.base/drivers/net/ehea/ehea_qmr.c git.netdev-2.6/drivers/net/ehea/ehea_qmr.c
--- git.netdev-2.6.base/drivers/net/ehea/ehea_qmr.c	2006-11-03 14:19:51.000000000 +0100
+++ git.netdev-2.6/drivers/net/ehea/ehea_qmr.c	2006-11-03 14:27:53.000000000 +0100
@@ -209,11 +209,11 @@ int ehea_destroy_cq(struct ehea_cq *cq)
 {
 	u64 adapter_handle, hret;
 
-	adapter_handle = cq->adapter->handle;
-
 	if (!cq)
 		return 0;
 
+	adapter_handle = cq->adapter->handle;
+
 	/* deregister all previous registered pages */
 	hret = ehea_h_free_resource(adapter_handle, cq->fw_handle);
 	if (hret != H_SUCCESS) {
