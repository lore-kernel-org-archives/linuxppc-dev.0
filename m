Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C772EC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:28:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA24218D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkJq64AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA24218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pc580h0mzDq83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:28:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkJq64AJ"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTg55KDMzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:39:13 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id 188so7763444pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2yFOemuN+eolbcMH+/FkuAihsixlocXPgjBOPtuP6bo=;
 b=SkJq64AJRj6L/JcconR1RzVxUNwJaE89UyLSCrjykYgm7VHed/1sbOtWWVRdlN8niw
 +nS3i5yl0ZH25GUu9DKrpYujqNabEnuDfZdg8N5pxdkLXCbB3DShZBR1ytrKAiS+ppzy
 RoPxBTK6zcETwFyC1cXvKGmL+1VsMJi3qt6ny4MWT7jWMEIGnPNhuKnCSg7b5zfbcw/1
 SVz53xsAnmOhCU7hII/u/ATPEQ+7gKaT+0LWaDisMPg6Rl1N8fBFOIapvUfQnVL36Scw
 b/zH3Kv1YUz/k9t35DB6/mDhqL4nfvVz8XKYIgtm2DY1ACYvbFSZ5kSZYBClu0TjzObG
 1YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2yFOemuN+eolbcMH+/FkuAihsixlocXPgjBOPtuP6bo=;
 b=R2SbG6w14sgy6+JH0lZkXwZe8Upv3Xp2hc/jBGobThBKK+cpMS/Ss2Th4z7ltgI9QP
 cd8/rtnfnjLKcZIo6AoLy7Ok7+2izvvmFrKsXT+ESZts/HFzNZz9QUbaO3dkwpx3QpEG
 LWYU3NScjFvxOEAPytiNSYgd+MQBGxqK/utvFAiofDpp0tvFkukIiLBoof8FNXIYVzjT
 6OxTvJUV0blmOaNmnPoqRgnj3QhGfeXjcXeLkL0wSH2uIyclkVsbGl+fcgutj2eBf4Ut
 oRInRpPaIOAgD2AZaClWbY1OA0a/b5smlMjduoZ9EihQrSTxAtfsQZFL1s+IKC55p4Yl
 SN6w==
X-Gm-Message-State: APjAAAUSqtopn2zzs4SJZsNtdd3W5pu6c8+HFkWHjGFVNOZ9uwf59OTZ
 U6qJdDoetZZv0I/Pc/Aez6Y=
X-Google-Smtp-Source: APXvYqyt0eJT3NkmhT2J6r3iHijPGVxGT07haTkb6FEPB0c4A+sKOygu+96OyFnqj/Mw0nYRxCYdsw==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr26241568pga.37.1556037551867; 
 Tue, 23 Apr 2019 09:39:11 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.39.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:39:11 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 61/63] Documentation: x86: convert
 x86_64/fake-numa-for-cpusets to reST
Date: Wed, 24 Apr 2019 00:29:30 +0800
Message-Id: <20190423162932.21428-62-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:34 +1000
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
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 ...a-for-cpusets => fake-numa-for-cpusets.rst} | 18 +++++++++++++-----
 Documentation/x86/x86_64/index.rst             |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (90%)

diff --git a/Documentation/x86/x86_64/fake-numa-for-cpusets b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
similarity index 90%
rename from Documentation/x86/x86_64/fake-numa-for-cpusets
rename to Documentation/x86/x86_64/fake-numa-for-cpusets.rst
index 4b09f18831f8..3c23f45d38f6 100644
--- a/Documentation/x86/x86_64/fake-numa-for-cpusets
+++ b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Fake NUMA For CPUSets
+=====================
+
+:Author: David Rientjes <rientjes@cs.washington.edu>
+
 Using numa=fake and CPUSets for Resource Management
-Written by David Rientjes <rientjes@cs.washington.edu>
 
 This document describes how the numa=fake x86_64 command-line option can be used
 in conjunction with cpusets for coarse memory management.  Using this feature,
@@ -20,7 +27,7 @@ you become more familiar with using this combination for resource control,
 you'll determine a better setup to minimize the number of nodes you have to deal
 with.
 
-A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
+A machine may be split as follows with "numa=fake=4*512," as reported by dmesg::
 
 	Faking node 0 at 0000000000000000-0000000020000000 (512MB)
 	Faking node 1 at 0000000020000000-0000000040000000 (512MB)
@@ -34,7 +41,7 @@ A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
 
 Now following the instructions for mounting the cpusets filesystem from
 Documentation/cgroup-v1/cpusets.txt, you can assign fake nodes (i.e. contiguous memory
-address spaces) to individual cpusets:
+address spaces) to individual cpusets::
 
 	[root@xroads /]# mkdir exampleset
 	[root@xroads /]# mount -t cpuset none exampleset
@@ -47,7 +54,7 @@ Now this cpuset, 'ddset', will only allowed access to fake nodes 0 and 1 for
 memory allocations (1G).
 
 You can now assign tasks to these cpusets to limit the memory resources
-available to them according to the fake nodes assigned as mems:
+available to them according to the fake nodes assigned as mems::
 
 	[root@xroads /exampleset/ddset]# echo $$ > tasks
 	[root@xroads /exampleset/ddset]# dd if=/dev/zero of=tmp bs=1024 count=1G
@@ -56,7 +63,8 @@ available to them according to the fake nodes assigned as mems:
 Notice the difference between the system memory usage as reported by
 /proc/meminfo between the restricted cpuset case above and the unrestricted
 case (i.e. running the same 'dd' command without assigning it to a fake NUMA
-cpuset):
+cpuset)::
+
 				Unrestricted	Restricted
 	MemTotal:		3091900 kB	3091900 kB
 	MemFree:		  42113 kB	1513236 kB
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 7b8c82151358..e2a324cde671 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -11,3 +11,4 @@ x86_64 Support
    uefi
    mm
    5level-paging
+   fake-numa-for-cpusets
-- 
2.20.1

