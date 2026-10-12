Return-Path: <linuxppc-dev+bounces-29304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D20CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:48:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RM65vF5z3btl;
	Tue, 13 Oct 2026 05:48:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830930;
	cv=none; b=km4CL/JtBcgSVpDucATDyjWkoxhkFJwQk+NSZqejjuT6spq3UTAF7oMECBuT3YmFEp6vDyo9YZdLbQ5SKC1rBH6e8FGYkN5tpf1xHoRTxevdkC00fq3r1Ty0+S2qIOK2CqdVDW4QIP6gFLI9V8C2bfyvE1+icUHl+qAxqfEAI4ewZut2d/kTGF8WfIIdfk0Dk/GHYeUxRphY9GHGPNa8WkZk7BdDS5iOppwhsyioTXaGV/+g8NF47ZLbzigYXRXgKMZE4j7gc0af6GISwC1eZj2UxE1ufHvC4qex6VIGjpBpepWPWw/Wo+KbQjs5taQj7VQXsmIsPz9nt1cpe9SrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830930; c=relaxed/relaxed;
	bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGcN8LF8/YUkUqgjC45YWJmHXHJFgG1uOQvcDemrqx2KfzfyS4wU56FzvzuARuhwDpjgV2v0/LgugRZcY1l3T4BcdemEhyx8mabMgfNaUVvfrH956F+K80Xqa7upmzBghf+opnjNMnVkxfBDEdW4wsRYM1bathCR8v52xGBxYoqAlkoDYaVKJ72lu8Vsuz+o4WSVEc+SCapKV4sC0xpWB1mSpkkqEEGQbgnBDHK3CfSNrplPffUgTLs3PA86Akopav83AZQa2akP6ghU5npRPWbNRMt0PytjcAJR4DMGksBeLaTNmepBeKu6PqUQFz1GO8b84uHecwkP9Hx0moobmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lHi0PKrs; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lHi0PKrs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RM56khpz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:49 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c20ce3c118aso227191066b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830926; x=1792435726; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=lHi0PKrsl0Ch2yI46iTPzFSSl5yLyrd1j2evjDR0c3tCSevKOOq+gBd1nEjq/p2eb9
         AIjLITLQmOBeq4TlpnD+ODf0f3yyjjGO5wzUcAZaLrgI4yKSP2Bj9fATxqveUBqmTQnh
         IQpEBuEZoScBEhUp1Od//feQgHcfmihh9911kp3gQyu5/z6XgI94i9Tf4/YD12gH9sLg
         MdFJBGeTeO5Qi0OA0F1pkzDEhhjAUffiJ4eh5Yb+nSjfghjVN4iwwNgXW8+kLru3sCVy
         r0F68M6Jkj9foWRx8roEuQoQ7s4c2E2YxbRK90yn6gvMXYXXVWrL6SDUHyofQMf9NQ3w
         FX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830926; x=1792435726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=qzZ7NfTxlOiipdVUkDR2tJ1VzuFuClWjzYOxausO1ZE2E4VsCKi+19unQffKDfbB7z
         F/geaWfs+blebZRsDiEouhhBfH565H2jJlcOkWAki7zzubJpVVry6opUmNBWYd0L1LXM
         zvMpMZVH+BoCn5ePsj9MylUUA8HopRk1BY/vFy8knuok32O9agkFCN6UZE5BHdm+71xc
         rAUJYEj86hGpKdI21tAq4ZEt4DQnwWdUUmie5GrvE+5ulNRb/w07n1b1xiBfROG8Zrdz
         n2+xZAeGhpZnuupRljrIGih1Q6gcLLLkBadftGj7UWcAn9Z4i6lxIdtoFyF3KKuWJv5j
         zd2A==
X-Forwarded-Encrypted: i=1; AKwUvBxNT8CQ+6sTrHWrF8wwy9kAaWqWZ/RHdmhWH9eKS/Urn/BY9vpqZhdyIUqD35sToLiWLW9VI159Od+0WYA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJTgC67jDCDL3GSwX9ZQhxDJ86BYPeLwYIvCzWo4oFlBtM0MFQ1
	77lHj9AvfU6eHtNpjbj/6VhyTQx41aOQiqL2XyPqaDHcP1P2R5CGGevx/odQNIPV
X-Gm-Gg: AYBFou0Z5m8Fhp+CiLYD6g9TbtztogytoN8o1RMru6OjMow2V2K6ZYzENlJoo/VPq9H
	49nTN1CKOltm3rI2AD2CZ3wXU1axYPYba5L7W1Pk6gLcT5j7SIx5nu9LNoxotPJ7kXhjxaTxdYM
	oJ2kjytCaJKNAQzlYs+r7YwzgVZLBo0sXEunINXnT1bSD7Jyj17b2PuqDvS0nvUBFKj5pgUXbMq
	Ho5XdJ9LSMnLg7TTTJeFqcChHRwE/5Ji+/7Un9WOGT3vPtTmvm3bNElE907u6jE/DnipDnLNScH
	Q+A3ozxbvzKQl/py+upr/N6WRpP/nPy3TisaBlJB9i6VMkis5ZyTOif50xsKmV7Xr6bEL/p9UWt
	llhU8aLKLO2pJIMijCEYnCtEnquPWhBORs1VJ0gJTcbDx8zbc+SRbpWQDgqArLXWysZLqu7C0RL
	9LB7JEi8HnOqor9AIG6EqR6x5IWOvq+tsO5nh3XEIaNLdPQ5l2Iv020zL+tQolSDByMfUofwf+L
	LZScAiH1/7NrNWD6e+JzurIIF31xkc+3WbnaI8S
X-Received: by 2002:a17:907:608f:b0:c2e:33f5:766d with SMTP id a640c23a62f3a-c31a9d0fceemr1026790066b.4.1791830926364;
        Mon, 12 Oct 2026 11:48:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] sparc64: return from the generic clear_page implementation
Date: Mon, 12 Oct 2026 20:48:02 +0200
Message-ID: <20261012184826.986050-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\

