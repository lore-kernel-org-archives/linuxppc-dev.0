Return-Path: <SRS0=8MEZ=VA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CA4C5B57D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 01:22:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5C8206A3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 01:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXj35Caz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5C8206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45djyt705kzDqGZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 11:22:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jXj35Caz"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45djwR4HCFzDqQV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2019 11:20:39 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id bh12so252778plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2019 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=PQ4NMu50Y3TCTLANEIOA6X2/IvBk3A44Utjy8py8evs=;
 b=jXj35CazM3QZbbRCCsaLsfk/Wd3IJLUgBLmEgFQvzQBcgh2GsMNzt97j8wVElT7nKm
 OC5eJShKiW8ihuZQU8qUEinWGcR6vlE9s9i1V1xoH0voEFAmphXy6htvudMPcMHDIGml
 YsNMmEEGxAQpsQHenuA0eLjKefX3OB5tuUncJw/g9Ryi/R6IGGD4+rlhp62TM+IF95mb
 wK4JMRDZ8051Y4qFrDXkFQdqvZbzrQb7qxa1XJ3YhNIkWC1Ctl/HzTEaxeA4EF2moYqT
 FVMjmwYAFBSJ6QPBaKO1O8WBjgciGjoEvML9O4YQWUiT4TrUC6a/yipM4vhZdgNhYP2b
 eZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PQ4NMu50Y3TCTLANEIOA6X2/IvBk3A44Utjy8py8evs=;
 b=aTSJPn8at0hXnuL/ysqq27mLM4hZis5m2YeqgMRCtzigkQCTHNMv/glXQe3OHOML7J
 87YM4c9Uo+gtHK+I+f2Hx/od+QAmQmpGeT1xhr/xm/1z2qgWhDpSTVlR30VunP62v9RO
 Jr8PzPDua3xyR6EbdxdUIbm2TNl3jQnRBHPm3wlXBu+IXtGAr77fB31GlCMyDtKzGL0F
 O1ZvisqctdxZeK27RYfdfBzQnp9hFlXElnTkssBcbVkuzPDSNg79xMXwY8ZCci4+VBsi
 3wWJqWEmldrKgFiToAWOOWVDclcPt8PbFOAarZRqP3hT82EtvL3oTtm4jgDYyUxsWS7k
 YCMw==
X-Gm-Message-State: APjAAAWqcfuX9kuB1QKYjIOceQasFs2qmR7GZRbIwbGpW/ygs1WrlvLw
 /mqF1pm61uAklKshj87vO1Q3RtK9
X-Google-Smtp-Source: APXvYqxxCayGdd1EX7v0vzne6JjklaJqMqrDnhmtEzSn0ou/oqvDY7xq7c1vlTGWVEBb67pjYVuzAg==
X-Received: by 2002:a17:902:1129:: with SMTP id
 d38mr39113510pla.220.1562116831564; 
 Tue, 02 Jul 2019 18:20:31 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id j11sm318058pfa.2.2019.07.02.18.20.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Jul 2019 18:20:31 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] KVM: PPC: Book3S HV: Always save guest pmu for guest
 capable of nesting
Date: Wed,  3 Jul 2019 11:20:20 +1000
Message-Id: <20190703012022.15644-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: sjitindarsingh@gmail.com, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The performance monitoring unit (PMU) registers are saved on guest exit
when the guest has set the pmcregs_in_use flag in its lppaca, if it
exists, or unconditionally if it doesn't. If a nested guest is being
run then the hypervisor doesn't, and in most cases can't, know if the
pmu registers are in use since it doesn't know the location of the lppaca
for the nested guest, although it may have one for its immediate guest.
This results in the values of these registers being lost across nested
guest entry and exit in the case where the nested guest was making use
of the performance monitoring facility while it's nested guest hypervisor
wasn't.

Further more the hypervisor could interrupt a guest hypervisor between
when it has loaded up the pmu registers and it calling H_ENTER_NESTED or
between returning from the nested guest to the guest hypervisor and the
guest hypervisor reading the pmu registers, in kvmhv_p9_guest_entry().
This means that it isn't sufficient to just save the pmu registers when
entering or exiting a nested guest, but that it is necessary to always
save the pmu registers whenever a guest is capable of running nested guests
to ensure the register values aren't lost in the context switch.

Ensure the pmu register values are preserved by always saving their
value into the vcpu struct when a guest is capable of running nested
guests.

This should have minimal performance impact however any impact can be
avoided by booting a guest with "-machine pseries,cap-nested-hv=false"
on the qemu commandline.

Fixes: 95a6432ce903 "KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests"

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ec1804f822af..b682a429f3ef 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3654,6 +3654,8 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 		vcpu->arch.vpa.dirty = 1;
 		save_pmu = lp->pmcregs_in_use;
 	}
+	/* Must save pmu if this guest is capable of running nested guests */
+	save_pmu |= nesting_enabled(vcpu->kvm);
 
 	kvmhv_save_guest_pmu(vcpu, save_pmu);
 
-- 
2.13.6

