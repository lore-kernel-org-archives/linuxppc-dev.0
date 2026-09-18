Return-Path: <linuxppc-dev+bounces-27742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B4DC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 14:31:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmZnM1WpFz2y7r;
	Sat, 19 Sep 2026 00:31:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789741895;
	cv=none; b=Eq2lGHDIn0OqC5bZ+8vhNHbracs/jZrZp5c326T19efbR3ycSl7b+gR191KcYP0yQ8W/CPprcC6L2Ya+nSlPPfjBL3X2+utDxW57oCf1e977Uu7VBCVu7locDR0Fj/oP1aXu1xgABDpbt/DJjIjVra17RTMOXYJ1tn4prowNOQowGBvLI7XpFvtwKIDjiQ6Y5HkAbmPsB+xgjmd4evPIdIm+HqYF+QCX5dJk3lQSL651K+bN2Q1MnXwKVjrC/C6GTL0QEe/I//478/qQgSCQHqWXCxTKxeDlARi7ee7qQxZ5Gh44Dm5Q7Ao8DlpgSnK8id92qjj5NvhEaQqQ4pmQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789741895; c=relaxed/relaxed;
	bh=+NOxqyYZTlsnROwyuOcMXRdlQNMNgyRf9TUPDZfpO7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzeYmEXSCFVQGWxIIe7vGrtc4JQgp2Vv0BJvpH3aPW3M5081sG/s69I5gwu2RyhFcSuAGFiiHvs2Zc5rVCHqCBD/rFLLmoyjioLKR9casFR5CjOU9XPOczvrTDEs3d40nH7q5tRcBOhD/gBTvN7FHv5mFOMLteo7anQUkDK1pe4RmFo6ag8wf47sjxpYgPXJ5a/t3E4szjgJNxBkXpNwLO0w05FvhsIzwaaJivAQpWktoomzLonLhr1OZLfjsvoOCPMvOeM4/AvqDzOe5TpsrQRODuJFZMAdmXuDDdJlZQ6tRv83tf329pmFiP7DjL0208lpIBa0CzvuFZZqHadjsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpstScmw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpstScmw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmZnK5mBgz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 00:31:33 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747f05ffcso6316315ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789741891; x=1790346691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NOxqyYZTlsnROwyuOcMXRdlQNMNgyRf9TUPDZfpO7c=;
        b=kpstScmw8dUJDeaq510jKbR8Nrkfm96kuiDMUvyX0iEgFgf1jCpiLbEUU+Ns87GEJc
         7Szeb64nuvapSxJzTI3aYdZRtuaXxUCOBSLMg3Dx0eTx9J9YSUIgUPIeIFLGfakFpGFG
         OoBnVCaINC/Ky6F7oqDHpoYA5mzNcC50mvOrQSNn3u2030Dx0e4VIw0O25uJcvnTP+Hc
         Abq24TstCUtXaIliBRaGkyI4Gyp4Q6/P94KmTfOiiTrqwUzGJoCvtqsSIIaBaopS1ePn
         4rKeISsFf3Qxzwe6Ahf8xCiYDzEk6CtoEBVS9b4FwWqxZm/yGCdJSjXLjA8MaPkPYTvW
         kiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789741891; x=1790346691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NOxqyYZTlsnROwyuOcMXRdlQNMNgyRf9TUPDZfpO7c=;
        b=kXrTICKfvxUFacxIJyzN3UxXp3gVmiEOba7gSb5PXVQc4kAN8PY2RyLHGtQDMQnzEx
         xWq9bprPjOjiqkaUP2L0U+k0biUdv1WZvYVI64U0jEN7cBquYvtdjEHL5sl0fYlIaq6Y
         7OeMy7eWDEqGhC1o9AFz5E9zSA3etsy5BxM1zUklQDhRu040bu2o3BrxnQGlpDgmEFyN
         6tseACKYbw7bkT9ClvH51ghvc9oPZwOlTkZHbkJGdKdsR07hvamQeuBrv1J8aH6igBIk
         gQ1F2TB/rGvxUNOoHY6RNTW8UiN2rkjjxu80PEsTzkbWKxeIZUobY2MSR4CIC8/VU9ND
         oynQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8wacHZvcb6NtgqEQ36+2JHFAaEjkIlqtGqAfUNk7FiDVwP8t/CmFRkqwDWcKQb0FMWdqEm18oIbZLXNU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n4UnVBXie/dgcNxdSczr+IOgatVOBMs4e0mWWT7ZYvi7yEKhmu
	zQrCVsyC3cGJRFvjCQC39nF3KrDjfhyuCLFDkYLKYztUEonlzycl6Mjr
X-Gm-Gg: AYBFou3+COtBGzcF5MV4ec0HcWOxUyXMFj4bNIRvSBQEPXokmvJeFM01YCsBB18vcwG
	ptKuq8XnnRqHsd66iBdWyxso3pgwxL4QpzGhP20yU4Ss2SOklnoZIDzEiLw0uD3m9x41+bq9QbI
	AixJ3yE3tMn79q6UKTCJmhVFwyQcHQPPD8ODhGtDvMDnWCvkACTUaHxm/hJqm5NgM8zHXapjy8v
	pgAqjUN1iPMyoKhRFvlyWS3Y912Lt3HuunJ+optCt+mhAFYz1rkiNwhRPqaPhGnQgbQIfW/NraH
	VOKerojzy/EBPPxq1eMe7P+grQ1mJ1/e7AjV2yUCGZM0tiHAAgRYGpKKhq4ddUTOmj5VpTa9dhL
	bCtrJ49x0vVzw0pr50ADzLragHV0OS52TAcnwYyNpFRIIYP+GxBplgSV7r709tuR2/6VI67weNv
	nt5v5CC4cH8s2xlTTVPvP6VKVMTJDVdwRnD+XT/CyWyBeIS6GI7y5WNwzSalR4kzvGbCCHzOcqe
	xU9Ued4m5t320g=
X-Received: by 2002:a17:902:cec5:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2ddb1b79d60mr56947675ad.16.1789741890428;
        Fri, 18 Sep 2026 07:31:30 -0700 (PDT)
Received: from nixos ([171.239.145.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7527947sm9188825ad.21.2026.09.18.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:31:29 -0700 (PDT)
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Date: Fri, 18 Sep 2026 21:31:24 +0700
Message-ID: <20260918143124.9913-1-kaylovefoss@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
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

The kvmppc_gsm_refresh_info() function incorrectly checks for the
presence of the fill_info callback instead of refresh_info.

This can lead to:
- NULL pointer dereference if refresh_info is NULL but fill_info is present
- EINVAL return if refresh_info is present but fill_info is NULL

Fix this by checking the correct callback.

Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers")
Signed-off-by: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
---
v3:
- Resend to fix whitespace handling issue on v2. No code changes.

 arch/powerpc/kvm/guest-state-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
index 42843eca6727..aeb586ba4523 100644
--- a/arch/powerpc/kvm/guest-state-buffer.c
+++ b/arch/powerpc/kvm/guest-state-buffer.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
 int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
 			    struct kvmppc_gs_buff *gsb)
 {
-	if (!gsm->ops->fill_info)
+	if (!gsm->ops->refresh_info)
 		return -EINVAL;
 
 	return gsm->ops->refresh_info(gsm, gsb);
-- 
2.54.0


