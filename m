Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBB606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxKNpHEL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdyc4b8Cz2yZf;
	Mon, 02 Nov 2026 02:28:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546904;
	cv=none; b=T5vqo4UA8AMlvb4Pt/qjbrh9vAfyCM0OvZUISjuLomHTA3xbKaHWmcBG+i/Bm6O8R/cI8kjrL1AycMGSEpL8mGjjBnE2GxbqkRkGhdaLDRQGQN84PBd/hcFqnJa1BjLBj2ulZwnBwv6KjDCqfoHfTZG8hKwBVoKd2im4p/T7OhH9jvE4BaqmUOKA6YXE0Wf4g+iuS7auw9G6eNflyFjJY89BoxxYaxfbHEk/DCS5+9T3kKS8JmlJtwU3yo018DmSXWZtpnriNi9IOzNPbTdOXxg5Xgalg0aAVGzUHG5PjVm84PVNkHn1kMeeCzYKiisxi6PvL6vlSWLYbxhoFuEwag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546904; c=relaxed/relaxed;
	bh=BWV1IinUG0DTVwsnY8AqH4VfOLB1w3rql3cUkwGyNXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gg957vm3hO3RQSvu0cVK66vR1FBQuaj1skltOWMSvfCutT1/Uyj/U1AYh4Ku4lYYKs0/5oT1ZNoEEqUbTL+hNaYfBfJTBuQuP4pQGB4Jye1k/4lIgENGVN5b6gkap/+O2hkvEXicFiYG70ZKlczGOLvj4rW8IE87pwNir1GqMZ5Y1fWNgbuhZwlsuDt5rlQ3IELKOrk3Zv8zQFNS84yn0MMzcIZ9hu9TXEaYZuCVtMIyfUA86iWA0fsk97LhysviT7rT5i68Sp6tSeFDHxIhfvgvQIy13FRBTV6rkWjFhsSp9uec9cBAQ8jFdA7Bx/bpSC3vtyUckYq6+sfzhpFYrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxKNpHEL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxKNpHEL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdyb3yNzz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:23 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1a3c08d6928so2543658c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546901; x=1794151701; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWV1IinUG0DTVwsnY8AqH4VfOLB1w3rql3cUkwGyNXA=;
        b=fxKNpHELcOMu8abQ25kEA9dsxldUhJrG75kqFgzx/O8G9m0y9cf3sCD2Zrxj0wmyVx
         1no7eWP5DPx3i9mWjKRkazu9gnesOJIDOsfdsGifa4mx33GmPUMJdWT0zsLvBzMIUG2z
         tR6p/LKJbY769swG/svsJqm6mlc/LV3FULRSeGsUCZkjd5frqpbWz0/2xZl5ANjuFpuL
         JNKbxAfM2E6+jgZdJEX58DW7eqK6EDlpKpivGVqinnn1c82O/MmuDMJ49ZsczQtkHEWm
         et77eg2BYr3MbZv+X0jo+MyeI4yq+Z5d1gZ10PfEy3jBG/IttjdAqgofh/EzUPXjHia6
         IVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546901; x=1794151701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWV1IinUG0DTVwsnY8AqH4VfOLB1w3rql3cUkwGyNXA=;
        b=SBxQskSuUTowD0/+CLMV1vP0jkYhAD6Gjr/YiKbrN9FJxHRJuT2yaIqyhzBiVtHDft
         dtvgMlldHdccI6HcOYCGZmIQePiw0I+cAleBm8mznMuys+iZyaYnpnauqWdqf3/3CKEn
         WH2WXaP1FUF0e2N4Djpmtx0q5QdGQ4n3KSNaW3yGZ+yxH2hjOzjSe0YlchEy2C4lJ4aN
         5Ka6EHKU0hbHTjWUwZzvtgflDhnQXEhzFYuUTuhuhicGcwm8ANEgHkyBQSxuusmASKk2
         D4OWPHpGg1ZJH8OrfedIiM88j3BJ7uDPdKS/vZe+M3NIJKQmkjuwfH9im9aksIbFohbh
         u+Tw==
X-Gm-Message-State: AFq9FYLPJzTl5nyS2G/1QFP1MV/fb+sfLJYzhtWcdC73FCSByMI+1HNJ
	zcz77lNeoZ9eiYo36bPYq2onaEh6fymZi40j7GVWC7xtxsGJ3aRpDEXfBPkHew==
X-Gm-Gg: AYBFou0EPcM2OGEMKoLPSaG8BRvLK6EAFdrbWnAgeCdpV75eQTUzU1MHxGsst6LG7Ty
	fF0z5CIXsRmuRAMpfqqPDiMzVfNfEOyEckiIMiyGmAojeL8eYNocmP1Bxq4HmNH6w9ggSsm9PG/
	btgfRSfr3i9NyWz2kOU5AnHa+d3AqLoXjNMGHFkf8CC9ff8jhhs1ZWwF40NDzyVpSxmZx/UqXYm
	z9bO7I08p6u7MpJZLZrn+30lkE0EmWzPxTD1pTT97zp84wt0TVFC2h0a4ykbIWC+ILYVJ5gCCh9
	+QHB/Dr7ge9nDo3o7DqsG6f4YC2BVVFAn8rxZ7KJdUCBshk0AH7jBpXbkOihQODLBN1O3pSr1X5
	N1TVqFEXAGWiz2ahgB9ZY8U+3FRpjTv1JsGP6XUu+uNVCyJyjyyUWbuCfznRRic5pQNGj0md5qx
	HZ9PCGHPnGtRs/I2RgeWLYjmJL2sN6cFC06rzMZFscwaVREtf4unfZrxjN3xZGownwNEYbnK5Tf
	fkx58eTe7TwbGyhpWLREJY3XY31FozsYtDrWfoGyr9pDbixjgGOZgqPQONEH/HYyl8Gj8dAi2jR
	GdXiSuq9D5cL1SBXDK1RzkskcJYy3FJMBQ==
X-Received: by 2002:a05:701b:4248:20b0:191:3c:aae7 with SMTP id a92af1059eb24-1ac5c64cb0emr12048606c88.26.1793546901052;
        Sun, 01 Nov 2026 07:28:21 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:20 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 0/7] KVM: PPC: Misc fixes and nestedv2 vCPU limit fixes
Date: Sun,  1 Nov 2026 20:58:05 +0530
Message-Id: <cover.1793546707.git.ritesh.list@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2 -> v3:
=========
- Fixed logic bug in patch-2 & patch-6.
  (realized after sending + sashiko caught this as well).

RFC -> v2:
=========
- Addressed sashiko review comments
  - added patch-3 to address similar __ffs(0) problem on booke
  - fixed build issues in patch-4
  - added patch-5 to reject vcpu ids beyond the PAPR limit
- Few more patches were added. Few of them were reported by Sashiko and few
  others were caught while doing vcpu create path code walkthrough

Most of these issues were identified while adding kvm powerpc selftests
infrastructure support [1] (which is now merged upstream). Patch-1 and Patch-2
were identified while running the selftests on Qemu+TCG+powernv+BE, while
Patch-4 can also be reproduced on a real pseries LPAR with nestedv2
capabilities.

[1]: https://lore.kernel.org/linuxppc-dev/179211526968.809012.4905747914183363587.b4-ty@b4/
[RFC]: https://lore.kernel.org/linuxppc-dev/cover.1789099725.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (7):
  KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
  KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
  KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
  KVM: PPC: Book3S HV: Fix error handling during vcore create
  KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails

 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s.c             |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 15 ++++++++++-----
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 arch/powerpc/kvm/booke.c              |  2 +-
 arch/powerpc/kvm/powerpc.c            |  9 +++++++++
 6 files changed, 33 insertions(+), 9 deletions(-)

--
2.39.5


