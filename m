Return-Path: <linuxppc-dev+bounces-25869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3206FC5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:32:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM5nm4zHnz2ypW;
	Sat, 15 Aug 2026 01:32:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786720449;
	cv=none; b=CvBQVT6UU1nlUcsCfA6xOE0iSKSgwyVTFptwJYAq9vNC6CUIAaGxSOJlPWPX/lNFCblhDJSCPybmQxiSObNxgYJUYzHiwAx+tSscpJXknbmT3qg7SsiHgbeG6OYjwZ/jK8SJkEdsy7qRhcj/VZu9OIpruhrh30kSmt5wz7piPUyHRT6SLT4TUkFWQ/IrAyXsZn6ZLOqmbiwQigtYrYBKmnWEqH40fAmlWHofyLToIla/0oH1QZidWGf/1d7Vr01RelUkkuBLJObZ0UBmvzCrqsbHvX7urR5+gIrjfkQejC4KrnCy+mA1K8krbfxH9YDQv9nsiHXJaqsFXgpNjvEvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786720449; c=relaxed/relaxed;
	bh=evqg/wCVmloNStWe7p9zX457kvwkpQrapIFq3Q4j/Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+8zU4+S56tOUrpaCo3+wvQmolAO6lzeoTX9B/tGgXquWZXMcOXh8U6k+VRubviARdByT7H3o/VXBIuNPsdN+QfF5oSqhOIHVysXe+OZeF1eeb8LQRteEMSyCRBfOPkQOPoomoovrCjRmCqe3IEOoMf+x5Cqe2f43YpJvI/bKe0BjqXCwMMtqt9HqQq7fNv7mMNZlhaOwjSzwUh5Kli0YbBx086qgWLyttPzrEKwfYWYZooFhzr8PwzR3p2nW2uzLvPzmJ/kcNhCBmE08kf6zLA6VGh5g5Ty7MbA5sC+WPmllLAmWMddZtxi5GeKd5Wvy021HAX1BE72vl0zSIKkfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eppubDYr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eppubDYr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM5Nd1l9Zz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 01:14:09 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2cacf197759so17647525ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720447; x=1787325247; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evqg/wCVmloNStWe7p9zX457kvwkpQrapIFq3Q4j/Ts=;
        b=eppubDYrUaxCqJ88ybGvP+tImgcZDN/2NiwOia2WfMgXB7nvzNnT91aYv6tuvHhTxM
         sf8ZZYLF5rZRCa7TaA7awx4SV3RP3IffwLHM8EVrDQTZs7KGcLCricCv/eYG+d7gVrKH
         rV/Ry8U/Gx0ovWHts6akzoOWfxMAsttSmOFTMg5J78zQjhGHiFS38AVgr66a4qjQyiVC
         cZbei3MKiNk+L+B5U4yU5XOmqlITI+xlcpz/8k85tCDG8jFdRWWfYDEUyr7HX+ak6iKv
         0aCG+QZMwhYXesQbt+6usgtx8oYEKwpN0FFjyINgQSjVWopebaysV/SuJK8vW34n0WOV
         mGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720447; x=1787325247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evqg/wCVmloNStWe7p9zX457kvwkpQrapIFq3Q4j/Ts=;
        b=o3FoqZqgJFOhKN5ro9iexFuerIYKyjouQ83VA0ZQN/HQiRBnGCA/D+wQEBkpp9fYnu
         SLzmylcp1yWDII21PykHul7pznn88YywbiMcQ/PxT+P+76Fe7AKdOknqkuiZa7vrGKZM
         ayLmu6/6zFgys5kGiChtZ6fA7IobIFAvcGgWmtVWLZrXAflZPMR4zXLXiKzCv9WziVWa
         vXL9dnewFWwGG+5ClOiXNuNdBfVorSXkenorhpFaHUEwV+Ayue+l1R4+gvXCBGXCbMi1
         FBlr+5yRRMjZsurZ9xCTw7FLIKF29FW+IBlyFlIbzFF3TqQlXInu9bDCUK+rdL9LMGWm
         jRFQ==
X-Gm-Message-State: AOJu0YySxtxOw7q6uwfOkRr2cZtFIk8Ra/dflg5NRLYuhllG9+nwp45m
	5dnjqx83nvVNh+2Tz65385nkDTTFWANAgv/QhzqifykQX0+HYqobGpWr
X-Gm-Gg: AR+sD12USN0i5/qB+5mKGV8nBlJC668tlAk89ZccchqTZI2VnMVwSSP03AAAXNszC/f
	C6gCNCtPvTZmh6t7sCo7jfVkOK5UXoPn41MFUNzLioZ/iWcFckLf4Q3W201kSScZwqsf5wUo7oT
	WBhePMzmDiylk5wwbex/AuW1Ppcpeds78Mow/7Q7vVG7eIGp6t5J6AGkWkE9FQImcY4COV6kD1S
	MzoGRCcMVIkKnpbInVAgNhDGEP31b09+5GURXintBM1w2TOnscghw5XF+gf7l3H0yq02pfautYu
	KUpYfiJpZTIfuKbyGe1wrk7bbykbnqyz1JbsEGuswBtJORVdBiQJwWY3Grz9IGYPPFzNxTCgQg8
	AH3irWgPT+VbuV9blS+5kjaE/T/2KwktdEo1dcGVwGyQSqlVopSPteXm07HcXHNt89iXk8YL3Ib
	aZsxTEfIFQKmdIMMbiWBHm6D+cQxRfe7RHIZkoDjse7MYV5/I0TD5K4/KyTfMqDGMw
X-Received: by 2002:a17:903:98b:b0:2d3:14c6:2372 with SMTP id d9443c01a7336-2d3b080bf23mr87501645ad.1.1786720446877;
        Fri, 14 Aug 2026 08:14:06 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:06 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 23:13:40 +0800
Subject: [PATCH 2/3] powerpc/spufs: fix type confusion in cntl mmap fault
 handler
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-spufs-groupa-v1-2-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=2202;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=VFKeXyJTX5elzCK/iZOeCAqEbI268lQudBfzIl/EEBk=;
 b=AG14nyeb4IhnSCPWTjL4v8+rNjf0tPtUgxRKsImcMSuFPJsj0j8j4vy4E/bgRcAa0zpWN1tVF
 s751jK9hQFeDsWUorEwvFI2E+VYhX0W25tuCT9Ksr5+4vzAyq5HFQ9y
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

spufs_ps_fault() recovers the SPU context from the faulting file with

	struct spu_context *ctx = vmf->vma->vm_file->private_data;

This is correct for most spufs files, whose ->open stores the context in
file->private_data. The cntl file is the exception: spufs_cntl_open()
sets file->private_data = ctx but then calls simple_attr_open(), which
allocates a struct simple_attr and overwrites file->private_data with it
so that simple_attr_read()/write() work. cntl is also the only such file
that installs an mmap fault handler (spufs_cntl_mmap, on 4K-page
configs). When that mapping is faulted, spufs_ps_fault() reads back the
struct simple_attr as a struct spu_context and dereferences it
(ctx->state, ctx->spu->problem_phys), feeding a bogus value into
vmf_insert_pfn() -- a type confusion reachable by an unprivileged opener
of the 0666 cntl file.

Obtain the context from the inode instead, which always refers to the
real spu_context regardless of what ->private_data holds, matching how
coredump_next_context() and the affinity path already fetch it. This is
equivalent for every other spufs_ps_fault() caller and removes cntl's
dependence on a pointer that simple_attr_open() owns.

Fixes: e1dbff2bafa8 ("[POWERPC] spufs: add support for read/write on cntl")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index de7494748fec..8c7515140efb 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -313,7 +313,7 @@ static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
 				    unsigned long ps_offs,
 				    unsigned long ps_size)
 {
-	struct spu_context *ctx = vmf->vma->vm_file->private_data;
+	struct spu_context *ctx = SPUFS_I(file_inode(vmf->vma->vm_file))->i_ctx;
 	unsigned long area, offset = vmf->pgoff << PAGE_SHIFT;
 	int err = 0;
 	vm_fault_t ret = VM_FAULT_NOPAGE;

-- 
2.34.1


