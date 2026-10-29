Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27C606E001
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoWwNSy+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFq2X0ltlz30Ng;
	Fri, 30 Oct 2026 03:10:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793290228;
	cv=none; b=BhD4xfNBfwQDdAIujHU8ocRqDQVF8sgys4x+1BbLykl7wPj3sqBh8a3ZggvRSZ/zjpxci7dRzmAI6VC9V9PPD+RzDzUd3C4GNWT/8UYI1qPdxOHop9ei3GRC/3SZCgUdwiLarnRLv9Smft+TEowAN3IIHBcGUtp1yxX0Xk3s+rNDudzpKppqnZX1bLj6ud/ENWpVzkodaj3tbBDhRS1q9SiWzZunyGyH6GJwhq1pk2P56eoqwcRWgT2AG7E0w7wMU9x6N0UWFPC4ucXQdRu3Aimmkb+Ittfmtq4ILTucEYPzqCM6DlNzwNZeuOQhziP82j7wjUb4anh2gPWwnQxsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793290228; c=relaxed/relaxed;
	bh=mQqyYE4c1qwaf/1U8bOHUwTa3uH7ZLUdP/AlkoHge5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nF9BQNxCYrrM7afx2vZlqJQtQsoUMnFh8JxVyCfXrpKIqzK0t6VB+PYNYMQ0A1+xY8HMYham6mqFTHgZDBZjKL+G+iacTOV0VqBQFz7TDXATh609buxXbXsozLLfIqZwcW89Ya73/OT8Odd4vrYyEHhGPcmeigWudl6nyaoGpgAD5LHf9sV4l3OFDZ37N7lyU98e4KM0z9ftJZhBmOdo9Z8Saei8PbFcNhFBPoXTIW+9qY8DUJW6kjVwwja5vZW/0HbkVBo+lbDPafvkoZkmWq0A93YUqyPsMyaJJLQxpmcuRuBpFeqZapIPwvfUdW1coKiWIKy6PZBJoWNlGAEnrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoWwNSy+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoWwNSy+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFq2V10ckz2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 03:10:25 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso16637755e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290221; x=1793895021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQqyYE4c1qwaf/1U8bOHUwTa3uH7ZLUdP/AlkoHge5g=;
        b=AoWwNSy+w2ZjJ74kbcwRJ1QdvCMngd7+i1HsPz+hKDdETF7du/ufr2w2dXYkFzhr1N
         u7dzRyHWiUYstRSdL+wfwDAFYN+wXlhZvP6z5QbidSkJkTBcV7d84HavUrn/Z17W2TLt
         cVeh5ULOZee/R40/x1/NUVu8bjG8SUxKFjBCXkwvKCRcQXvmLQdq1Z8KKWN6qfrfZvE4
         9PSasp0/thMnyGCyBk1ikkNQfvpMRQazIceuNMyQCCfywe2mK42ZxZ64n5xYZ7mJUIJt
         kaItDqr2awV/qNJH8faO30OkRRWWB2HuVjqaYyHqg9Tr70UCXaOtDi4qtPGC71p74pjD
         zaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290221; x=1793895021;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mQqyYE4c1qwaf/1U8bOHUwTa3uH7ZLUdP/AlkoHge5g=;
        b=wJWe5LEtSUdc3gSQvpmWWlbY258FJRaeTF65jUb6D4JODYOPcVQ0YvmPenzzV7HoCC
         idK2tn7xXOwAF7iGQAEA0VfQZ2Ae4C69cs8gUZtnf+aPT3FTOLxkgUWUTdB4mB5lTP6s
         YggOErm1ET/vrvVwEA/qUnQR6XLXRqujqS8tylOe7nz+0P4TrjKyWmZju08g7iUSuVF6
         s5N79ik2VwQTALtDY6IpgSE97fOWkLpQXwjhDmO0a7SKTp7SDq0WxycJYQDFeUVjYxLl
         L73Pyl6Rnse6TRrn8oDZqdLu+BVe/pe29PXeB37gF8n44p8HaR+5cG/+Szkkep8GIJmL
         dnBA==
X-Gm-Message-State: AFq9FYIaT2xTKpDzX7kjBMdfC2sic4oSZ++azatfvm7GQF0dOtOKdya2
	+iLQ+k331xIjLapbuPYLxy1cQDEo22JQIPA0Zj8rosyd7vhaVNijBrUZ
X-Gm-Gg: AYBFou2dzii2bsRIzvZXgDE3ov0rt91GkYGQL+kTZEv0q0YI/GZMPQWmMkmk8LPu39z
	wASzY0M+I0POcvMpqAam7tYINHFQ53K5DGicq/QrA9MzfU9TLsWGqd3EL/J6aGgLy7sK9btX/U1
	3XPAamvm2D1TS8r1XJG8iV28NGtN9jfl7uJt1T4fZo7jBZzNRyvZuaPqo8zU5Qvxfn7fmJj0H6r
	E1XEU77fsrYXLWCdMuWodqnIRTlaQYhubhKYJCal1BpcPIE6RXki6LPPCR3JO3nRNjEsss6/t85
	B//gUTf9KcEqoRwTODSrF56Q1zFQC4sjk9patOpfQ8UMKjQ5njyp8HmKK/Yva2s2gF1J7zi1704
	AoCUmrnrbWIkIZk/7L13+ZAj5EspgqAJn0AsvekJnQ5iZg/OK3JuQj6ttrapeihdDNfSaXzAOcY
	G3clVxPgtzP5+RpZdDrgoNOMiFvalAuhUzF/uSTKkYTc5HM7/+5CNPMjSX9ij662hzl1PuCf+sN
	kkjm2+o/gZ0EMsqGPzvEf0FJzsefqu39aGoioe7Xu096ma7VbdWavcfwQKmt1d1Ui7d29tqGT3G
	Jg6rplCy2aB+rYTSyVKtXMTxc55pEy+++1wHomvzGrQZWbeTO01o5j6Mth0+H+jpw9qwzC66gKj
	xkR/BWWnqe+pgJCK7jw+qxumXq2UEvE8SBswOYj7yvu91YngGC9LS/t/8mhyJmUK2QfwjbBbqBX
	8yc6G3IGqCKL2UrFg=
X-Received: by 2002:a05:600c:83ca:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4a9672030admr147844975e9.23.1793290220695;
        Thu, 29 Oct 2026 09:10:20 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df1dfa5sm146254f8f.2.2026.10.29.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:10:19 -0700 (PDT)
From: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
To: krzk@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	sashiko-bot@kernel.org,
	Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: vendor-prefixes: Add WatchGuard Technologies, Inc.
Date: Thu, 29 Oct 2026 12:10:08 -0400
Message-ID: <20261029161013.52866-1-lefteris.koutrakis@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the vendor prefix for WatchGuard Technologies, Inc.

Signed-off-by: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..898bb9396454 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1891,6 +1891,8 @@ patternProperties:
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":
     description: Wandbord (Technexion)
+  "^watchguard,.*":
+    description: WatchGuard Technologies, Inc.
   "^waveshare,.*":
     description: Waveshare Electronics
   "^wd,.*":
-- 
2.53.0


