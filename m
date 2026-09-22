Return-Path: <linuxppc-dev+bounces-27945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862ABC98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:30:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7th30HMz30Pp;
	Wed, 23 Sep 2026 04:30:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101804;
	cv=none; b=AkzIbOv4AvcWnLmCOnHvkjvSwSv+IrA3r3DKjRc2ut3OiB0rFS/ALTuHt+XUUG8G9IDUP1gAAfBWjhe12zxfTk8XjXp4kDDXtrIqkPlCZ6daa2bepu7EMmm0YNJ38uscr/LePNVaSpL1IP3KbB+MLrkECxEgIDPCwBT8qKW1VyIWSKHdi9gtmjZ8K8jWfjqzIMKQOWqkToWhqQ4autaBAUxETviLXdOOErRcWOOgVRALw2dJ6ROmtlx2y9QKBJZRV6WuHovjo+UDcDJTVhoT4kZoBpKEGVi8phszo9TkS/O/l/4Eb2S0is4OE3cE2/EWa1dW7j34JemibRt5iiWTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101804; c=relaxed/relaxed;
	bh=RuPCkW/LjqBFJWCaN7Uxk8wfBxmnjaxJZXL9hcftaP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBrhb7nFPUOl2gwVfAN5EbB9EgFI4DH8GP3TbqSOQhaAiCVCcsqfnBnFWIVJu0hWWaj+drOPGcopsKmvEpYpmEzilwZtcMVE8g0ZP/MPUmPN3IOYVEWycDMPz0cHdKAPlgj9OOily1AERBLK4pJoZ2WAMSzpS8tjDw9iaSoVk7prrydM/E+2YIT9aWKIPBGxRdH2MmlFWGIDt8wPBig+Lf4JlqJul2HEG8eIEtN8FkmOix34iG7iOsR2h5G0LXM69AvXieqV+n1L7rs72nAEuyRKe4ND0Jv4IHtAutI9SL+M0KmhuesMbJZy965qMHy66ig6p2u9fyvtEEnRPhV0Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pHyiZt4N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pHyiZt4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7tg2JYmz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:30:03 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-33bf5a1c4d9so107379eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101801; x=1790706601; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuPCkW/LjqBFJWCaN7Uxk8wfBxmnjaxJZXL9hcftaP0=;
        b=pHyiZt4N3EheOIbxdRJ8O65ojZ31Fmrwm9TyDMRqXQsf0eUmkCTUwPQxRNXZKge6RM
         /P4/v/VxpuyjMNpA/Dn6Qs6Q+HQoFO2GeWXTmYNo0OUR5NDTmebLx3evDgMih53asbsZ
         x5iG5dIM8JmOS7z5hfvLub2zc+Jdo4jlKrq/AxoWHLjp6EFMuGhZD69e75cR1UaW8ZdQ
         chJI02OWtFHle494pjHClsW3v0isCxCrW6GEwO7tAhFHIQICwN8nlKn5tRkMGjpQO6bF
         bsb4UnHQthhGylKydoFDVNOwxy2jEKds+iAqPLAOaHFT4SxhpfdaCIw2LOlvJfme36lU
         /KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101801; x=1790706601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RuPCkW/LjqBFJWCaN7Uxk8wfBxmnjaxJZXL9hcftaP0=;
        b=ViDUNDi4XIPs02EKLWaM7k1E36hrSDs0XqNLNGS4fVKOah/58xg8uYbzd8p12DHCmm
         p4wCiZGXmmZqbMSiHz/0g0C3mST6XHvOgn8DEcc5OFOcWAvabRNkE6n9Wimv+0YVqSeb
         0ihO9AylEq5KNg/fqmVsygtGA87i2ElfooUfeNaoC/26hKIjcXc0VyDXF742V1QNff1+
         I5AQ94ZUO5W7tYnZcyhfA1MwXVYKP93B1n1mxvF3HSEO/+41gHlIxYDC0geV/98Lhdo/
         HRDIMagZDf5in7XPOWA4m1t1m0/2YIg6j5eup1+x3uGJTHw8O01Xu5ip5xpfSdjIze0O
         Js/A==
X-Forwarded-Encrypted: i=1; AKwUvBwIMsu3l/ktt6V7cP6a+QerBPgbjCfy+ZXuZaiXN135MOstfi5g46UzPfNAnbH6UYdSb6Dehoc3udVDLhw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++maymDTJdK5D2w28AFkG3lAGcMMk9MBEcGrUcEhJCoXr70rvbFd
	+qwNxiDK5t/lMuTxp2blMk6YDyDHtKDCL0yeOiRAsLodfFqM2lBRwPS6
X-Gm-Gg: AYBFou1ZWNAWVWBc2373feFVYC1SAXFfZUNSSWohON8fPyDTXq9XFSnWV6B8OFiSNmk
	PH7+PHnNrGMxFtddS4WjDxOzcwtz14WehrWo9leKTKXY/IXNUfxRttY37Vx+77o2hSy4aHcNxPY
	8y6pQovialmtR8owBN+4DxYEqgSDh3t7X0rdch8tOSod5Ky+Vi+GVYivBsWU6JSirvx9L5aDfk6
	vqEZH0dNqrzuiUn9OvTe9n0U6Q8XSZS7Bt6/Uhg4ptBFKAslpj3nm6qPUEoVLOafAj4VN6ALn2U
	OI1jqqw8CAtJR+u1SwkdYuebxlRnSjW8771Q7ZnXYjyLqwHplipWZlvZNJiwk+BZmiUqQQ3UPNS
	ODmfg00kgUpEQER0JH49y5M+t9iFxRznT5fRnELZ1YzjbATjKB0nR520jF9GLbg+WWQEoz9bEr8
	/vmUQnBRs5desNfiH8ZbUdw3p6GRay3Ar6ee8rs0s2MW2mPecFRE1F3FxHPJ2I+e0VkRdDYpqwK
	LG3dmxUhEBnUwgXTJLNyQ9lflyESCWGeLnL+KCjRr3FZy1zxPvHSxkFA5T6rw==
X-Received: by 2002:a05:7300:fc01:b0:33b:f062:a654 with SMTP id 5a478bee46e88-33e9548f062mr53363eec.16.1790101801265;
        Tue, 22 Sep 2026 11:30:01 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:30:00 -0700 (PDT)
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
Subject: [PATCH v5 9/9] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
Date: Tue, 22 Sep 2026 23:58:53 +0530
Message-Id: <55452f6b9bd1dc241d0a9a0781fbda1c2850d2ce.1790101179.git.ritesh.list@gmail.com>
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

KVM selftests are built with -fno-PIE/-no-pie so the binary uses fixed
load addresses.
On powerpc64, GNU ld default links at 0x10000000 (256M) which is also
the MEM_GPA, so the identity map trips with the error:
  PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f

Put the test slots at 512M instead which is past the ELF.
e.g. failure w/o this fix:

./memslot_perf_test -s 514
Random seed: 0x423558ef
Testing map performance with 1 runs, 5 seconds each

==== Test Assertion Failure ====
  lib/powerpc/processor.c:235: !pte
  pid=371 tid=371 errno=2 - No such file or directory
     1  0x0000000010018293: virt_arch_pg_map at processor.c:235
     2  0x0000000010008b3f: virt_pg_map at kvm_util.h:1325
     3   (inlined by) virt_map at kvm_util.c:1571
     4  0x0000000010001cab: prepare_vm at memslot_perf_test.c:353
     5   (inlined by) test_execute at memslot_perf_test.c:816
     6   (inlined by) test_loop at memslot_perf_test.c:1062
     7   (inlined by) main at memslot_perf_test.c:1136
     8  0x000000001001d713: __libc_start_call_main at libc-start.o:?
     9  0x000000001001db47: __libc_start_main_impl at ??:?
  PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 844ea9b7bb41..2913a4de4cc9 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -30,7 +30,7 @@
 #define MEM_EXTRA_SIZE		SZ_64K

 #define MEM_SIZE		(SZ_512M + MEM_EXTRA_SIZE)
-#define MEM_GPA			SZ_256M
+#define MEM_GPA			SZ_512M
 #define MEM_AUX_GPA		MEM_GPA
 #define MEM_SYNC_GPA		MEM_AUX_GPA
 #define MEM_TEST_GPA		(MEM_AUX_GPA + MEM_EXTRA_SIZE)
--
2.39.5


