Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CF606A334
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JC/ynEwV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd2w4VStz3bQq;
	Mon, 02 Nov 2026 01:47:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544424;
	cv=none; b=Go1nfWj94wj4EWMbLYfgPt2wHvHzMvCQ+YYc99x6sh2jId+dtNdnfgBX0xMQfzumIzxNRxl7hqs/nrX57+fvzfuNzZp2knsOLM5m0AQ1O4H/VbMeQHG2rA7pDDaVBgC12vfPuFYsDbFyXp2kVkfYdlBaYy2eqk8l5yEAK9JzJV4jy/0os0KclPsmSpGCn92KUq6FQgRJoxuszch3/Htykfnukwr8ambxmTW01IcgcE6/d6QyayVtzX7EXMPcfAdiPaPQhSeBj9hAWsgLxpnkwEY1mE5h8dZh3sjtyQGNXDARWmBUNhIHd8RZc6Eq/m/+/obvg4isd6euveVsHRIkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544424; c=relaxed/relaxed;
	bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3PatVBf+RueHQpp1eIjpI16ABbAGLIvRAZuvnrcll2Lm6Vo0T5TMV6Jw5rBw7rCwHGm1UazvdlHMSBOUTZGd/E6O91tSa0eRDo239GRTg8Rzff2PUn/02M9KKfZz0ThmpgMenUOpJ/GQNG2pe118DF9H6x0tPGp+EWmsjFpxvu+tOkVrxowcU9WKmBPV9q/8OA+lAdiE+WFUBnxrkIU0S2N4jgcGSRAPG5ByeSaRady2C5rmwYGbwkVD4c/vUSUQDXUlIGHUrKPDTOB5lmdeikQ8wHCwbWzqepc8j8aZCkZy45lHsvNGC7nqisAKj6cfzYDNI9DU+38iSmA27bEHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JC/ynEwV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JC/ynEwV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd2v6c73z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:47:03 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3182468eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544422; x=1794149222; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=JC/ynEwVP2fVBUZKs8OrZgSGjTJ/IQCIGuPTqQTGx4KUMfvlcou11x6K59n6H52GHq
         T8cV+3kni2Y6vjF/Iis34Qzz+z4YyyyiKlfs/L6nBGUGcSnY61g1fxpVEWWayrkMpAiR
         xKOsG7uHKNXcEjOB1uoQwx+KAjcuaM1bR+VCV6JyGc9uX3VnlFUn5J0d+UswAnTo6mQT
         OIoPnv31YcogpSB+p97DGJLrS58Um2E/odUSq/l/mRIJAUv8/fnBzVH+5cdRXatiCeuT
         wKxGJ+OBeYKTFPdCmAvZBsWTio1TQpsXHBzmGriQJx3V3/smCH24Kl+ltaoM7mHebVA5
         P4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544422; x=1794149222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=luNdr1Kezfm8hwM4S1kJIkIoWhyXJVO2TKqMv0cyWUDpnuMeIAaz7qjjxxAf+vroEJ
         ///xtyBj32eShBI0w0oJAX4lI1o13elJuB/mVFh1QhnZe8CPFhGUnoBPwJ5n6FWvmhGH
         RLP51v0YZMZRvbsi8c0sOhLEnY8JKJxO+9xokc4cDItb+tT/DttiiUZRgFTZEDJaRZQ8
         hP6/r2Yk/yKntbEE+ZXNwdmeZg4vnr9cmngFeJr3A1h8x3g7qF27ympJT+J+rC7Bhk4h
         J5BZiS3+Tj6HkhV0ByhjRFdkm+wBAd+SuQ3KyBgpDDFABZjnRrxKTWXfFbLazovjMLtd
         QfsA==
X-Gm-Message-State: APuU4Z9K0vfiiOA4K329abtRcy3cB3wIkZTk8GBWkGyKTLl72kQUy0yG
	aNVZcpc3x1iVEdBhUUFA4XHvEc8VxmUUWFvwaGg898P6mFWoHFpt50srBzNjqg==
X-Gm-Gg: AYBFou3zR/dgjkaoOaL0uZm6F85ty6puwFskEVSle7F7I5M99/+zF/0vTgGYBytr/iM
	jMFPnV7+gL/52/TT5zIxB/nRheF1TCdVtQrz7OS8hkZhdHbVPZ4XU6AVqzC9IXFmYhpkVaJwp6G
	7ly6sDnNVBbusgtbVWM19uDEyUuHJsiVnMKUgMk3KijHYqdjx2QHlA9pjFrLuYQZFt3EPCSBM3c
	DGATrYzA7oHKlsA88DahKigUeH4RcUUtdljcR3yHvAb6YtteNqSH8eb0Q1vHtLN5PEWyvAW19E5
	1yGbgRIWsgb7E49s76iqoYoiidBeWw070OPgUQmKlanrXmM25gfhg/ZnEhts/1Cb+Pw4bbUJ3E0
	bZocSPRdvvUo5Z9jzkZH7qyw41UGGRrWx7A736M9Z2qER88+tbwm/sMD8yOvo5+Cj5d8Okuqu3C
	NrSvTOIS41gfC1RoA1wDFtcaBQ8U0pIQRAn1sRbFvlsllrjVcgtKY7AjY97DP6o8c+oZ4ImurIQ
	Q6jGjVL7pbpbceUroboVst+UIGhTIC6RVF04l1+WZUKwMlTK+rdfopd2xElGMpEiclWVG0kN1W/
	UHCgtJdqjw/ky9Li3/zaW4O3ReZGNNR4eBHOC/5UIEuhGTJnXACVKrI=
X-Received: by 2002:a05:693c:88cb:20b0:36a:1e50:e45 with SMTP id 5a478bee46e88-36a423624d5mr10929945eec.9.1793544421715;
        Sun, 01 Nov 2026 06:47:01 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:01 -0800 (PST)
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
Subject: [PATCHv2 3/7] KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:16:28 +0530
Message-Id: <50c8d501783acd86f7b4a25257c70505b96ff7c5.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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


