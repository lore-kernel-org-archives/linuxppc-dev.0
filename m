Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBEAC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:20:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2524220664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQbW057h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2524220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Qwn6LTQzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 23:20:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQbW057h";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQbW057h"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433QLl14ZbzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 22:54:22 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id t13so6058519pgr.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 03:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=otYbq0C9LVqp27elVROsGPtmHiho10hG3fe3tncFiVU=;
 b=YQbW057hQhI3CWhag15fqrCe+ZHwqyp3tPlyGpdwEUnELurot3gHGvBXehoxyk+szZ
 wEWiV5M8c1217TXnucqHcDdgYAo2BlfOX2z5Mws8iYDtmBlSJPadOHi3Yu1ebe5RpPJ0
 nPAMjZH5NhcTxsesRAj+EbcKv6czwwq+O/zWWrjiEn9b4+kHR0PIcITgxV07zHxrZaSg
 cMviESAaNekW+9RglpZL4PKQ/zwmEV8K9bdYP+P2KaarLEmGYV2qQLt1AtQ0qGIhuVLd
 YCXV0U59ILro4D6PDxuZD3A0yWct7z0Kwetvw3uUgNeoOWekjY/olOQ0XvoA0Fr4IAsg
 +Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=otYbq0C9LVqp27elVROsGPtmHiho10hG3fe3tncFiVU=;
 b=lWRn5VYgM1JFKPsG1A1D7b2VfKnXG0muB2093O5akj4QDhJz7ZdNqre/8W1sNp8bmF
 VCPHq7HdPFc2bfGhvjxnXAPdECjVtTJr1qTNt7h+7JsUGyE632apE1/QDGd96anVtX/H
 oukeDVtnWVcG+3rtv7ZTKCjSX9E0pFidMlOLmagQB/CD0tlsK+xcr3fpcp2TtcCLVCEL
 0LHwpFYxyaua2B5DhBoEiNHbqCxlv/sFix/cGfxWVm1i77H4RxuaZoICMTLnC4TKrbet
 6QVjxzjOffe7dwX2ovE7jWQQkt3DkZlKUoxIjj3tlaxoTnCeOZQSZx3Qg6pb0cVPt+oJ
 0/DQ==
X-Gm-Message-State: AA+aEWaO49YyK2/UjuKHs04PAjXBvMmgZYawQZ++NYZdV5eO/819Y9ZM
 fQESbktQezhIhUne1NrgiSI=
X-Google-Smtp-Source: AFSGD/U/1cuopzkQe/GV0pR39ZYwFIBVcPKsCbOEENhwA5jovz2YtPqO0c1OQPizoMcM75tL/1bQ1A==
X-Received: by 2002:a63:e156:: with SMTP id h22mr24780534pgk.255.1543233260057; 
 Mon, 26 Nov 2018 03:54:20 -0800 (PST)
Received: from localhost.localdomain ([125.29.25.186])
 by smtp.gmail.com with ESMTPSA id v191sm73342pgb.77.2018.11.26.03.54.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 26 Nov 2018 03:54:19 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] of: add dtc annotations functionality to dtx_diff
Date: Mon, 26 Nov 2018 03:54:08 -0800
Message-Id: <1543233248-8500-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Julia Lawall <julia.lawall@lip6.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Add -T and --annotations command line arguments to dtx_diff.  These
arguments will be passed through to dtc.  dtc will then add source
location annotations to its output.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

This feature depends upon commit 5667e7ef9a9a ("annotations: add the
annotation functionality") in the dtc git repository.  To use the
new flags before the new version of dtc is imported to the linux
kernel, download the dtc repository, compile dtc with the make command,
then add the path of the dtc repository to the shell PATH variable.

 scripts/dtc/dtx_diff | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index 8c4fbad2055e..0d8572008729 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -21,6 +21,7 @@ Usage:
         diff DTx_1 and DTx_2
 
 
+      --annotate    synonym for -T
        -f           print full dts in diff (--unified=99999)
        -h           synonym for --help
        -help        synonym for --help
@@ -28,6 +29,7 @@ Usage:
        -s SRCTREE   linux kernel source tree is at path SRCTREE
                         (default is current directory)
        -S           linux kernel source tree is at root of current git repo
+       -T           Annotate output .dts with input source file and line (-T -T for more details)
        -u           unsorted, do not sort DTx
 
 
@@ -174,6 +176,7 @@ compile_to_dts() {
 
 # -----  start of script
 
+annotate=""
 cmd_diff=0
 diff_flags="-u"
 dtx_file_1=""
@@ -208,6 +211,14 @@ while [ $# -gt 0 ] ; do
 		shift
 		;;
 
+	-T | --annotate )
+		if [ "${annotate}"  = "" ] ; then
+			annotate="-T"
+		elif [ "${annotate}"  = "-T" ] ; then
+			annotate="-T -T"
+		fi
+		shift
+		;;
 	-u )
 		dtc_sort=""
 		shift
@@ -327,7 +338,7 @@ cpp_flags="\
 DTC="\
 	${DTC}                                     \
 	-i ${srctree}/scripts/dtc/include-prefixes \
-	-O dts -qq -f ${dtc_sort} -o -"
+	-O dts -qq -f ${dtc_sort} ${annotate} -o -"
 
 
 # -----  do the diff or decompile
-- 
Frank Rowand <frank.rowand@sony.com>

