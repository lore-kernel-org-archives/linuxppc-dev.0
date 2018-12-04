Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677E8C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 05:14:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D8420834
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 05:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Auji3xRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D8420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4389561PsDzDqPl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 16:14:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Auji3xRO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out4-smtp.messagingengine.com (client-ip=66.111.4.28;
 helo=out4-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Auji3xRO"; dkim-atps=neutral
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43892K53SwzDqYJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 16:11:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 93F502228A;
 Tue,  4 Dec 2018 00:11:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 04 Dec 2018 00:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o1Uo5dkYYaO7w3Rl7
 VSYdn4rPkKjghfCW1WbSxsJTEI=; b=Auji3xROaIsRIxeaJprpitxmlBqgslJ7c
 zYXzY2vtlTNUZnuM4hu9WUlaf/AvWZgkJcks/7kdnHKTT3tHMpL6Qob/utaaiGDa
 t5dO+smfh5N7fyXDRP03Kg9xnEgYfNAqwJq4xJWNijBbcEDxk+JO4Al91Bcr0Aqw
 71OplqCrjhK9fzIP4fYI3PGdJThTIuEThxtv4r/gqO7YQl2iMI0JCNIMx5JwGOpt
 DiXdlvrEZIcL3K8iKcZ78tNvlOK1BGgUgBD/o7pGuATtlvI/w298kqJj3Cf6d469
 ROPc8gUFaHnvxxydlMNhv9hiqKMS1kBq9mH/mONbX4pOvIzvs2hBA==
X-ME-Sender: <xms:hAwGXA90bMaucmUhbVykw1KZWwMe4lXzYCJpxA8lCHya0RUrxInoNA>
X-ME-Proxy: <xmx:hAwGXDE61Jsp5fAcM-2Z7K1mUW0cNLJxLv3Nrah_5t9U7qiUZfhqKQ>
 <xmx:hAwGXHWN_4skH2mHh89a3QnuJS9obZ3M5HYDDJtKi4-oEXIEY35xMg>
 <xmx:hAwGXKJmrICa28qhOBqc33D8Qp_SI51Dy8bHf5GelS0CquROsL3R8w>
 <xmx:hAwGXP9MFaC5-XOrgAGSQSDJvwrzcQA3mzT5Ef3-9YCC2YDqFO2xAA>
 <xmx:hAwGXFIYlBb3_y-2I1e9KSOGPP271aS5t9LUITImmvmfIB57LvfZCQ>
 <xmx:hQwGXJXbNtxJmHh_G-swwpkxmKdsYBdPLoE6JIQ8o_hBCXIG4ebxXg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0AEAB102A0;
 Tue,  4 Dec 2018 00:11:30 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tools/checkpatch: Ignore DT_SPLIT_BINDING_PATCH
Date: Tue,  4 Dec 2018 16:11:54 +1100
Message-Id: <20181204051154.30174-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.2
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
Cc: andrew.donnellan@au1.ibm.com, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From what I've seen, every time this warning comes up it's bogus,
so let's ignore it.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/tools/checkpatch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/tools/checkpatch.sh b/arch/powerpc/tools/checkpatch.sh
index 1fad3fb90e7c..3ce5c093b19d 100755
--- a/arch/powerpc/tools/checkpatch.sh
+++ b/arch/powerpc/tools/checkpatch.sh
@@ -19,4 +19,5 @@ exec $script_base/../../../scripts/checkpatch.pl \
 	--ignore GLOBAL_INITIALISERS \
 	--ignore LINE_SPACING \
 	--ignore MULTIPLE_ASSIGNMENTS \
+	--ignore DT_SPLIT_BINDING_PATCH \
 	$@
-- 
2.19.2

