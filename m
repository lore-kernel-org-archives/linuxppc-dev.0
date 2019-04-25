Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D3C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 19:56:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F879205ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 19:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hbqoZuBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F879205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qnyG0Y2mzDqf9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 05:56:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sifive.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=palmer@sifive.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=sifive.com header.i=@sifive.com header.b="hbqoZuBr"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qnvl1RDMzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 05:54:39 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id p6so358489pgh.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=YlT1r5bmAsoa4DEBXIEQB9y+1vwhu/lhRDvwSPK3b8o=;
 b=hbqoZuBr5k64uC6MJ04hMIpeFXrE5NUfk1ioXPsaG0n1rXPN5sdIyqdbh7bL9C9hgY
 zFEPROTz/pAmbwzwJNXKKNTzOPrf0okgEmwCYtuJbMTjzAG5tuA4nJSLwSFHyH6jZg51
 jrERHEu7DD3v93rCss7PPjA0SuV6clusJaR19NUTrKaHX+Jyf68Bzf9GVZ6LbyFWzhk7
 o/ojJhymBa949DO6b7+m0wrscl7E/q36HdYR05cezVU1+1L+W7UJhgSIlIwPb7KC/A3S
 YvMOxa5wm4I8ftUnj/lqanfgy2O8Jim5cJ3Di6LeI5v8xcQuQLbV2q1YP8kgB3zTEp2c
 bjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=YlT1r5bmAsoa4DEBXIEQB9y+1vwhu/lhRDvwSPK3b8o=;
 b=KRd0lnPPmPaC/enRBQfic2jRDeAKQdvTeLKadljWFkisJkKHZSSq0m7YA7+9IWsAGv
 JPIFBKpUo3b3Zk6epGTUO9l7a7CDwgJwb06Snx7kHjjrFGZmiWZsehQQoh6iGcOEfHix
 3sg/TrsmcuCKyRs8Hx0jkPzWZqU6FcD9mz6Q6+aRr83qESG57a2gRlNvrEKQQV5lnLVe
 xkQhqIItT85vo9LV4na4dJxJgOUzbZkS8RFUTV3WWuLTGE1VJHy4WkBXFDtHzI9BtCeS
 ljihBFjSDNLVIrUJ5/EH7ZsBfAOTlg0zaa6J7Z6DE9B7P5S/Tz7+sCQp/0SLGauX7JU1
 b5lw==
X-Gm-Message-State: APjAAAWR/9dIn1n1IqaB7HV5zyysWFn1lt/DE4wkDfGbS/ibAyj6zoPO
 3cI1a+PXCa2Z3Df0GjqXwh6ZSQ==
X-Google-Smtp-Source: APXvYqw28Z8nn9J/DwyjzFLAUfMFodCz3acr9qmTa+YA/9G8zHUeAoKw4IKxIqqnhohQhL08QAUSIw==
X-Received: by 2002:a63:8dc8:: with SMTP id z191mr3029696pgd.9.1556222076070; 
 Thu, 25 Apr 2019 12:54:36 -0700 (PDT)
Received: from localhost ([134.134.139.92])
 by smtp.gmail.com with ESMTPSA id a80sm47000946pfj.61.2019.04.25.12.54.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Apr 2019 12:54:34 -0700 (PDT)
Subject: [PATCH] KVM: PPC: Book3S HV: smb->smp comment fixup
Date: Thu, 25 Apr 2019 12:53:39 -0700
Message-Id: <20190425195339.12609-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: paulus@ozlabs.org
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
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I made the same typo when trying to grep for uses of smp_wmb and figured
I might as well fix it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 06964350b97a..842ab9511b54 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -749,7 +749,7 @@ static bool kvmppc_doorbell_pending(struct kvm_vcpu *vcpu)
 	/*
 	 * Ensure that the read of vcore->dpdes comes after the read
 	 * of vcpu->doorbell_request.  This barrier matches the
-	 * smb_wmb() in kvmppc_guest_entry_inject().
+	 * smp_wmb() in kvmppc_guest_entry_inject().
 	 */
 	smp_rmb();
 	vc = vcpu->arch.vcore;
-- 
2.21.0

