Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72211606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m1o/k522
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTyNv0xLKz2y2B;
	Wed, 18 Nov 2026 21:23:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794997407;
	cv=none; b=S8LaAEt2qlxNqe05eoSpZ6Nf1LrQ4q7WyvfupgZVlRKsoKfz4B+NQ1MW2LSTIx7CyoDd36BLIcmPNDSm0vrT/2PK225POwSeYN+7B8Lnh5gLvpwqDlt6PziifVLVeejYeQKePx9fOIyKce+1AutN3aXjgUwPcSNEZPbe/VhSr8JuXj+6OYHs05Jj65jm5vfre+ROAQ2HGyYZYoehOGJ8Efey6BjtuItk/ijel4b3L3GLad5r244c9XaXY+8YUL8bFO+eLCMNDULzAbejKxRpI4/gnwe/NGRz/uPkwt3wVoMVj3ja9SJyYRpKRnj7bQHyMDLiNQrZQ0aqqWShxTk23g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794997407; c=relaxed/relaxed;
	bh=r0RqCgFglr6kB4r3TuGkycOFWmb74mbV5L7vdYoijp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3tIPyJBG8JD/hXqs2EjLHYKY5Xwc390zTUm+mEoucGWIc57uPQzA61aOuD+SGFCwi1iKgTGosWW/HG+7grvo14i+TqU/hrb2R/JCjtF9djtrVFf1E8Q3XfoK9Dp6svhtiwsAOhYRfP6SNtZTILx+2ceil0vBZbeo2ypAqfpz4R0l6pvNV9SfFPPi9SZ65LSWYoL/0xlo5VLRNeyN9YNBLHrEKIg4YrnS+S2NMwbrhuK/fMgBgMRIC1b42v+yarLGP1EXhnUOtba1oxHPB61FBu58d16kFIXUT9W/sKV1moQQH/r2ttotH9EN4c3tdiAjkv4tX79o3XaO4/DLPoVHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m1o/k522; dkim-atps=neutral; spf=pass (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m1o/k522;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 144 seconds by postgrey-1.37 at boromir; Wed, 18 Nov 2026 21:23:24 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTyNr1ymrz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:23:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=r0
	RqCgFglr6kB4r3TuGkycOFWmb74mbV5L7vdYoijp8=; b=m1o/k522nqwdXg7ePx
	c34cFrgItTX0OIZdETjwuBX91YPVQA4S/LN7W99UNxnXF1FXmyN1DLVn5suFuX9f
	inL/k3qOre4pzM03jl4/cmfrUc4uQVhPb5DbIjgfTWmDbz0F8FJw/j5G/WRYl8/N
	MK/rPXSrGe5vJHB/0+KrFRGY8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn1Dbee_1quA9NIg--.33070S2;
	Wed, 18 Nov 2026 18:20:14 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	farosas@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
Date: Wed, 18 Nov 2026 18:20:12 +0800
Message-Id: <20261118102012.2252221-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1Dbee_1quA9NIg--.33070S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17tFy5AFWfWFW3uw1xKrg_yoWfZFXE9w
	40qan7uw45Jr4Uu3WkZa9IgF4UJr48JrWF93yYq3srJFZ8Zws0k397trnxZry8W39FyrZx
	uay0yr9xtr1SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtKsjDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7R4wnmr9e97cbQAA3e
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
directly, bypassing the existing error path. Jump to the existing
error path to clean up before returning the error.

Fixes: 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory if module init fails")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Change the Fixes tag.
 - Modify the patch title.
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..620097f292b8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
 	r = kvmppc_uvmem_init();
 	if (r < 0) {
 		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
-		return r;
+		goto err;
 	}
 
 #if defined(CONFIG_KVM_XICS)
-- 
2.25.1


