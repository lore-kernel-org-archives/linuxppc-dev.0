Return-Path: <SRS0=FDsq=UQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66964C31E44
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 07:21:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01FB2190F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 07:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCZ1E17/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01FB2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45S2hc0llfzDqXd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 17:21:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCZ1E17/"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45S2ZX29ltzDqWc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2019 17:16:36 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id d126so5165358pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2019 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d6N1vKgjivwyrr2s1CIAV9DQUrEfszhqiY+G/Xll5XY=;
 b=mCZ1E17/udh2Cwu4TclaZuF5WnXCcSIx/SQnj18rfXkF16RJ0hMYlqGdUVXSL8hfy/
 zutivL7ZLYkw8gQfHZ5xk5yk2ULQhZ+YzS5Bqile2rxtp7Y/GmlGJF8ePQEoc7N7nW6v
 KooRlUDXgS1rHqGWNvkh+S7ci4GSA7HzO4gN7mMoj/XLTsSgJgMaQHvLMu7U/vNFxuGv
 bb7P72GayLxrtoH+OfUT8cBWZT7vMII+S3n2DeVAgNOPC8y0zxB4BDKJfHz0qjf09a1h
 DmfqJpR0Ct9PqHNYksdr5mZKWtAiS093RRSYf99VpCzy0TZs/G2osg3YujvLyhbJnh31
 J0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d6N1vKgjivwyrr2s1CIAV9DQUrEfszhqiY+G/Xll5XY=;
 b=oDqew7l/2+aGRw5LJxu/OvSXf5+HocuHYcumPxDau4qaz/jqzM5pL0I2SU/qRVK6p/
 h3jtrsBAU6yI8VjTYvbArw2UHuscv4JOP8caWKhx+/NuvBXQI7yobyrvGY/wy06WQJbY
 y5hsjdLNvEr9Xa290YjwsS48vri8SB6Ywr1JPf6jeeGEMdpU3xI6UItOg7ykUecFXHG1
 V+QkTzXoxgfd0EtaoVfO0SRudsqJ021/cdgTGeCubo1Ft8r+aszOQj0LR3UDn1TJEvXU
 tSXNAXXDLgzgaflY+HJznd9qkJvQg1yV1i74lH77JeMXgEW3Uv36Uq/HJS0ZDo9KKALR
 UpFw==
X-Gm-Message-State: APjAAAUPLfCl6EYh+Em4dLGSNs2mRXJeXkhi1nphisRBZIkZxwJuzihH
 /BVyjmWmwE/UfLcdQ8ACpr9qJSp7
X-Google-Smtp-Source: APXvYqz3/4BU/Wg1eEt44dMc4i+coQta9JxGCnqnFDI83lPJUpI3NzPzqtasxHl1CSljkr53a7oU2Q==
X-Received: by 2002:a17:90a:7107:: with SMTP id
 h7mr24294324pjk.38.1560755794236; 
 Mon, 17 Jun 2019 00:16:34 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id m31sm22163663pjb.6.2019.06.17.00.16.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Jun 2019 00:16:33 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] KVM: PPC: Book3S HV: Only write DAWR[X] when handling
 h_set_dawr in real mode
Date: Mon, 17 Jun 2019 17:16:19 +1000
Message-Id: <20190617071619.19360-3-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190617071619.19360-1-sjitindarsingh@gmail.com>
References: <20190617071619.19360-1-sjitindarsingh@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, kvm-ppc@vger.kernel.org, clg@kaod.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The hcall H_SET_DAWR is used by a guest to set the data address
watchpoint register (DAWR). This hcall is handled in the host in
kvmppc_h_set_dawr() which can be called in either real mode on the guest
exit path from hcall_try_real_mode() in book3s_hv_rmhandlers.S, or in
virtual mode when called from kvmppc_pseries_do_hcall() in book3s_hv.c.

The function kvmppc_h_set_dawr updates the dawr and dawrx fields in the
vcpu struct accordingly and then also writes the respective values into
the DAWR and DAWRX registers directly. It is necessary to write the
registers directly here when calling the function in real mode since the
path to re-enter the guest won't do this. However when in virtual mode
the host DAWR and DAWRX values have already been restored, and so writing
the registers would overwrite these. Additionally there is no reason to
write the guest values here as these will be read from the vcpu struct
and written to the registers appropriately the next time the vcpu is
run.

This also avoids the case when handling h_set_dawr for a nested guest
where the guest hypervisor isn't able to write the DAWR and DAWRX
registers directly and must rely on the real hypervisor to do this for
it when it calls H_ENTER_NESTED.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 703cd6cd994d..337e64468d78 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2510,9 +2510,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	clrrdi	r4, r4, 3
 	std	r4, VCPU_DAWR(r3)
 	std	r5, VCPU_DAWRX(r3)
+	/*
+	 * If came in through the real mode hcall handler then it is necessary
+	 * to write the registers since the return path won't. Otherwise it is
+	 * sufficient to store then in the vcpu struct as they will be loaded
+	 * next time the vcpu is run.
+	 */
+	mfmsr	r6
+	andi.	r6, r6, MSR_DR		/* in real mode? */
+	bne	4f
 	mtspr	SPRN_DAWR, r4
 	mtspr	SPRN_DAWRX, r5
-	li	r3, 0
+4:	li	r3, 0
 	blr
 
 _GLOBAL(kvmppc_h_cede)		/* r3 = vcpu pointer, r11 = msr, r13 = paca */
-- 
2.13.6

