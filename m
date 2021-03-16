Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07892C433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 01:10:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C235B64F6C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 01:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C235B64F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzwFR0B65z30Dq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 12:10:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kXjID66d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kXjID66d; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzwDv3jrGz2yx9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 12:09:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DzwDn5M76z9sW5; Tue, 16 Mar 2021 12:09:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1615856985;
 bh=2y+Npkmx9WI7W8MKn1RHvKjwSoTuYSmjcsSdikVqhsY=;
 h=From:To:Cc:Subject:Date:From;
 b=kXjID66dcr9uObFBuZG56V898CQ0xwfFxl2nC3s4Gw039aGGpoiAOBWer1gJgeQ/y
 sGB+y2NUC6ayhQcmlCGf5LsSQfQ8cBGk3Qsyd9QKR8kr7ZKJ9AQRIwMT9pW+slIU5+
 tbl5ouscMgmcDIIAJBJgq+g2/Triby+P86i9/2gm03NydHgKVCIWIG5I1Xm27Id5Ti
 osGVBwlcm2S3+XrYMmIR0M/aZz6XieiWQLLAhPFZlR4cbbRcjbqVcIBhZ2QPJ6dxaA
 9FqWaBQjuBDVP5To1OzwmVWtDH53lmQ8GaXrXMp2RHiQA7Nkhtmw0qB8WuP9Avyp8O
 knPTBL1Wd4d8Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Only register vio drivers if vio bus exists
Date: Tue, 16 Mar 2021 12:09:38 +1100
Message-Id: <20210316010938.525657-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: pmenzel@molgen.mpg.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The vio bus is a fake bus, which we use on pseries LPARs (guests) to
discover devices provided by the hypervisor. There's no need or sense
in creating the vio bus on bare metal systems.

Which is why commit 4336b9337824 ("powerpc/pseries: Make vio and
ibmebus initcalls pseries specific") made the initialisation of the
vio bus only happen in LPARs.

However as a result of that commit we now see errors at boot on bare
metal systems:

  Driver 'hvc_console' was unable to register with bus_type 'vio' because the bus was not initialized.
  Driver 'tpm_ibmvtpm' was unable to register with bus_type 'vio' because the bus was not initialized.

This happens because those drivers are built-in, and are calling
vio_register_driver(). It in turn calls driver_register() with a
reference to vio_bus_type, but we haven't registered vio_bus_type with
the driver core.

Fix it by also guarding vio_register_driver() with a check to see if
we are on pseries.

Fixes: 4336b9337824 ("powerpc/pseries: Make vio and ibmebus initcalls pseries specific")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/vio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 9cb4fc839fd5..429053d0402a 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1285,6 +1285,10 @@ static int vio_bus_remove(struct device *dev)
 int __vio_register_driver(struct vio_driver *viodrv, struct module *owner,
 			  const char *mod_name)
 {
+	// vio_bus_type is only initialised for pseries
+	if (!machine_is(pseries))
+		return -ENODEV;
+
 	pr_debug("%s: driver %s registering\n", __func__, viodrv->name);
 
 	/* fill in 'struct driver' fields */
-- 
2.25.1

