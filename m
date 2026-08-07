Return-Path: <linuxppc-dev+bounces-25577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E55C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:49:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkW749zXz3c3v;
	Fri, 07 Aug 2026 22:49:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786092085;
	cv=none; b=n6TD3d+0DDBLXFMG9/OIra1SAaIo+C5lr4/nGb6jUv+IncNjm4z9Xf+hgTbUxr/w2B9NolqP3a9iG7hPSONYTVxHiQMcTbNC70O3ZHYepky4BqvmYsCkvobreIVM6/05DqvVhdoGXhz49Cscr1bBX4di84Vd8KLMKxLXeIAYvwOhO6QRVisYmdAeVrvND18J2dkYYyfAKQsrlJfwbMBQywl33DGBMv+HL1y402w8fyUgL1uofGJmzHktRmHKxASF72Jvc0q056ajtWtou8G9o1V6lARpU3jXsMYiHFMOKaBYeR5QmVL1yTj9UwTn2IsFD5X5Xp6AsstsU8tvhURksg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786092085; c=relaxed/relaxed;
	bh=bIo2xLGgMhUY4A3TIq3AFuRK+7tc2N7MoWZXtLuV8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl0+EFSpu2cSNgFQtJqMyITVEf95j43wgwopAYQhoK9Xt6iBQuPLteNgpf93ymM12TPt1fZDRaRT6bojm/9FwRPfthC8QVnAUqg5nzpslEgsoBkBijvcuhVHG+0e/l6sBah6TqlTXlKMV1yuVIi+LiOSMCd/zeeXOKa8C5VULYsnpgAbyUB9CXmodGIrdcU83qjd1zpOSRDK8EG3/pnJPAt6SNZoeBHyiPQTvNEvAAkQzQ33CxDZfd3lX2QtUovFX5yscOMfYCwUCIyz/tlqUOmjW60qM8Xhn+YjiWCwG85yFjusACWoEJhBMyuRyNjUJXDZn7IS9Ps1ivvY9x7PbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VNhrioGt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VNhrioGt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGd0h6Dbqz3c01
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 18:41:24 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2caced6038eso22414765ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786092082; x=1786696882; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIo2xLGgMhUY4A3TIq3AFuRK+7tc2N7MoWZXtLuV8JY=;
        b=VNhrioGtfF3SZKRjm796ze6c4kXiO+ohahXn9VqL51053YT+Bonc0vR/DvgMyb+uBZ
         UiO1rfpfHYAEVJs+3i0bqG/GgxRU5hlc3VkliC2+6FSmKH2CQ703Pmy2qgSXIA7Qlw6i
         sUNEupVPCgWCAO+UP4wioQVGZaM5tdtxxtULwhQgPWJUipAXjkTjY9d5lULJapCSVmzd
         ADZFUcCGqgfPel3GN1G7Y1SiUI6StLRTZsurs1dedX98JB5J/Asn3YlKndiOhGmeBwW/
         3a9C36ptzS3YItMF2mKy4fmGDMt33Q8RfiRInYiRVW0JZKiqOPJqr20uLdVI/CiSd0Vz
         wEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092082; x=1786696882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIo2xLGgMhUY4A3TIq3AFuRK+7tc2N7MoWZXtLuV8JY=;
        b=TMh8XtAjSc8GWViMUXu+fEUb+Iu7rAGgmkej7VTY3+49GV800jhuhj/AW6RFlZmWGI
         UTx1s+cV0r843LSe6yTVf7TufixrXhcJKIV8zBveCSngHsf1s01cWzn5CzamuFAzvgqk
         iJAVyhgxjAjdwK0fYYtLaSx6YUBulMAAw7Bbw8vgsbhZUhLYLfdZWF6XZL+27LjdlHq9
         o8KkV2jX+EaywXNEHo43QXB9G4joWT5dweNdYEEOYoXoGegbP8/9fsyIKqOzUvuIXXch
         jbd9P1IG7OK3uoAyYqEW7BjaSZWPNSdwlD1vvzrS9MXk80EaKTX0OumY+jwNtT6fjnhU
         F+wQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrnYEdzTdqeHX4mT5qKaa8pQz+2vA1plaVXNqUh32KhBKXBM3PE6MvW8CLvNawL4sWafynpzuccF5HCAw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyV0Lu71sr6bqsXJz6AaaRjEZqWjHcOTiPvocN7Eslw9/y/Zh9d
	i3j/oVOGAWcuBAQMT2ACDBYYaSbL0w0PkTqIdDw3/r7z3kUCaWrz74G/X8vMmu5f
X-Gm-Gg: AR+sD1287q+/z6xww9XJgYm1i7hBjJMKE87ZqgORTtiVLE/RrVK263VgosWbn50/zz5
	QX43iJymPDo9urCrWpkW1OGTc4GfcuvJfCbhcXPRubpU94Bt/ciQ5XCqxHUtPbV+oe37QFAlo7U
	jfVQfqir7h17I8Lii5Dt/rwz6F2ZOAzu4wGtPr0ZaNWh0Pu/nqlhWrygX9zB1HpDAl7rfKJTkt1
	ToMczsv4DkwNnfK1cYmFJHpIn/0W+HAlfqFakSIqiPUak3QX5hovErQ+8yymMz5cywnJBioUajR
	3ozW4PEm3b8tbPCQTBJnEUZealYkn6RLwKUUUtKCWUmgKqktAlmZ+wQpNJ6Chxyd8p2uDVWCDbV
	mkur1xEnFanpLbKCvlbmOhphV8Ivcirqm+iEutX76YA7WaLYi6VxucmeTdwOl6tL0QJdMIwVPkU
	bq3NFv6WJZuJBDvJ5eWJmLvsDZpChEFvIyn917V6jjCqBMgxA5yG5sV7oIBqHzQtVULOIASKL5b
	/UruSfMdGjo5rDEPWZB9zcyEwwCVnUa
X-Received: by 2002:a17:903:38c4:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2d0f1c130bamr148775805ad.11.1786092082029;
        Fri, 07 Aug 2026 01:41:22 -0700 (PDT)
Received: from gayadav-thinkpadt14sgen1.bengluru.csb ([115.110.157.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a6809sm5006142eec.10.2026.08.07.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:41:21 -0700 (PDT)
From: Gaurav Yadav <yadavgaurav386@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaurav Yadav <yadavgaurav386@gmail.com>
Subject: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
Date: Fri,  7 Aug 2026 14:10:50 +0530
Message-ID: <20260807084050.25216-1-yadavgaurav386@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
and remove the corresponding TODO comment.

Using vcpu_err() provides vCPU-aware logging context, making it easier
to associate register dumps with specific vCPU instances in logs.

Signed-off-by: Gaurav Yadav <yadavgaurav386@gmail.com>
---
 arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f3ddb24ece74..23159eb5f5af 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -86,26 +86,25 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-/* TODO: use vcpu_printf() */
 void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 {
 	int i;
 
-	printk("pc:   %08lx msr:  %08llx\n", vcpu->arch.regs.nip,
-			vcpu->arch.shared->msr);
-	printk("lr:   %08lx ctr:  %08lx\n", vcpu->arch.regs.link,
-			vcpu->arch.regs.ctr);
-	printk("srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
-					    vcpu->arch.shared->srr1);
+	vcpu_err(vcpu, "pc:   %08lx msr:  %08llx\n", vcpu->arch.regs.nip,
+		 vcpu->arch.shared->msr);
+	vcpu_err(vcpu, "lr:   %08lx ctr:  %08lx\n", vcpu->arch.regs.link,
+		 vcpu->arch.regs.ctr);
+	vcpu_err(vcpu, "srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
+		 vcpu->arch.shared->srr1);
 
-	printk("exceptions: %08lx\n", vcpu->arch.pending_exceptions);
+	vcpu_err(vcpu, "exceptions: %08lx\n", vcpu->arch.pending_exceptions);
 
 	for (i = 0; i < 32; i += 4) {
-		printk("gpr%02d: %08lx %08lx %08lx %08lx\n", i,
-		       kvmppc_get_gpr(vcpu, i),
-		       kvmppc_get_gpr(vcpu, i+1),
-		       kvmppc_get_gpr(vcpu, i+2),
-		       kvmppc_get_gpr(vcpu, i+3));
+		vcpu_err(vcpu, "gpr%02d: %08lx %08lx %08lx %08lx\n", i,
+			 kvmppc_get_gpr(vcpu, i),
+			 kvmppc_get_gpr(vcpu, i+1),
+			 kvmppc_get_gpr(vcpu, i+2),
+			 kvmppc_get_gpr(vcpu, i+3));
 	}
 }
 
-- 
2.54.0


