Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656C60703C8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ni+fG2SE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL8K53f0Qz2yYK;
	Fri, 06 Nov 2026 04:23:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793899385;
	cv=pass; b=FJua956B2Xc6yKxSOZ8EkrH+5EnP0+m2r4dsgNqCUSOwVIKMVvwNoSqvSZU8hQvleBGIfGEsfK4va9aso0PKSIwlffQMiR/Jr6MZuk+SnevNVZi6GP+OYhbwMAPvVRXcRre8ygvoWHyT+ga5P6Co4Y7ARXPkdjx7leEdUJVX4pXPsbEdchVRA6i1/TFq6GHo+DRaLDylR1U+h41uhkyMI8L3SpeoLtl1tQK1NDNOAn6iAj55kuf583W9X+VtDIyGNY8IQ4AVwJFxbFomLtTGhx9i7PfSTj61jX28rL2iyktF0588X0gUTbziPGl8HB338xZLBgy7DpWFVVajNv6AFA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793899385; c=relaxed/relaxed;
	bh=umzygdDVW2LeAJS9+eYmUDrnwuO3TCUtCYoF+tS3zBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLv3AL+ywqtV++W8lzX2YMxep6VF38P/92vvJJ6f0Q2pRkDSTRBvc5yIUMtWot4/U7ORP7l9IZXG0UsDordXrrTg4LaeCqefJaW7ZLAejGu3fLYVVoWYD/NtcN5gy0dDvppGNI3DcIM9V52CCOJ31m06cQmuKVERt8zRFNBDc7zoc/LxLjnO0PLdy+Jy4pcu3MblTilwwAXZIrhrX8qrc1i34iX0zDsznOXTKuFv9HVDUsj2XI9f0yxlIO3eJoq7cQNDlXg2vNVAfcrCYfJUQInQ06c/J8Wz3ZttghM6WIUjLhqE25mag8JSBCf779SqjK8++gX9lnn6fOmOMHrLRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ni+fG2SE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ni+fG2SE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL8K26lwfz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:23:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E7C25405AA;
	Thu,  5 Nov 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793899380;
	b=vy720unSPxoViThqns/gAwzYul36mXz64l02K/OioRxilW0M8nemSSXWbkREhGZfwGVj
	 iJJ0rwhXO4GJMgQJ+yIFBiMWY4JVshYJzIyZwti7fXL43GiwyTnmMKXd5rLt6Z43tXuyB
	 vRC/wi+YoJWMK4MIY0+V6Ig+fAyu3d372M0GASaJKs6jOrmjNlAAgguKlrVKn/iphfC1e
	 CG6464tc7MJ8uhBnHmGZZJDX2g6tSIbZEMIsI9F56C56iHStV0QosQemUxVRmtmTz2UQY
	 fwKtRuSY3heaBuD1s/cqvXzoi4gme1p+4e3xCfJnuObS7TAsqoFjuW5YirSECZtm2rQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899380;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=umzygdDVW2LeAJS9+eYmUDrnwuO3TCUtCYoF+tS3zBU=;
	b=YRpVLh8MURyM/aWJwrPv2cUywQdYFMPD5OGjYHBiFDNgztuGW7dXiCGyT/kZmqaVg2hB
	 G1MzaZaUaGqd7NFQi07s6O7niZCyk/OByMTSVxfZoMM22LRzz4wmSElTcIcxpTNITiufU
	 DtvABdhatdUnQGCAjLUzdLey0wgL6dSDQ6wB06tT2+OlfSzC3igKDdaAoLgTKM1sCAm+q
	 gAD9xq3YSn+rbFziJeRrhiYcYqURdktGiZPjBYbCW8pq2ITH6YQwZ87UIULMsOYOsWbV/
	 TlR0xmZ2q8FyWfeI/ILILzyIOsYLGIKsTgIUe6D7jS7nCvAxUGVoufPsEClT3ljLVNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C93571F00A02;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899380;
	bh=umzygdDVW2LeAJS9+eYmUDrnwuO3TCUtCYoF+tS3zBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ni+fG2SESrTz8FAG4ITiJd5vLuP3NoMzPkcZdkMl97wBiFpnY/1nOlcwZLin835sT
	 r+9hgMH1uS50xI8/w3c3wXLn77I5D863HlEmdNZOCTsdALEoc6itby43Yhzt6gFYdq
	 aNXNns5m4spU9Dn7DwcqjWY52Ytdn/P1Fmp3jpu/hqpbggP5npdir6b6Mlnnk8oXHf
	 EPxuAnlsHzi7u2MGTR5Nr7V3cBvzNYdwP4fabhPCkGnTbg4sv03dAPz1FS94JJA177
	 Ci1U3esSZAat4TUDuiiMpF1u/n9j4AzdwYvbDg7RnsYaU2nrW7o/LrwjWJ/TYr/ndV
	 +Ph8DSD3MngdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5644147376;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 05 Nov 2026 11:22:56 -0600
Subject: [PATCH v18 03/13] scsi: ibmvfc: fix potential NULL pointer
 dereference on failed queue allocation
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-ibmvfc-fpin-support-v18-3-d683b74736a3@linux.ibm.com>
References: <20261105-ibmvfc-fpin-support-v18-0-d683b74736a3@linux.ibm.com>
In-Reply-To: <20261105-ibmvfc-fpin-support-v18-0-d683b74736a3@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793899377; l=9799;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=Vade6DpCNGAAAPJj1ha8++t0NnafC64ofgPnjQi31KI=;
 b=gFs5+l5cg9BQbGV0/D5ouLnIed3nsVxIgwmzfcohpIOGFxM5FbFn9cAb6gV2i5d/m/e6Ftpso
 sam0HtmZxTPBa/Zq5VEh/cKHCyOBOd3MYmeP+0/TIqaO6KBYeCWAi+1
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tyrel Datwyler <tyreld@linux.ibm.com>

Guard ibmvfc_deregister_channel() against calling H_FREE_SUB_CRQ on a
queue that was never registered and against memsetting a buffer that was
never allocated.

Add an scrq->cookie guard around the H_FREE_SUB_CRQ hypercall so it is
only issued when the cookie is non-zero; clear scrq->cookie to zero on
success to prevent double-free if the function is called again during
reset or teardown. Add scrq->cookie = 0 in the ibmvfc_register_channel()
irq_failed: cleanup path for the same reason. Guard the memset() of the
queue message buffer behind a check of scrq->msgs.handle to prevent a
NULL dereference when the function is called on a queue that was never
allocated, such as async_sub_crq when multi-queue is disabled or
initialization failed before ibmvfc_alloc_queue() was reached. Update the
error message to include channels->protocol so failures can be
distinguished across SCSI, NVMe, and async sub-CRQ channels.

Expose ibmvfc_deregister_channel() via VISIBLE_IF_KUNIT and
EXPORT_SYMBOL_IF_KUNIT and add a kernel-doc header to support KUnit
testing.

Add ibmvfc_get_first_vhost() to retrieve the first registered ibmvfc
adapter with a reference held; expose it via VISIBLE_IF_KUNIT and
EXPORT_SYMBOL_IF_KUNIT for use by KUnit tests.

Add SCSI_IBMVFC_KUNIT_TEST Kconfig entry and Makefile line, and create
ibmvfc_kunit.c with an ibmvfc-channel-test suite containing
ibmvfc_deregister_channel_guard_test(). The test verifies that calling
ibmvfc_deregister_channel() on a queue with cookie == 0 and
msgs.handle == NULL issues no hypercall, performs no memset, and leaves
the queue state unchanged.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/Kconfig                 | 10 ++++++
 drivers/scsi/ibmvscsi/Makefile       |  1 +
 drivers/scsi/ibmvscsi/ibmvfc-core.c  | 65 +++++++++++++++++++++++++++++++-----
 drivers/scsi/ibmvscsi/ibmvfc.h       |  8 +++++
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c | 63 ++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 4a2af0f702e1..f47789b1102d 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -759,6 +759,16 @@ config SCSI_IBMVFC
 	  To compile this driver as a module, choose M here: the
 	  module will be called ibmvfc.
 
+config SCSI_IBMVFC_KUNIT_TEST
+	tristate "KUnit tests for the IBM POWER Virtual FC Client" if !KUNIT_ALL_TESTS
+	depends on SCSI_IBMVFC && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Compile IBM POWER Virtual FC client KUnit tests. These tests
+	  cover the sub-CRQ channel deregistration guard path.
+	  To compile this driver as a module, choose M here: the module
+	  will be called ibmvfc_kunit.
+
 config SCSI_IBMVFC_TRACE
 	bool "enable driver internal trace"
 	depends on SCSI_IBMVFC
diff --git a/drivers/scsi/ibmvscsi/Makefile b/drivers/scsi/ibmvscsi/Makefile
index 9408c7f4cdee..a227bc633f3a 100644
--- a/drivers/scsi/ibmvscsi/Makefile
+++ b/drivers/scsi/ibmvscsi/Makefile
@@ -3,3 +3,4 @@ ibmvfc-objs := ibmvfc-core.o ibmvfc-nvme.o
 
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi.o
 obj-$(CONFIG_SCSI_IBMVFC)	+= ibmvfc.o
+obj-$(CONFIG_SCSI_IBMVFC_KUNIT_TEST)	+= ibmvfc_kunit.o
diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 145d559041f1..65829c3d2eea 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -31,6 +31,7 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_transport_fc.h>
 #include <scsi/scsi_bsg_fc.h>
+#include <kunit/visibility.h>
 #include "ibmvfc.h"
 
 static unsigned int init_timeout = IBMVFC_INIT_TIMEOUT;
@@ -6450,11 +6451,23 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 		hcall_rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
 	} while (hcall_rc == H_BUSY || H_IS_LONG_BUSY(hcall_rc));
 reg_failed:
+	scrq->cookie = 0;
 	LEAVE;
 	return rc;
 }
 
-static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
+/**
+ * ibmvfc_deregister_channel - Deregister a sub-CRQ channel with the hypervisor
+ * @vhost:	ibmvfc host struct
+ * @channels:	ibmvfc channels struct containing the sub-CRQ array
+ * @index:	index into the sub-CRQ array
+ *
+ * Frees the IRQ, disposes of the IRQ mapping, and calls H_FREE_SUB_CRQ to
+ * release the sub-CRQ with the hypervisor. On success the queue message
+ * buffer is zeroed and the current index is reset. If H_FREE_SUB_CRQ fails,
+ * an error is logged but the channel resources are cleaned up regardless.
+ */
+VISIBLE_IF_KUNIT void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 				      struct ibmvfc_channels *channels,
 				      int index)
 {
@@ -6471,20 +6484,28 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 		scrq->irq = 0;
 	}
 
-	do {
-		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address,
-					scrq->cookie);
-	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
+	if (scrq->cookie) {
+		do {
+			rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address,
+						scrq->cookie);
+		} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
 
-	if (rc)
-		dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n", index, rc);
+		if (rc)
+			dev_err(dev, "Failed to free protocol (%d) sub-crq[%d]: rc=%ld\n",
+				channels->protocol, index, rc);
+		else
+			scrq->cookie = 0;
+	}
 
 	/* Clean out the queue */
-	memset(scrq->msgs.crq, 0, PAGE_SIZE);
-	scrq->cur = 0;
+	if (scrq->msgs.handle) {
+		memset(scrq->msgs.crq, 0, PAGE_SIZE);
+		scrq->cur = 0;
+	}
 
 	LEAVE;
 }
+EXPORT_SYMBOL_IF_KUNIT(ibmvfc_deregister_channel);
 
 static void ibmvfc_reg_sub_crqs(struct ibmvfc_host *vhost,
 				struct ibmvfc_channels *channels)
@@ -7118,5 +7139,31 @@ static void __exit ibmvfc_module_exit(void)
 	fc_release_transport(ibmvfc_transport_template);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/**
+ * ibmvfc_get_first_vhost - Get the first ibmvfc host from the global list
+ *
+ * Grabs the driver spinlock and retrieves the first host adapter from the
+ * driver list. If found, increments its reference count via scsi_host_get().
+ *
+ * Return value:
+ *	struct ibmvfc_host * with reference held on success, NULL otherwise
+ **/
+VISIBLE_IF_KUNIT struct ibmvfc_host *ibmvfc_get_first_vhost(void)
+{
+	struct ibmvfc_host *vhost = NULL;
+
+	spin_lock(&ibmvfc_driver_lock);
+	if (!list_empty(&ibmvfc_head))
+		vhost = list_first_entry(&ibmvfc_head, struct ibmvfc_host, queue);
+	if (vhost)
+		if (!scsi_host_get(vhost->host))
+			vhost = NULL;
+	spin_unlock(&ibmvfc_driver_lock);
+	return vhost;
+}
+EXPORT_SYMBOL_IF_KUNIT(ibmvfc_get_first_vhost);
+#endif
+
 module_init(ibmvfc_module_init);
 module_exit(ibmvfc_module_exit);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index ca80ceffe53a..421ce8bc3ea3 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -1088,4 +1088,12 @@ static inline struct ibmvfc_host *ibmvfc_channels_to_vhost(struct ibmvfc_channel
 #define ibmvfc_remove_trace_file(kobj, attr) do { } while (0)
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+#include <kunit/visibility.h>
+VISIBLE_IF_KUNIT void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
+						struct ibmvfc_channels *channels,
+						int index);
+VISIBLE_IF_KUNIT struct ibmvfc_host *ibmvfc_get_first_vhost(void);
+#endif
+
 #endif
diff --git a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
new file mode 100644
index 000000000000..24799aa2368a
--- /dev/null
+++ b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_transport_fc.h>
+#include "ibmvfc.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/**
+ * ibmvfc_deregister_channel_guard_test - unit test for ibmvfc_deregister_channel()
+ *   guard conditions
+ * @test: pointer to kunit structure
+ *
+ * Tests that ibmvfc_deregister_channel() safely handles a queue that was
+ * never registered with the hypervisor (cookie == 0, msgs.handle == NULL):
+ * - no H_FREE_SUB_CRQ hypercall is issued
+ * - no memset is attempted on a NULL buffer
+ * - cookie and cur remain zero after the call
+ *
+ * Return: void
+ */
+static void ibmvfc_deregister_channel_guard_test(struct kunit *test)
+{
+	struct ibmvfc_channels channels = {};
+	struct ibmvfc_queue scrq = {};
+	struct ibmvfc_host *vhost;
+
+	vhost = ibmvfc_get_first_vhost();
+	if (!vhost)
+		kunit_skip(test, "No ibmvfc devices available");
+
+	/*
+	 * Embed the synthetic queue in a channels struct with one entry.
+	 * cookie == 0 and msgs.handle == NULL: ibmvfc_deregister_channel()
+	 * must skip both the H_FREE_SUB_CRQ hypercall and the memset.
+	 */
+	channels.scrqs = &scrq;
+	channels.max_queues = 1;
+
+	ibmvfc_deregister_channel(vhost, &channels, 0);
+
+	KUNIT_EXPECT_EQ(test, scrq.cookie, 0UL);
+	KUNIT_EXPECT_EQ(test, scrq.cur, 0);
+	KUNIT_EXPECT_NULL(test, scrq.msgs.handle);
+
+	scsi_host_put(vhost->host);
+}
+
+static struct kunit_case ibmvfc_channel_test_cases[] = {
+	KUNIT_CASE(ibmvfc_deregister_channel_guard_test),
+	{},
+};
+
+static struct kunit_suite ibmvfc_channel_test_suite = {
+	.name = "ibmvfc-channel-test",
+	.test_cases = ibmvfc_channel_test_cases,
+};
+kunit_test_init_section_suite(ibmvfc_channel_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dave Marquardt <davemarq@linux.ibm.com>");
+MODULE_DESCRIPTION("Test module for IBM Virtual Fibre Channel Driver");

-- 
2.56.0



