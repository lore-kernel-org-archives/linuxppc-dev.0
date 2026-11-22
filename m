Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52521606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qobZ1tMn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjsy0MxKz2ySD;
	Mon, 23 Nov 2026 09:09:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795376607;
	cv=none; b=lWtpFmzirYUCfSVj9yV2R1K7sNofYZnKZQoSeyj/18tuRk3FlVkIHtdO2Ud1YYxghWkbXCObSgEzwtKetmDu4waQEJP6E3i7ktKLsjKZQUVrtXieGA4mILLveqWHAq+O8r5CMTgVF9Yc0Qgz4sRTvyJbCidaQzveTdeMj1SYTdRSSM89qKDrybTj/gDsb0RQD+7O/F8Rc98mR8z0n34La5RqdOPkxumSgFQlXWaePLKRKfc0+y6SzUe0jRQtkZm02sD5iEmXRVqrBi11dZAovpHLi0tLAFCleTav17dLxwDYgYyF/pQTc8nuJeHseddckTQammKeihMVZDKmExnm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795376607; c=relaxed/relaxed;
	bh=G+WV6WweTrvYpw8ZO0v54L+LwjPDZMRYJnrkI0b2uK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7qjtoO3SMrPw538WwlgyD5nvLqYHWljky73GMrJBD9pyD313bMs6J2rf1GOcwONV5uir2TvKHGQO7CHogBQK+0g58Qs3/W7AqbMncLXjXxA2My+N/GJGyNzw4CBmqkBlkDtwknayWwTNMOQrfIb7KyW43HPYQMdQyyP3KRooD+VfJEJBH4+zvX28EQAsOP3sYUv8tI1jB27SaGGHJXD8+nIU/RxqhzlQjJryeb8nJ02ya1tGfvtfDDVQ0TIXc6PsJGj5kvqS0xnPb7YYxiWpViCy/urDR5hcwJ2IkZxfz+BL/dx1DcUc91tFumnB+24P2lXPejzICLehkxSiGXDCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de; dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qobZ1tMn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org) smtp.mailfrom=lukasstockner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qobZ1tMn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukasstockner.de (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXfdC06S2z2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 06:43:26 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4b467581b98so23568605e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 11:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376603; x=1795981403; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+WV6WweTrvYpw8ZO0v54L+LwjPDZMRYJnrkI0b2uK4=;
        b=qobZ1tMn/GgnGVpru7pedb9ad5eD2Ut4PjaC36ggth5nBBWSJxf4GNRHz4ny4rcpqd
         8XMwynia8oxyv3IqVlO1YzlzEvDHqFXvpDGgaZ50AWoIB/ffrxNO+svaR+5kLipIHdnr
         TLQI4A2yTmbjjy6yEeHejpTK5Shmw0qY6vjqQ+7sBo5JiyqgZ09JEch1dKpcU+BTsqcI
         pHE9eYkcvey4ak+40BtL+Crvp3PuAGlUPzqx2OM5YRbyGUHPuI+0+H9zOwkQ8+xJWGg3
         Acr7L8uSJHWK31e7QZGebDg2rGxXUmxQ9tY6U/QmdrSkzgq79MzE29Pdt3BAOeOGuO6y
         zhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376603; x=1795981403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+WV6WweTrvYpw8ZO0v54L+LwjPDZMRYJnrkI0b2uK4=;
        b=gNH1H/Cz8FOQvIZp2UqstTqAmZuZxyELkX8A6jx0szDMgwaZ0hkK3XACJU3FL82FL1
         hwHb7yZ6PgMGp8mlLoKrWS3KwF4C+5bTqj76zq+BWCPEnnEeWfrtk2ISjb75ee3ytw3l
         Yj2Ac0U68oG0zEvjidotphkpNEvUxaGUZZYpskdwsC+tOnuMmy6ZHATxqoL5GT1GLXXC
         hSOLD7xnWmalkbHEdWO//jQ5v3ToqNpKVs1T55tXTwWV/pRUGrhkrw5ZktJZ+uzbI4AR
         yj6/OJ5u/OWstm6dgRVD80oUujxBs5RVOL8LyoOC67ey7gP3c8+iHK4YGazeHGS6+8Mg
         7ZLw==
X-Forwarded-Encrypted: i=1; AL+hErF1GNltb4M9TfxhBfNayZ/mqRv2JlFb05wo/ABxbk0W50iF8S2BF4tH6N0hdZB7nDKscSTvO02Z8PW8K2E=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8z+A/WdL6thPNBrb5LTz2NEEq10xUVKlP2XNhbGO3HVnwuVlgh
	e2SPBvz3bPzVThfq9NGY8hzFp95kVu88nKfiXpxURn9u3WTjs436Km6pUbHUtHgt3A0=
X-Gm-Gg: AZFdTZfFaSAzO2EV8rWPilgxr2Jeu1u3G0lwgFYMZcWADkICviurmZMcSW7P4zxdE2n
	MiZ12yNrkZxE5y2JCcONLlN47R4F4Z4XBaOiNDtU0U0qN7pW1jCkqjgrTcOUb+SK2mUvGYzITxx
	dpRGWsZjas9jfbQ1v/wT/lCyF3BeY2L027dElzvO8GEwM+wbQUdKzKbNO1C2kQ6r/BVPzi6pDV5
	ATBP31pn8NP0e2EhkISvppxLq/3F0CB6BxnRRe8vqL7iCMN/jjB5IlefPcUv7SzaNxSpZg+f5dr
	KWjoIge3NA8r8uAdw/MBHH+Dnvlt+N87l1zhCALcnX/Cg92XP+uVrR7i1VYAGycIRrjVinDJXzG
	wLCyckFdrzRRI/GZuDHc86WiFwmJO/VNjgi5TRGTz/WP3WtRyqz0U0v4y+PsYIGxhPfUmxKZqex
	eWOeRnkIMyPrMhAOKOBdrMVYU2DUeSB3PLiucTYC1inghEj1IDCQx8x8LegkaQfIXYI8Kkj40Pb
	QpYeNqdj3aVxyuy9dzPpv/YC3JgRIqtqTF7HhimVSBNqAyS2qaQbDMK1XIqxWSq/IZQEEJ84rqN
	F+Wwh4kmz8OdwdS4/rt2/6jMxyRL0Fryioi9MqsXfqj9JUKKnBYoQDOHz8Z+Fopw+KF+3zltUo3
	v
X-Received: by 2002:a05:600d:6507:20b0:4bb:8d13:19c0 with SMTP id 5b1f17b1804b1-4bb8d131af9mr101596545e9.26.1795376603631;
        Sun, 22 Nov 2026 11:43:23 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:23 -0800 (PST)
From: Lukas Stockner <lukas@lukasstockner.de>
To: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lukas Stockner <lukas@lukasstockner.de>
Subject: [PATCH 2/4] powerpc32/bpf: fetch fifth argument in BPF subprograms
Date: Sun, 22 Nov 2026 20:42:03 +0100
Message-ID: <20261122194205.218543-3-lukas@lukasstockner.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122194205.218543-1-lukas@lukasstockner.de>
References: <20261122194205.218543-1-lukas@lukasstockner.de>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 7dd0e2848764 ("powerpc/bpf/32: BPF prog is never called with more
than one arg") removed the BPF_REG_5 load since it's not used for program
arguments, but that is only true for regular programs - subprograms may
get up to five arguments, so the load is required there.

Fixes: 7dd0e2848764 ("powerpc/bpf/32: BPF prog is never called with more than one arg")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 261ac0646b96..9f55dd4bdfd6 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -199,6 +199,13 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		if (bpf_is_seen_register(ctx, i))
 			EMIT(PPC_RAW_STW(i, _R1, bpf_jit_stack_offsetof(ctx, i)));
 
+	/* If this is a subprogram, load fifth argument from the stack */
+	if (ctx->is_subprog && bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_5))) {
+		int offset = bpf_has_stack_frame(ctx) ? BPF_PPC_STACKFRAME(ctx) : 0;
+		EMIT(PPC_RAW_LWZ(bpf_to_ppc(BPF_REG_5) - 1, _R1, offset + 8));
+		EMIT(PPC_RAW_LWZ(bpf_to_ppc(BPF_REG_5), _R1, offset + 12));
+	}
+
 	/* Setup frame pointer to point to the bpf stack area */
 	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP))) {
 		EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_FP) - 1, 0));
-- 
2.56.0


