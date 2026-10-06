Return-Path: <linuxppc-dev+bounces-28955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF70CA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZD3PzBz30Wh;
	Tue, 06 Oct 2026 21:29:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282596;
	cv=none; b=Zf54KjIzh1JktM2o0ThFrHKQ9a8EyJHyIo2kre3mKxpduYPpcK3H/3qIxHdCZtl4uF3bQSl9/jJXoiz786rXGNhO0JD+EeF9El8rf9DuWCqkQaAMxsSA8cwx7J6cud09UABGcZhH6r5NuH8syU7sI0cNZlAE7jE9tBSBDSYF08InM7dKp2WXmLFCzCNR6IJ0e5s/Vx3SJcX4h74X+TA5OIJ/lWub3sQULTAfmlpFwJfdu8Omcb8Fr5RBxhi0DcdF7wVnjpSWF4vW8eoWm3lWWRlqmlW4Vb1RV+/Gx1qUBsDt9+lRrR9OQF3dnc91bjtC9bgXE9xqlhhi8g3k8DrMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282596; c=relaxed/relaxed;
	bh=gvsvTbnvAWg2QlsgwTzrwLWl+8GGTvt/3AFTkgMeK8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hj1mi6OaAl5dorx1571aI8IufHA3Apb6i/ayG6CSLZ8UDJAQCVQ0Lp1VD0Sucs0P2xSgEj30WbI2gMCYeYm/dw8WE/n4cJKlU+fjDXGmDFGlNF0840+jpeoStyZzxLfizDWPByTiNn2SusK3Ze3CRoAJRj2t0ggbm6Vj/URsn4RMicKksAbesGO17xGINFJxxWSkFiRTIA+/QANEMeT7P/aQPi0dACxdccENrgtYlqp9ICGnG8eCPixqDKNSasEaRtjnnB7EnclSVpekAwPBl51fdSXh30/S3J5JFDLdvFWwGlQb6aIUFltfFY8uvFzUYvDynzzZPBzagU23vA4xOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRyP7f+b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRyP7f+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZC5G8lz30Wg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:29:55 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-30b6dad2382so773974eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282594; x=1791887394; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvsvTbnvAWg2QlsgwTzrwLWl+8GGTvt/3AFTkgMeK8Q=;
        b=lRyP7f+b4+sD0NbmtTtc4OSN2YfXejaRcXwGBIQw+xzi9+qocXiNashrxbchc2RBam
         v/oMZRVFTIbPsY9Z1fspN2r1UdaReOhtxQ1a5C78kgFtaFvtWTBYin3jmFmawA53H1vc
         pfleaIWPv/zeyxrX+IJcWvC2+pPoDsx2MFzIlFFg6oEQEdTVHEqWCZawUMrEOPNQRyXh
         GVKmhuDF2dYg/b2AAtc9OxXQypBh+2MQ6Gmd5XeCWpl4twqVJLAkWmiqWKhLrs5XvdmJ
         9JCRrS59islqLiM/rB52ES7hQKdxKQHWqeqs/+qNt63PB+8Cp0hcyh+G0055uCKqE8Ic
         PgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282594; x=1791887394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvsvTbnvAWg2QlsgwTzrwLWl+8GGTvt/3AFTkgMeK8Q=;
        b=LC0rU9WUHgtXl+VHMEKmc6ynsP6EGLZxNmnXtRD5v0S6PG6lNvMUIPlY2Dn9UDmSLp
         VjOcj+HYm87ul0X3suHr4+rpPN+/GKbLuoIz6gB1mkkkv9QFXg0t1IrlPoENMcuK6mrr
         ZheYrcqwyhBgYay8MF9XS+9AlmgTjDrcEDI/q/nqSzZfzLJDyktUMXL5Nj2IVJ4NM/JK
         +l159dxSFNz1qz/Fjs8b+5msOL1HTvHJhfiSzlxKoK3315hjzSItogocIxGCWrL9C7Y1
         250rijPzo/WEztzXVAcA8zn0B4mQw7MxpgXxmD/pTD4hVRKGZbkZ57JTOhssG6qnFhiG
         Sz0w==
X-Forwarded-Encrypted: i=1; AKwUvBxhdPEXRauW8chGM0/bmH7ayVdPuEvFRtUycl4w2r/MCQPnyiisdItjQD+Hc8hHU77a8S3u1GTAeXKmCW8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI5T3/5AiehDYOTkpgJf6mETB51pOAAMgpC8/LlrSWxd0EShUZh
	pztx6qzcvzdKvJypZ8GHD2pRQ7LcS15vs5pWR9C3qv1Gm4DFDe11k4xg
X-Gm-Gg: AYBFou3XUzDfMv3evPvgMEJ3kXhKt54JvTyWGB9mp9ERvrgAnzKJU8tTYy4EiL1DEBz
	B7QDJf5hQirMdz3m8MTEs0tSsuvTk5M/6iDacWLUmkOaPmPKK9AwQVW/ZKqSpBrpSl+6gLlc8IT
	RXVlg3z8fMtTrEyroe/acPMwqp81kcoeOQ/eufLENM0eRSy4pJmJ0vEneJevlTgnXGSgez5seP8
	71WIxxgRofpY08kW342o/nwhGoRwSsshlKI62Mp7Jm4QxYnZXO7Cf4IRmXPQAI/4nwXPRiDLMcU
	IS3jDUXjPgMMZuZSjCKZv2i0yiRRI2zEnk5Iwp7x6/S6FgYEo5Ps+dbTJhZIFvBopQpRgL2AJ4s
	m3rDvT+ndNXuA+YfdnWXwo+VlJd4J8T8zT0RiQawpxrZTeI1lCVFVdMEuso4GaBgyD4Edfud1Va
	oUEbfOJKIZEFW4iuFNRK2mAj6RniuiMA45L1FFx9BlIn/Zsmc+A30rGToVqcHkI5cfYP4PjVVxc
	ngCYSvdz45vB87t6slf3o778NXqTUynluvd/rZo8f+2whs+nQB6GOO8fj1n
X-Received: by 2002:a05:7300:ea10:b0:34e:caae:20f5 with SMTP id 5a478bee46e88-3514e2f1dbdmr892976eec.30.1791282593578;
        Tue, 06 Oct 2026 03:29:53 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:52 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v7 2/8] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
Date: Tue,  6 Oct 2026 15:58:36 +0530
Message-Id: <11b5712b213b7359bbf3bad32601e4373dac43bc.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
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


