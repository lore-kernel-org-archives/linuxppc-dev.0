Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1822EC65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 03:56:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849FA2145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 03:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849FA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435gYN31s0zDrR7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 14:56:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435gW12ntWzDrQc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 14:54:21 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wAU3s9R3010506;
 Thu, 29 Nov 2018 21:54:10 -0600
Message-ID: <d3aa7c5adee1e3cedeb65661545c82d30faafc8f.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Look for "stdout-path" when setting up legacy
 consoles
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 30 Nov 2018 14:54:09 +1100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Rob Herring <robh@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 78e5dfea8 "powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'"
broke the default console on a number of embedded PowerPC systems, because it
failed to also update the code in arch/powerpc/kernel/legacy_serial.c to
look for that property in addition to the old one.

This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 78e5dfea8 powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
---
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 33b34a5..5b9dce1 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -372,6 +372,8 @@ void __init find_legacy_serial_ports(void)
 
 	/* Now find out if one of these is out firmware console */
 	path = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (path == NULL)
+		path = of_get_property(of_chosen, "stdout-path", NULL);
 	if (path != NULL) {
 		stdout = of_find_node_by_path(path);
 		if (stdout)
@@ -595,8 +597,10 @@ static int __init check_legacy_serial_console(void)
 	/* We are getting a weird phandle from OF ... */
 	/* ... So use the full path instead */
 	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
+		name = of_get_property(of_chosen, "stdout-path", NULL);
 	if (name == NULL) {
-		DBG(" no linux,stdout-path !\n");
+		DBG(" no stdout-path !\n");
 		return -ENODEV;
 	}
 	prom_stdout = of_find_node_by_path(name);

