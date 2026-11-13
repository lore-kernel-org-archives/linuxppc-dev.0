Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9E60A2628
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWpunbBI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQhbm2dKgz2y2f;
	Fri, 13 Nov 2026 13:51:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794538292;
	cv=none; b=oDeO6mu9b0c8wmtTLgFtAb2NQiIsSRNtAsP3lHcp2Juv7427Le4fqBt+VNdAL0sqkiFWyezLf+lV0aOi0LEJcu7r1SdFqH13ScalGwi5NtsECophPhlu5yxvXVU9mB6c43FSNx1SOoM1hTeq3C0vSAf/CW67w0GfBA6VNSpzTgSHAN8CaSSPf2rdc7SO5GnYUh9HuhnsNLY9o07PUVB8twPazz7ugPKLVNXmli6U88ikzIp8auA8Qu5XCSeAlGCH09x2e3+7fMcLzJ0wOgkB8AK0zJEZlCps6k8Jeq2YMQbJN8KILi4AzTEuuZvg6y2qi59pzRdcrDdI3UFW7RiH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794538292; c=relaxed/relaxed;
	bh=BEjGpvcrNvlHhAnch5bFQ1ZwAUgnUCLZ3mkaXsk+SiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrxpLP1y1rVmlKH7pD2sABy6nWDKgCes232cGT/dnZty4bZFrKJxTNVYB1D80WP+gxkMqZQChz7iurXMBKXaenl9P7lTtB+UDZk4d9huFtDTZfn1FRpxNLNA3zwKJUyapiQswTLafuXWsD7GVizJNckZc8sAw3rPo7xFoLdOpnuUuErCEcE2sMHvl1uow4LoRvOLRX4mUbEJqKEE3B+w1Zk11G+9AQKMqSmy4UVjmry1DMqhcgTnzbqBXhRS9OY1+Bge7XKhZ9bWX4sabTuW0Wsg5C/1MGjw/8AYhvAMg0zJVMY3e1DcLXV73tRIic76snvKo1FCrH4PK+MUeSHBhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWpunbBI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWpunbBI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQhbl1h5dz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 13:51:30 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1a2761c69fbso978169c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794538287; x=1795143087; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BEjGpvcrNvlHhAnch5bFQ1ZwAUgnUCLZ3mkaXsk+SiU=;
        b=CWpunbBIFsNe3PnZvGHojPevWteqIH6Rs8K9adBuTK184QOFAAPtF+2yq+o8p8WTEh
         lK5y+ucIh1ISDhFnp3qbtqslEmrXSGwbAUGsSkHnOMuEyHroDxTxUprqXYvszgRGYgN1
         5+yN24djM9iM1PC3+W9tlauTENxtrvFI/IlOqzWer/tfFn7kExrtYDhVX1L5+NW1h3gZ
         lszEpbfTQKgNX+jmEgpKhAgDQzuHsMooAbMfLQapslhkCUV7BYGjmYgQjwzJ4VC5zyLp
         Er65+1FdIPAf8jZySiLkBLMpIiTYYXACcIu+6eOwHK8tchgeYWdEH923oIYadOCExz6C
         cJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538287; x=1795143087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEjGpvcrNvlHhAnch5bFQ1ZwAUgnUCLZ3mkaXsk+SiU=;
        b=YQJTEYEGRiO9FNK9jd21P3Zvd7XGy69INMErgEtTdSAS1Dv3xCPz0TyBHnMexZD+tZ
         wAfELTedyzAiP7UachLPiGCqkHKMu5lnyVeh4Erw1HsNP+cGCIg6oiIXdMnjM9H39vuc
         xL63F9xk0k6tvUHsWI01UIAtzAWu5z3ASf6ESzNNLdrtfj1u5WRwRgegk4JjACpIBuOz
         06Sp8vE873VqcHpWxPNCXW3faFy2AsfB5uk6R+UDfVK9o5oLUKobgE9Xc6VNnMaoFpnj
         q6/ns4qc52xbhP11yqZdo004FEVpcSwF4itThyOc5jkbDzAfCub8vxHFto3c22Ry/02I
         HXtQ==
X-Gm-Message-State: APuU4Z+mJvOqgnJL4zuSvK95YOIqnw6K0ZJGjo/PPhWSUjnuBuW82Oz1
	HJTzkYQMeOWmaBju+T49avb5WPL2oncFvpYQ5GDxPzLVjbHAOJTR8D59Zf684Q==
X-Gm-Gg: AYBFou0fz6wXjzSCDHnXKtsBEl/nC6m6tNLAd/2LZuGtP5H9rxBPuUsn3HFFnrBR6c/
	WKxMG1ZlXeblbpCeJjjhTSRIyt4wh6u7XWtiTU1M5FZE2skIYK6yub/HQmIIEyheK6lc9B+1iNI
	H+gZN7Hc344eTTNi/do0AsYgfJJJhguFl4hU5LC7oyNPNvwCqvu8l4Zto7RYOfjl4gam8ePMwrQ
	x58k0M9/cySy+x2DQhn3BOrDYPj/Y/igjx1roIp4dJKVemvSaNB3VXgdZELEbWWi05BOylA+GSE
	Q5oZl/Hs8LT+O5ZWEV2TnGNh2B0RFqN29wAhGM7Q1bAlVkuxfexHt09s6yfQB4vN1pH7pjflMZk
	7PWCgYSH8SHiK9SD7kLgyV7Iqoc9HB+gpdezRMf8oM0DdnVZbGPsJ/oE1aYUABzu8t5WtplaZwW
	RItekJoQyNcFUHwVZ+dWIr/gEvzMXq3NwsqN9txAWrbzHdu3F6OiE3lRwP1XVR+qV9YTIb3ZkQh
	QRURQYGzBCqm11rhAczyCu1cVk412u5q45EMx7k3sc5SkK2ffIXiCDYWdX3cQD5zp4qhcElCD31
	nrNSPZ3P9c0GekRp9fnObz59F7GAx8HkkQ==
X-Received: by 2002:a05:7023:a4b:20b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b50314bed1mr1240666c88.15.1794538286798;
        Thu, 12 Nov 2026 18:51:26 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm2853771c88.11.2026.11.12.18.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:51:25 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-mm@kvack.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 1/2] KVM: PPC: BOOK4S HV: Fix memslot rollback in H_SVM_INIT_START
Date: Fri, 13 Nov 2026 08:21:13 +0530
Message-Id: <7510ddb55a34e8a669eb7c2624d652264701bfba.1794537345.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If registering a memslot with the ultravisor fails,
kvmppc_h_svm_init_start() is supposed to undo the memslots it has
already registered. The loop walks them with "m", however it wrongly
passes "memslot" instead (which failed to get registered).

Fix the loop by passing "m" instead, the memslot which was registered
successfully, for rollback from the beginning.

Fixes: 2027a24a75ce ("KVM: PPC: Book3S HV: Disable page merging in H_SVM_INIT_START")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 463aef870c4e..190f64d992d8 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -497,7 +497,7 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
 		kvm_for_each_memslot(m, bkt, slots) {
 			if (m == memslot)
 				break;
-			__kvmppc_uvmem_memslot_delete(kvm, memslot);
+			__kvmppc_uvmem_memslot_delete(kvm, m);
 		}
 	}

--
2.39.5


