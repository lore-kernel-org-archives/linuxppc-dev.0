Return-Path: <linuxppc-dev+bounces-17869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21A9EA8540
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Mar 2026 18:58:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTTtp4SkXz3bTf;
	Mon, 09 Mar 2026 05:58:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772974889;
	cv=none; b=Ur+qk82EB4S3j5Sq85zyliWEYN9x581UOX29NClE4KZfpfqAb86Q6khGaLkhCMJpp4XU9AIpz0O2ZGLcw2Y4xjIDyxlMI8fKjrx5pMCApTGiChwfsIicqOIHa97nVQIMipatVYdEQtgIrjuqyUQSGSJeJIjwBEt99T6iEwQIsGB+z7ZclTI3WT3g+z2NIu/Dw6NyfBMd6FaDbbukMcMClxn0CiTEt6GwPkYAjlA3CXIJoKjxtuLnCrQd+BOEtOaZNfQVEgTkiHuds8hAWB0NkthivSFbjDhzwirENlPaGqLNE2VChiXaiK72bIHm3CpdNpeqfXvIjyxJGGHLTULf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772974889; c=relaxed/relaxed;
	bh=0M5fq6GQKjdtR/P2umoJCU/F3SWygqu3KnSWN1cXy5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtcLXqGmB0p1DNFnvWfTHbl9prbh9EAWHhuDZHyGQ61j1L0iHY0mHcueg4pYv0t4+CSc9VBNpAyN6Izr5vso4eaWl5BO+QqKOoo469XoXV8YLig56hwLkj2k6f2sx+9EwXHEoTDCmrVu5wjglf/+c96J1Lrzxgstdd5W9SihknugRSPlzpav7rVzrquiSql8Gn75FEYxouu2FkvR7QYDlMuafTrumsvVsxqaSQL1ExIVGMX1gVHOzV0+mzaiUiKdtD+dRxYa65QCtFAlGJy58ixNuf0C4j3FAIj0Ffur65yNtJl0e5NHWgzd0W6Sz1+RfQ+g3yUgcTF3hNuwsDXZRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=a3fAmZZj; dkim-atps=neutral; spf=pass (client-ip=195.121.94.185; helo=ewsoutbound.kpnmail.nl; envelope-from=jkoolstra@xs4all.nl; receiver=lists.ozlabs.org) smtp.mailfrom=xs4all.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=a3fAmZZj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xs4all.nl (client-ip=195.121.94.185; helo=ewsoutbound.kpnmail.nl; envelope-from=jkoolstra@xs4all.nl; receiver=lists.ozlabs.org)
X-Greylist: delayed 1233 seconds by postgrey-1.37 at boromir; Mon, 09 Mar 2026 00:01:25 AEDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTKys3sQlz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 00:01:24 +1100 (AEDT)
X-KPN-MessageId: d14c40f8-1aeb-11f1-8ff1-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d14c40f8-1aeb-11f1-8ff1-005056999439;
	Sun, 08 Mar 2026 13:39:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0M5fq6GQKjdtR/P2umoJCU/F3SWygqu3KnSWN1cXy5k=;
	b=a3fAmZZj6/wXvn5LBG5RExIBO5M93eybes70WDkSkx9letj3iOSK5jN6zcZlChREFVTRZBly66vzr
	 LuVg1zDVTq/DyTTrAhi5ix+ewHNME1TU2jNcihaOK8q76rd9SFFv/7YFs/7a9FtGc8e4v0G4HwkCPG
	 sXp0Yq5ISi0fSx8eEJdyti91oCdr10GlRE0P0DSZ0SGuIuhtIMwlOsqrvsZVikCOH+ZRYqpf2hTU50
	 gTjl2uDWLoR6/VQ/MbvHiwxsByJYP+hz7SB3Uut9LxyxFAxkzmFSKNBU+4tKouONVeN0p/b0Atc+PE
	 w1izppKltR/XXvT8xApRd9NQQyak7gw==
X-KPN-MID: 33|EtE+IxibxxNHIpCg/T5rdQHdZr55+HdEAiuXCgaF2hlkTxhc3AJ5c/H7/Jumz7S
 s1zjvMtgv7E95xKR2qVjiI+cczrjsaUHHIlsIrFWoogw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|AyMyV0D977UAwUbrLBC2OmIXSSwQ5ABOwr3hmrwWDpVO/71Xl4ThChnmwRAQqOa
 TDzWN2gGgrBP5f7S4nEH8AA==
X-Originating-IP: 178.229.45.71
Received: from daedalus.home (unknown [178.229.45.71])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ceab51e8-1aeb-11f1-8d40-00505699b758;
	Sun, 08 Mar 2026 13:39:15 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: gregkh@linuxfoundation.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Haren Myneni <haren@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: vas-api: constify dynamic struct class in coproc api register
Date: Sun,  8 Mar 2026 13:39:12 +0100
Message-ID: <20260308123917.1013607-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory.

In vas_register_coproc_api() the dynamic allocation of the struct class
corresonding to the coprocessor type (right now only nx-gzip) is
replaced by calling

	static const struct class* cop_to_class(enum vas_cop_type cop)

which links the coprocessor type to the appropriate static const struct
class.

Compile tested only.

Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 arch/powerpc/platforms/book3s/vas-api.c     | 34 ++++++++++++++++-----
 arch/powerpc/platforms/powernv/vas-window.c |  1 -
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index ea4ffa63f043..e377981fd533 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -45,7 +45,7 @@ static struct coproc_dev {
 	struct device *device;
 	char *name;
 	dev_t devt;
-	struct class *class;
+	const struct class *class;
 	enum vas_cop_type cop_type;
 	const struct vas_user_win_ops *vops;
 } coproc_device;
@@ -599,6 +599,21 @@ static struct file_operations coproc_fops = {
 	.unlocked_ioctl = coproc_ioctl,
 };
 
+static const struct class nx_gzip_class = {
+	.name		= "nx-gzip",
+	.devnode	= coproc_devnode
+};
+
+static const struct class* cop_to_class(enum vas_cop_type cop)
+{
+	switch (cop) {
+	case VAS_COP_TYPE_GZIP:		return &nx_gzip_class;
+	default:
+		pr_err("No device class defined for cop type %d\n", cop);
+		return NULL;
+	}
+}
+
 /*
  * Supporting only nx-gzip coprocessor type now, but this API code
  * extended to other coprocessor types later.
@@ -609,6 +624,10 @@ int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
 {
 	int rc = -EINVAL;
 	dev_t devno;
+	const struct class* class = cop_to_class(cop_type);
+
+	if (!class)
+		return rc;
 
 	rc = alloc_chrdev_region(&coproc_device.devt, 1, 1, name);
 	if (rc) {
@@ -619,13 +638,12 @@ int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
 	pr_devel("%s device allocated, dev [%i,%i]\n", name,
 			MAJOR(coproc_device.devt), MINOR(coproc_device.devt));
 
-	coproc_device.class = class_create(name);
-	if (IS_ERR(coproc_device.class)) {
-		rc = PTR_ERR(coproc_device.class);
-		pr_err("Unable to create %s class %d\n", name, rc);
+	rc = class_register(class);
+	if (rc) {
+		pr_err("Unable to register %s class %d\n", name, rc);
 		goto err_class;
 	}
-	coproc_device.class->devnode = coproc_devnode;
+	coproc_device.class = class;
 	coproc_device.cop_type = cop_type;
 	coproc_device.vops = vops;
 
@@ -654,7 +672,7 @@ int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
 err:
 	cdev_del(&coproc_device.cdev);
 err_cdev:
-	class_destroy(coproc_device.class);
+	class_unregister(coproc_device.class);
 err_class:
 	unregister_chrdev_region(coproc_device.devt, 1);
 	return rc;
@@ -668,6 +686,6 @@ void vas_unregister_coproc_api(void)
 	devno = MKDEV(MAJOR(coproc_device.devt), 0);
 	device_destroy(coproc_device.class, devno);
 
-	class_destroy(coproc_device.class);
+	class_unregister(coproc_device.class);
 	unregister_chrdev_region(coproc_device.devt, 1);
 }
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 9f093176b8db..34403582c895 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1459,7 +1459,6 @@ static const struct vas_user_win_ops vops =  {
 int vas_register_api_powernv(struct module *mod, enum vas_cop_type cop_type,
 			     const char *name)
 {
-
 	return vas_register_coproc_api(mod, cop_type, name, &vops);
 }
 EXPORT_SYMBOL_GPL(vas_register_api_powernv);

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0


