Return-Path: <linuxppc-dev+bounces-27944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCAC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:30:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7tZ6BX1z30Ng;
	Wed, 23 Sep 2026 04:29:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101798;
	cv=none; b=XkELZ+lGFBiBNlnjGXzHvYFgxJ+6spyBf+7McgIiiVH3vnDj3yHW6vhEHbGNEbJAD/MdnLar0xOR467ofCVmPkEjM6HGm9iIq6YEpZiTkPYQjHT92ST61/L5+VE78M9evtnyUatWVdK6UDPGY130UE5yjI6WiHBkcytSwrIYQRwCtjfKvMkxWGva/tGHwMlhOGtnitsUlnZDD1inLfjG6YCF/mtrauOBKlOB9cgbOh0cUvlRsWZzXc68/h7KjjZM+isfDQyTJ0LmEKQ7dItP47FibJ8XqW16Ewi9lZxJUH3p7UlBqCJvCgIgwQ7buRzu5+2p5JICAheOKk+G3V7hOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101798; c=relaxed/relaxed;
	bh=U5r0+TxY1DluksgtxsosJLu55AsPexRg5kdj65bL0v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ix0r9Jh0nS6yxkLbEuMDNXyp++MxhdmJ304io3ZvBCJ66Z8rG1/LfalROhmnhi1406ZzPo1CM3LkmOb1Go6TTxJ9HVagd9u7Mbh7u8jduw1sobsHPJtZzaFsB2iw/FQx0UHWwPXOd3pAoFXUxqH0u2kx6r8wgT+lIf+OXDOgtYbwKLw0I/9rRT+dveqS3GtgwZ1zPc39I4r73a/baoWU99xT0si/Ir59wyU6a6550fQ6KQtA/qYN5JwcNbc9XQGTfSgR72iRlgv301gGS6oelTU7dTiEaqLpUuje4KFOqas3owIbBjmWPolhQKNfgAadWaz4GxzHwkKcHvJr5AEBgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVoVePB+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVoVePB+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x0f.google.com (mail-dl2-x0f.google.com [IPv6:2607:f8b0:4864:38::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7tZ0zVMz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:58 +1000 (AEST)
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-14380910258so61513c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101796; x=1790706596; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U5r0+TxY1DluksgtxsosJLu55AsPexRg5kdj65bL0v4=;
        b=AVoVePB+YrKUf0fv0R2UvRt9DbnLwJM8TeC6qlvOCVGdeMhCisFLs9SAJAUgCEib1g
         BXzPfuTnjjEMBQwoTQzWC+43pOYXhXjZ3PK8DjFBJ3C+ymLyuAsazAHZapy6Bia0IX2c
         hsEu/j/cFxFILjm9YUQSLX/j1tg6GMDn5VuRNOtM4cE+pq2GFMVZbV5nBI1l4+7w7RTZ
         BZnUlov8IVTF6HhzCIDqScHsbF3OAPrP17EKFZ+9GiqQHwD0ghcdU7kjHFSlnKvwG3M1
         BeRAkHA5RP9DVziArxTN7hHFSgj6i3NBUEWfCKl44Ds77v2oYp/EN1b+7cJRZzpZXbO9
         Sm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101796; x=1790706596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U5r0+TxY1DluksgtxsosJLu55AsPexRg5kdj65bL0v4=;
        b=Zuf6FEYntcXk6fzubimZwPVfKyar8eVykoENJd6NRkC05Im5LidOHA8zv4m9+d9yR9
         h8N7au812jcBGmKYoZBLwF/6Dx/Fd6dI565aAfdIL1EDeAw3k0VLf6Ts9N4ol6oPZ953
         XWc0BGYeFgF55+wXBq7XnlHsBbDylHqcjqaQJnAKuEiQjmbRnla6XmSFKgb8FJrTyYrh
         +K9GUqaTan119qe0AArkYnPjArNDuTJQgYZn6ZeMyoBNprJ/6uEKYPYc5rARF0cfgSO0
         oO6iWfUt7nzuuu3FBbeF3dbQEuIZWGVNuBVIlZY55nMifjA4LGQM94FeWVpJeFDRwxNv
         3HzA==
X-Forwarded-Encrypted: i=1; AKwUvBw2EYTMRkrVPX19Wpzx4YZUcxOyOXWmHf0xwT6+M5csqnLaPyj4SJjQ+PsNM3Xd8+wW/s5cJUY4DaylIZ4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kwMnj4VRBhfw24xEQinDr9oF462lBc1pSIlQSaJ51NLCMKapci
	oq8JmuOQwBucNXrbp1yutPCMFKT5/mCbz4rltNd92sNtp+KjbmK7Bu2A
X-Gm-Gg: AYBFou2IVxHsLXj2uKTTisgHA/+Y1eAamZgtUuaUMKYM4c9PRffOAugmfr8i7lF7XHR
	PVEg6nYfEZFfbrcfbISqMF25fWC4SpyNU6a0hsQq4Gch6EY11Gik06UsMoWK0qRpXzlBrTea8Nx
	XRqktb0Ft0awssUhMWWi9RIvA3dAf2jTD2+/R+hVYtL1cpMQHXKtFDNKJHf2WxVl2/4t8d+SX+0
	ZQonuSL2uAqBME/F1aQhUmKqE8jgrLyfNdatjGKPVon8OxHzV3Mj4Z8yWglvB6nw1Atq9ZfnjAt
	Zw+/VE1wDrmjTEtU+1ms/c6xYPOit3zjflA15k/iWQSQvCKLWucvwZS5AQQ98ge+7aNr9GY58ir
	QI0e+odjgG7axrb8CqOA5zD55LdAAlxJCl21zT86V2GvsEuFPw3TkfefltKVk/FuOp5p+gMaxII
	YJxqJu0TDlpUhDRL1O08ZQe11+NkMOHWW8n5GQj9jRxDYcyQswHZuZhg+zqQJiOtwt88E9N9m3/
	mgdqtH451bVh8F1MEoEaOL3Za0DjYPqesn3QKk6Y38zyRa1+pOLf9RwQzdQb3sl3BNGN2Y=
X-Received: by 2002:a05:7300:7913:b0:33e:4ad0:4bc0 with SMTP id 5a478bee46e88-33e8c53ad63mr144501eec.9.1790101796171;
        Tue, 22 Sep 2026 11:29:56 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:55 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 8/9] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
Date: Tue, 22 Sep 2026 23:58:52 +0530
Message-Id: <fd4a29b096f5ffa23198cfea469a0ea0f535bf13.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
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

Same nested TLB/access bit issue like x86. Use the is_pseries_lpar()
check to detect when running nested kvm on pseries LPAR to only warn on
idle-page check.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/access_tracking_perf_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..94bfb82f7b79 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -470,6 +470,17 @@ static int access_tracking_unreliable(void)
 		puts("Skipping idle page count sanity check, because the test is run nested");
 		return 1;
 	}
+#endif
+#ifdef __powerpc64__
+	/*
+	 * Nested KVM (pSeries LPAR) can hide accessed/idle, since KVM doesn't
+	 * explicitely flush the TLB for access bit update. L0 keeps
+	 * translations cached so the guest won't see the idle bit cleared.
+	 */
+	if (is_pseries_lpar()) {
+		puts("Skipping idle page count sanity check, because the test is run nested");
+		return 1;
+	}
 #endif
 	/*
 	 * When NUMA balancing is enabled, guest memory will be unmapped to get
-- 
2.39.5


