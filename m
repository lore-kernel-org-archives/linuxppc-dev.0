Return-Path: <linuxppc-dev+bounces-27087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D6BC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:57:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Mt63KGz2yd7;
	Fri, 11 Sep 2026 14:57:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102634;
	cv=none; b=dV4dRBv8Zgn5wdr7F7nSqFhH7YTxfLRdtcbcKDvxxMvBJkFK69Zuve65iN2LULxWLuXmyjXEm6eEwMmOXU/BF2OmoCcNAcMwnxZxgZszabhQfgJ+A2jgd+Xow5PHDWngMYNLyfkpeP3PPn5RixofeGCChF0tdIo73anWC98g2hlblP7055amyqzGGGHBjI0lkGobenq1k14gRC3XY7Hi6LxAgaHaC15SBKpTLmdaamDit3Qsvom+Gx0G/KEO/KxHaDRi3OsA8nRLUvvrVrSlDgMIeVthoWjfBmocTjVqQluNWANJB6JEfgJZPmNjQ0PHwPBVSGxJNFTDvItFQF0oPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102634; c=relaxed/relaxed;
	bh=3vP8L0nOQBMaqyTnSGV2kxiWzOWPb5E1yklPGYnOA60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJKfeyckBgCuZFpZ2o6GYJdsbghf++8lqDJRvIUo/ovn7mCfGcDLYyK9AEMDa5B2GNj2bJKHM7p65VLseL4L3qtVW5s3N55yKr7XBJ5A6CS7mbnRGC7GOYE5Hwwue7xmhxvztzsmYYuNUG0B3CoeSaPIW7OYJQLc8QMI7Kn4xamiUVyL3SsGXsBDge2OnsTSZbzOp9Z4+aMw5x17kQzW/ec+0Fyd2SKVTfkff3kv8xzB3qq5Rt1N0Jd10hTn0ZnwpXamW/joM52PrbjtKLstX/aeTdRdWbNLd6rM0FQKC77wSPEudYeKKrV5SKGochqlZrEA+1O8ajYAqilnuMIQwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iEKcLt5L; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iEKcLt5L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Mt1H4wz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:57:14 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-869ac301739so352038b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102632; x=1789707432; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vP8L0nOQBMaqyTnSGV2kxiWzOWPb5E1yklPGYnOA60=;
        b=iEKcLt5L3TcJKLnEMjbP192Fuox/RJPCt3OZoIxiDTuE3ik+CJkwklJah/titswwL+
         0KB1JAOMhHpNsZCBECsr6KGllvU0BiUijvQgLgr1EQsOLqYvqgGzYb4aXlz1r7T1SsO9
         azyJwLX9oPIun0KYl+W6J00KYa6WZARiD6I4QEBL0UmuyRABHqu/fNnFM6IG23Lob/jF
         fm2gCeVAVWI1SLdJKsXWxcXr9JfhncXl4pJAeUhbypupmHlBR2Robyq1Ha9lrIY6Wb9l
         ykOFKEpBqw+FgwwumB2b66spf2pLKSXhCb7/0LhJUnEZTjEIEJ6zcxyUfXUAec45f4eO
         C19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102632; x=1789707432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vP8L0nOQBMaqyTnSGV2kxiWzOWPb5E1yklPGYnOA60=;
        b=K270rjgl7QhNok159z55h+/ki7q5Uvkrki3DdmjgoV+Bn8uPHF+x+A5PUAu3E8N+Hq
         WCJdRzB7kKZRHttXz2HIXyCq+nBaQioMDr2AB633lDnOtzlS2sldY2O/EtKECLNgqxgk
         aWT1ozRNOIlmkDzuV+CDV7TYWfJ/BvTZc4tI+CxAKEv/8ALgDdvjuU4eq9K4yMYEvLEV
         tr+V11q88xZ0DeigAwlrDwROiIYAM3c+zU95ozrGY0I/QQrrOth2zfLI+U0k12/9G/Xo
         Wm8EA9VSSFbx8c67cl+QKarAxycOGiSVnl+36vp/6nhEKkWqR+bUl8v6wqMYgBRppdJS
         RYgA==
X-Gm-Message-State: AFuF++nbbRQVeBPVNqp8Wp1Pi9V7tzaHo/rU4d8SDEhUsFvNFgGeXoU+
	YsEQpb/RpE1X9BBotDuUJo0mH+YI2GX+G0cpBIlzJOOBgIqP9PDzIdsvDHQ+fEqw
X-Gm-Gg: AYBFou3+/Zjz1wgctPm/6PjuaZxyH+31xHoelEhf2X2i0af83FWyE7cnB+u5LnrQuew
	lWm0PRtysZsuHmW7+scQmnQXAPAC1g8ogHn7FAU31DATD4jqOeEzEHGl3rE42e1ggJFlCxGSjSz
	0ux4xtEFW1swcplRrGf18gkl+BOiSn6UYcF39oBXbGl2MaIPrLJngbN/1+KEe2dL+3zCDwrrIgX
	JF8qUK1o3ahaYdC4rUUCyvbcxCBFUwtqgqxJ1fAnYicEDmiSuXH0SWLLdgaWe9sLXkOENnROIi+
	bws77JJMeID8XCDHrHAwdlvgAXb7Z/STYrsyzAvJqjqM0+pmOD22Nl4GkJ3WrN7NcMkdkwDauO8
	VWRtksbWS9n3INct3V8yZ1eYK3d/C0NXrz4+RHy1voXUlTHNNgEvCPPC10bqhANWbrCR/TQC9B2
	D+moARFSndzGA/jOrmalSCFIz320jxHmRsL4zoIAUBVZ/aI7cAUaZMWrFNkPcB7QBY6VGYwqhVD
	9mt5m/tA9W8R101EdZoSMqfR1dcTPXzQUnCjT5ZkWBJqhmCZm3ICPvJ/VKmpw4=
X-Received: by 2002:a05:6a21:15cf:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3daed1c1f53mr4438486637.9.1789102631764;
        Thu, 10 Sep 2026 21:57:11 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/3] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Fri, 11 Sep 2026 10:26:46 +0530
Message-Id: <3578c377329d39a4a9063c24496d2ac4c31a169d.1789099725.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
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

This problem was caught when running KVM PPC selftests on big-endian.
__ffs() doc clearly says:
  "Undefined if no bit exists, so code should check against 0 first"

This cause KVM to deliever an arbitary interrupt to the guest and was
causing guest to hang up while running these selftests.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2efbe05caed7..e4152e9a0d96 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -401,17 +401,19 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pending_exceptions)
 		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exceptions);
 #endif
-	priority = __ffs(*pending);
-	while (priority < BOOK3S_IRQPRIO_MAX) {
-		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
-		    clear_irqprio(vcpu, priority)) {
-			clear_bit(priority, &vcpu->arch.pending_exceptions);
-			break;
-		}
+	if (*pending) {
+		priority = __ffs(*pending);
+		while (priority < BOOK3S_IRQPRIO_MAX) {
+			if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
+			    clear_irqprio(vcpu, priority)) {
+				clear_bit(priority, &vcpu->arch.pending_exceptions);
+				break;
+			}

-		priority = find_next_bit(pending,
-					 BITS_PER_BYTE * sizeof(*pending),
-					 priority + 1);
+			priority = find_next_bit(pending,
+						 BITS_PER_BYTE * sizeof(*pending),
+						 priority + 1);
+		}
 	}

 	/* Tell the guest about our interrupt status */
--
2.39.5


