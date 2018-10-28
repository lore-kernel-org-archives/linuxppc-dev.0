Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA7C6786F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 17:27:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A39720672
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 17:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A39720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jl6R16BqzF0RC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 04:27:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux-m68k.org
 (client-ip=195.130.132.45; helo=newton.telenet-ops.be;
 envelope-from=geert@linux-m68k.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
X-Greylist: delayed 522 seconds by postgrey-1.36 at bilbo;
 Mon, 29 Oct 2018 04:25:48 AEDT
Received: from newton.telenet-ops.be (newton.telenet-ops.be [195.130.132.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jl4X1tPKzDrCp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 04:25:47 +1100 (AEDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 42jktG5DhczMqlck
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Oct 2018 18:16:54 +0100 (CET)
Received: from ramsan.of.borg ([84.194.111.163])
 by michel.telenet-ops.be with bizsmtp
 id t5Gs1y0033XaVaC065GsoH; Sun, 28 Oct 2018 18:16:54 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtp (Exim 4.86_2)
 (envelope-from <geert@linux-m68k.org>)
 id 1gGogG-0002PN-1k; Sun, 28 Oct 2018 18:16:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1gGogF-00080i-VT; Sun, 28 Oct 2018 18:16:51 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] hwmon: (ibmpowernv) Remove bogus __init annotations
Date: Sun, 28 Oct 2018 18:16:51 +0100
Message-Id: <20181028171651.30751-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
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
Cc: linux-hwmon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If gcc decides not to inline make_sensor_label():

    WARNING: vmlinux.o(.text+0x4df549c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label()
    The function .create_device_attrs() references
    the function __init .make_sensor_label().
    This is often because .create_device_attrs lacks a __init
    annotation or the annotation of .make_sensor_label is wrong.

As .probe() can be called after freeing of __init memory, all __init
annotiations in the driver are bogus, and should be removed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 drivers/hwmon/ibmpowernv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 0ccca87f527191dc..293dd1c6c7b36ef2 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -181,7 +181,7 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%s\n", sdata->label);
 }
 
-static int __init get_logical_cpu(int hwcpu)
+static int get_logical_cpu(int hwcpu)
 {
 	int cpu;
 
@@ -192,9 +192,8 @@ static int __init get_logical_cpu(int hwcpu)
 	return -ENOENT;
 }
 
-static void __init make_sensor_label(struct device_node *np,
-				     struct sensor_data *sdata,
-				     const char *label)
+static void make_sensor_label(struct device_node *np,
+			      struct sensor_data *sdata, const char *label)
 {
 	u32 id;
 	size_t n;
-- 
2.17.1

