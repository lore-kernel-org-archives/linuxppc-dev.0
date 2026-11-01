Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAB606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmSB1HNl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdys4qzMz30FB;
	Mon, 02 Nov 2026 02:28:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546917;
	cv=none; b=Mn1QOrUmKeyl4aYxZ/3M2o7mvXdCjWYstobDzzFqJFqsXg0M7+g9W8lHvl45Hjuv5Wop8kzt6ZXSTQGBcjffbF3bHNIC5FqmScRxC8en/IFIgjGouNYMMn3ux7nzASerYmIaRpQ+VN2D0KXPEZ1UQDkG9wXOh0K7xHXd8jnYMKdpze+1FkZH+mATVME6HLTDUyBKyO7JSE/hNX8UwxqWqg6BRt7NDAGroWxcxQfQodr/VXzY+Bb7yaBorSttmypgvi/3A/iXe+EqIg7nCCjKdxAogdH1MiYX0dMTpWIjQxdBClWdqEoXNikCXdxt1/GeReOpKtqYTa+CoEKqXAuldw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546917; c=relaxed/relaxed;
	bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftlX9c2cl+LHzIPnAkr4T4ouOK0z+qRy8iozctzvNdsD0ppfnu3RqI6mVZHerge/S0qM82VkENnMM9js37OQDOchWa7/aBxT2iQrWlW5d2fC11uy4AX+Z2s76nWwnLABkg5VKFq0XV9xM/SEecyuvIDUYcAyt6AwVv7LlhqgTUZTWaFBpo6/pxIpyQulq0GpSW1RYf/YMByiJAyhk7I1nDRKBDgrFoAqdzMwUmb0QZf+VxA2QC8kglBzAweb9r8kEVH5Pv1CLkG8G+NQngWjVvbXAvpIzqulqdxygMrnokeR0Vtq8+gM0yE/OIS14S61gUj+GEplacrc2ecyPmfJ3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmSB1HNl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmSB1HNl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com [IPv6:2607:f8b0:4864:20::122e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdyr6wbVz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:36 +1100 (AEDT)
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1931ff67a29so3490766c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546915; x=1794151715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=WmSB1HNlJshsSPaycrpy50ZCnjNwKU6lWrnois8MXEWpvsaGnE3ojp/+f1XalciD5N
         d5FDYEVDo4esh1GlWRe/iEnHuU8Uj50mqSBH7LYHLjGLDIGBnMCzS1jqq+dcoCtDbIaP
         JmAjLGJzdGaS7c7bcmcY5DRWl7jUgM6W0N/pCoYFliSbofQEpgkC8d8hl9Cd3AkJwSFw
         RzS0NIofVPJf/EdkqoDYUPxGJ1hgP/wdKh0Pqf3xjDL4vTmYsyHyzxjfxiuPi9jxsqRy
         uRiN30pYT76AnUhRyoNQm13hoY2vUeImLmUj4e7HNW2ARRqJEZO5WEnj+7RStTyc1Z7l
         mUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546915; x=1794151715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=vtNrXW2btvo6Yb1DbnoJ35JrfD9p6DOxmDKdMmlEsqQytDB69MECrBQSrNWvghobYe
         5jBeVC7pF7GgRs3B3v4t/jXOo7JFFwyDh/EB1F7GH1C7xdqF0XiQwTzQmmYzV28dXf7T
         phJOWZGt6FnUbb/hl9GYMZLukKLPn8nY62JoFVv0vEGu5ryxgDxxffqXcy9m10tuzsBB
         GS/iD7zTPnD85oWRqdqRE6mRoGRgzfZGgcq6e+0LuvlhBGp1l5+sDKdHpJNGP7bMltU9
         dJy3YGJkvp+m4Hq7+XiIFXwMZgTfvCL/kcPYcOmQxvp2/8Lsac9XXueSp31WDXIXRrfZ
         SMAQ==
X-Gm-Message-State: AFq9FYLFLQAI9SImOzWLpWjm+bDZ7johMi+RHxoTTl6ZKKhFvGAJ49yT
	X3Wn3y7PFgzRmQxEzPx64QHO27CsoEyH2ofsJCRFKkdmD3df/ucgv4eQjHewQA==
X-Gm-Gg: AYBFou2PRMiPrtTvyuWFUdzC2a5NhMQxRmoRTJgZgYbaxWUxT7AUggSEbLWQCiE271F
	89/ON3y4o3sIMSBug83Aem5q/Myo6UFsuT4QlWlZPDQSBgtJaefGG7Utk/wVfGT5Al71N6pif6y
	wHczHnT7KgQB/+xKVUS7uUjII6424CdRQWmxCATOXpump2h3PtwBtd3xcn6GQzR62CbKFBeniHd
	tJuXTVsoruzEIDYlUM7DZXvEpl+GI6cOTwM4/u6YnieeUMPDZG9ZL6HNMF46GMEKjda2BBi9mry
	bk54T1gSlTFdgbH6BcUAArSFw7ycoQYnWyg77UDTy4109o9S0gi9Pd7wrYXgz1JCGIv3SeMRJTV
	8/RhkRQhZX5wo17yID3laRdUWwr4sYLJMfNRhM3+N2rxSaI9XhW4yJNstCG4uz26KherpgLXiAi
	yjCQWLVs/Dcm9cQtv91MRVHwxzirVLfgiYHj6owN0HTLLI7m+tqPLTaY9ufZc87AgeGS0zxm9uv
	xeh/cxR5QoKfFPceCJGgxVADgeIXSsVaMzJCbRI5QKFbgFG5qOAqposmIsXXidvyk1MLgJrEryW
	gEaPMBgIyPUnoLmDpI0gxGmy/+IVC9FSlg==
X-Received: by 2002:a05:7022:ea4b:b0:1a7:979f:ecc0 with SMTP id a92af1059eb24-1ac5b7e1074mr11081302c88.27.1793546914963;
        Sun, 01 Nov 2026 07:28:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:34 -0800 (PST)
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
Subject: [PATCHv3 3/7] KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:58:08 +0530
Message-Id: <9d5d92e93197ea43468312c82417b2f24159cca6.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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

kvmppc_core_check_exceptions() has the same pattern as the Book3S code:
it starts the scan of the pending exception bitmap with
__ffs(*pending) and is called from kvmppc_core_prepare_to_enter() on
every guest entry, so it routinely passes 0 to __ffs(), which is
undefined.

To be safe here, let's use find_first_bit(), which returns the bitmap
size when no bit is set.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/booke.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..9794ee6f7204 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -692,7 +692,7 @@ static void kvmppc_core_check_exceptions(struct kvm_vcpu *vcpu)
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
 	unsigned int priority;
 
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_BYTE * sizeof(*pending));
 	while (priority < BOOKE_IRQPRIO_MAX) {
 		if (kvmppc_booke_irqprio_deliver(vcpu, priority))
 			break;
-- 
2.39.5


