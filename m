Return-Path: <linuxppc-dev+bounces-28317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B88C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6RN0pMkz3bkq;
	Mon, 28 Sep 2026 00:35:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519712;
	cv=none; b=PtYvVhqo5oXfRFRZClCk7PD6JvoWmaKXR/db3FNgoYGgzDs6ddl1fSZHjpT4yolS9+jG2ARCuGpDeAw3XYZh2mEvHM/vDSzlnGc8kgDK6PxXuFpuqc68wSeWOANzInEGV4oMvyZK8nZnMEyWWGdkGFhOOzL5+95sLySn0X/5e5Kg+IHM8ivhQX72jM16wSpWts+eK7+jQ8oe0/Lb2YPk0ESIxDhvx+eYQgCtWBPBAvWE5UxHajH/NdHinTcBP39VyndAMUQdPlahBKhuAjmyrtlbsehuAdvDQ+6lDgJWW2/WQmOLPy3DFT9x8vlnEDHkUbxK2iPGe7G+vLwjVbjhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519712; c=relaxed/relaxed;
	bh=n6KJjgfT31XNsrUw/0UhpUQhpjYfsgcxEL3F9C4HugU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/LE/JmbRP4gyQBzajDQG822EOH0np316MNgp8OheGCO0tMX3HGv6FuI7vdb9UATFG+maKNSwou7erUVfDmBUy0/xJyu25nkMzAvjiykjEOVm3Q52LLKp5OUVkXfa9X0qyyUpXCpDFUHHw44Npwc3azYnv0M3b7ZPslRtV9LVa3wjplKzZibh/maYDhyvzvpPNUoe6Ocwan8aKBdvW8jB3DnmgeFZmb4YF9CRuuPd+V6+6R9XSL6vWtGER4yf1Zuh1Cx7aaRS1eestTVDLlzwI8iqkkI2vvtoNQO11uaHHGOe0aCkCg6DsWmnEoacLZsyUw3c1zWLHaHGukNlONgUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dj7eD+rv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dj7eD+rv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6RM1rR8z2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:11 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-3396cec93b6so2773205eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519709; x=1791124509; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6KJjgfT31XNsrUw/0UhpUQhpjYfsgcxEL3F9C4HugU=;
        b=Dj7eD+rvgL72w1MODZSzRAqQZ+PDe4dxPv7Zt4LDGaL03hKl58kBpM2RS5F6nfTnZw
         3GsmnuhvMhOSgg+GkXInOgUN1MlTFsD+Zj9gO7CWbETBIR+EURxwBxLcnOGXR0016T0N
         t3KNX1j0VjTPsljDDI2CD6zNh/mG7FuwydTSHVGIVU4HOXSq9vrkIWEt+C7aTC9DBo1/
         a442gtXcvPgN+3rabDe+Vk8hawHs6PBKuao0ognpfS/hx5s2OGXcODDSMVLpviCuUnUL
         5zg5LPYWu8hTLNGmynMjcOrlqsvwBazR5vJN4d3UrfbOF/4OmwVH4SU7SO0fY3+WgtJv
         v2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519709; x=1791124509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6KJjgfT31XNsrUw/0UhpUQhpjYfsgcxEL3F9C4HugU=;
        b=ZnldgAuPFVXb2haG6AI5/auVOgM/S1Yje5pilVWbe/8nMZYXKL3TI5EcbC7wrWT/6s
         4RLKECabgItMp1IgOB8oc8NPkqOAtqdbjCKPv+84H/oOwg6w5E5lcGw7eVEqBp3rBtpM
         Ba0vJ/JbZLh1rkYYcc6x/lvJk64r3G6uCUqtLnkUK0k1r00iKbvs0t0LjItwADqoYipa
         DUAaW2IKkpMmudW6mD3oCsVxXrNJNssujPaNoLDDrw00Y7+sThPR1HfXwZ+etrKcGSdH
         L/lepMJk4Gw40UhZghR9UGO5oarAJY6fYPfnL7Knp3bK8PBOziTikOCM6Ah7G0LY5eXw
         INGw==
X-Gm-Message-State: AFq9FYISdS9zUyhsQGS7X1K6krzlOUbOxiMP+G6AhWge61kT2lTdMBKS
	aDm7oDqjzpNubRRrkPt7OI2PAJL6GCVkUVBtX+ftYMVzxLB8KbbXREgiAqunUQ==
X-Gm-Gg: AYBFou0bjwvPdXjuTMLuARM7drvgOJuKdEaVjOx5BZtjdEe3+ZOeShJrb0HFkYRt8dP
	9i2sHS1dU/YXdh4RQwhxXMM7F/yuA87edBfJjbCocAafnZAxfS9ka/aelaQ099/Brq23F7OVWgN
	niUsBHdIon+s9e6CHclfDNFnvdyvNFCwCSSnsmlVIbtYhyxrSiqpf54sNcIIIxLIrIXNnrZmMGL
	yBY+S8CtdJsVpmlqsMjVopziXMrEVxxpsDwD6InmoeKMhVoMJxWxOTMkLn65VSrGN8nJn5w6p/7
	yf/vU30dI1267vBjVKsglvsFcYYaw+wPS/MsPoX+cO+ssom/+R4OwXuq9IIOCxknyZwYwsx4xPx
	SStiJlkK9BF7mxRxdR7PdZhl56F6+0czc/OqRilnouk+cFH/I8Z29Rurr1LAwA96gn+lJHogCyF
	pRN0Cwo6M0sIevdFLAxPjd4yBrfjaBcOVFdWp/yEpDKsAnicbLsEGEWd81gA8KnotOTKPSWHc1L
	t159k8xPHZuerfgPyvDchXaqMZZJh2aY97JXkdO08lBL2/Vqkc10GPLYCpG
X-Received: by 2002:a05:7301:29b0:b0:343:9eb1:9940 with SMTP id 5a478bee46e88-3439eb1a517mr4241834eec.26.1790519708699;
        Sun, 27 Sep 2026 07:35:08 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:35:08 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 08/12] powerpc/pseries: Annotate the DTL debugfs read lock context
Date: Sun, 27 Sep 2026 20:03:49 +0530
Message-Id: <590f421ed3946c7908783d10de39a9127c4cebb8.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  dtl.c: error: rw_semaphore 'dtl_access_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  dtl.c: error: releasing rw_semaphore 'dtl_access_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to phy_attest_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/dtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index f293588b8c7b..18c597210103 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -177,7 +177,12 @@ static u64 dtl_current_index(struct dtl *dtl)
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
+/*
+ * On success the read lock stays held until dtl_disable(). That covers
+ * the whole time the debugfs file is open.
+ */
 static int dtl_enable(struct dtl *dtl)
+		__cond_acquires_shared(0, &dtl_access_lock)
 {
 	long int n_entries;
 	long int rc;
@@ -225,6 +230,7 @@ static int dtl_enable(struct dtl *dtl)
 }
 
 static void dtl_disable(struct dtl *dtl)
+		__releases_shared(&dtl_access_lock)
 {
 	spin_lock(&dtl->lock);
 	dtl_stop(dtl);
@@ -238,6 +244,7 @@ static void dtl_disable(struct dtl *dtl)
 /* file interface */
 
 static int dtl_file_open(struct inode *inode, struct file *filp)
+		__cond_acquires_shared(0, &dtl_access_lock)
 {
 	struct dtl *dtl = inode->i_private;
 	int rc;
@@ -251,6 +258,7 @@ static int dtl_file_open(struct inode *inode, struct file *filp)
 }
 
 static int dtl_file_release(struct inode *inode, struct file *filp)
+		__releases_shared(&dtl_access_lock)
 {
 	struct dtl *dtl = inode->i_private;
 	dtl_disable(dtl);
-- 
2.39.5


