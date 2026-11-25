Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F26606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSuzsaYU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQj56nQlz2xqh;
	Thu, 26 Nov 2026 03:52:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795625577;
	cv=none; b=W+3EVMGsXvg2a/U1pZ1/AKtkaBWwt3QYs+imvKpDxLcQMXMCGm8XtSk7norqtjAu6Mjsm+G8nB8kPpZsqbOf8X7IuMytOWcIsl76j3bSXXt6EZgIhgmccy+nlOIe7qTa3F1OJAGnM9hz8IApIGN2KsDNtUqyqV+3jXAkxCh5Kt8l1JnamS5kI3TgfFp6IkrS3YgpaKrOZxdHFnugXCIEHcTVUWAwnvI0jzI12r1LxQW/pQXSiC1qN+Ej0kME/YvSSp6azKJVVJXXFsUR50W4UoRHfkzhoPYowrfkLAVV+rU/jDvwdyitPCqATyDzG008qX0pcOH6+m624L9rsv30pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795625577; c=relaxed/relaxed;
	bh=JaZ96BFP7w1Op/oWAR3qnpvuRVSOJcqekj9/BhNvATA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxA5MMbSjqjt2ITlM8k1IBFb5Jz5iDyJDjrpe5JFanObk+74a0dR/Uiuib9cLBJwekg7XgN15hOHh7M+x6gtRwWgP9h5s8D5d93vHdlDiHRtqWezyZmhCHwJ429N2ESD6cz+sOwEJ9dpJFced1JdtBPdQ8KAdVr3m1kE9nmp5K24UeiOLr3qME04pErqH5fooKaSicA9AaRz2yz2yxxQA+tEsk4knTP6cISrvHhui6LVOYiZP1rsYp5WSF5BO1lvtkiTB1skbFGgKOwQaWKLO6f2LV96whhY4JFn1CjDcLQM6OIJ7Cz17ToQO2hssQLseDHaBKr0jLNNzlpiN1D6TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSuzsaYU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSuzsaYU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQj524T8z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:52:57 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-3282db206d3so487057eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625575; x=1796230375; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JaZ96BFP7w1Op/oWAR3qnpvuRVSOJcqekj9/BhNvATA=;
        b=rSuzsaYU0ITAwlEsjtHWCOJWTu0v3eGnAsjU/acKB4Q28mQ949Oit6DLLb2Rbbs38d
         ZcLlkBQrSnu/if/XlbLYaPNBq5LZG97cHaA/b/2ZAhDh6DCBxG1oVixGaMWHWjlCoz4x
         RuhHC/MpOVKloO7mkkUrDBYRXc7G51HqyrshS1nrQo5n9rpkK8pWoRd7iteXspl+ujEV
         CW7esgZDwDTZvT6X95G7lumgxeRWuWYI+OeCEH+8jvOo8qhKdBEU4QtM/rAXiayXYsDj
         A86Lt3Hz2iirB+gOp9YkPbC24yp9zNNCp+aNR9fmVgCVpz8EDV5ErNTRGWLB9emj8TFq
         pB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625575; x=1796230375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaZ96BFP7w1Op/oWAR3qnpvuRVSOJcqekj9/BhNvATA=;
        b=YH6oaub2slQITvjQA6FEs8ue990qtep0+5Z8XTkNMX7qtZJXwrfty3wWSXAh9nDplR
         4rKSDgZ3d70wa+GosZzJyruKortY2IKec9ZaELXygaGi6gfNs+/rV2+w+g6jjAlOn55L
         K5qwqSV+WNeZiVt/zqqvrrTTbcYYTRrIPljy+I7ooQnoRDSQzoWKUmWzdIPl4FDfDAtE
         QKR1ahiFAE6vAWAe5qpwHYT53SXUjXI8CGb3AIdrognM3ZUj40OXLu5Hw5YrWci4fGVV
         DVBZat+jwfMV7PkMuQw1NkeYOo7DZC3AopXqh98jmpcZVGPd6PMdCQh+2Bmfj6w4aG+H
         Wd4Q==
X-Gm-Message-State: APuU4Z/SQ3WdcjbpUdxE6BKjmyJuHuFdDsyqOWZ6mNPsil2b48/ZZliT
	cB2Domb82wxlKbbWK1YAP8t3ImTAAl7ptTX2Nfh0OB+Kop801sr7L0b8bJ2FTg==
X-Gm-Gg: AZFdTZdcOHxOumJe/4VVN2lfdeamuX8uzYNoLN0HjrwJsMsQa8Fm3i4mvIvp6xjrf9j
	Tv+KrU51KxocGTy6LnJuH5GyXbgz+0i6ZIkipDEUpS6yFBEohKhKFmiIf+sdxp7JrPJmtYvXeYE
	vIHW0I1CeJ881MLa86VWaNgWAc8AN5XXQBkG9aRbtLhNIF2t1XOpTf+QfPcBL4DdTz5Fy+1tEdE
	vKyqbgVG5CCfLdH80z0ONN0P1Z4+/nJA6F9TOWjcEhnt1b18ZIoTRFT2T1Tpt2hE8i7RrzFiFwN
	e7romV3XknTGujLVTkAguRypRXQASaLuWo+CPoToMH5706r75E7o0hja2pPvr0/L7zvbdP2hy3W
	wLqxlJFhCbIyU6Z2ZehHic4llbGxn3CY6Lq78y2OjkUZsG9Kti8Izev2yBGq702SNwtXp2x6PoN
	okSX/HYzQzunpAYSkcsrJ1vHvSsnZv/KYtZmAD/9za8QBjDOzeZPfVdrYIimUATzToAj8U5dN3g
	B//3QE/yh81pQ4maog/22zZVF5Wq8MtBqF8TZeByVaDjnfYFS232Zbc74S6r8j8emVDbHnoJA25
	quQUyMaArc4cjEbwzdpOro5TIH6iPfLMJw==
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id 5a478bee46e88-3856ef47a98mr20213276eec.15.1795625575355;
        Wed, 25 Nov 2026 08:52:55 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98545358eec.3.2026.11.25.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:52:54 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 3/4] powerpc/ptdump: Show the exec flag of kernel mappings on e500
Date: Wed, 25 Nov 2026 22:22:32 +0530
Message-Id: <0f0c1087b2ce098cd79e2fff86f00ae1acc57bab.1795625038.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795625038.git.ritesh.list@gmail.com>
References: <cover.1795625038.git.ritesh.list@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On e500, _PAGE_EXEC is made of two bits, _PAGE_BAP_SX and _PAGE_BAP_UX,
and a kernel mapping only has _PAGE_BAP_SX (supervisor bit). The flag
table requires all the bits of the mask to be set to print "X", so
kernel_page_tables never shows a kernel mapping as executable:

w/o this patch:
  0xf1015000-0xf1015fff  0x00000000         4K PTE   r          present  coherent                  accessed

Print "X" when any of the bits is set the same way it is done for
_PAGE_READ and _PAGE_WRITE:

with this patch:
  0xf1015000-0xf1015fff  0x00000000         4K PTE   r      X   present  coherent                  accessed

This only changes what is displayed. ptdump_check_wx() uses pte_exec()
which already tests for either of the bits.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/ptdump/shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index edc69da19b85..e28a41a8b1ac 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -22,9 +22,9 @@ static const struct flag_info flag_array[] = {
 		.clear	= "w",
 	}, {
 		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
+		.val	= 0,
+		.set	= "   ",
+		.clear	= " X ",
 	}, {
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
-- 
2.39.5


