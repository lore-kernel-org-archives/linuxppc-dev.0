Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A479606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3S9Shya
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPM6CZJz2yTH;
	Thu, 19 Nov 2026 14:40:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059623;
	cv=none; b=Ifu5eolJB8AUFxN+PC0eJyLw776k24ZP0joAVGVJR8GMOFeFMyFf2PRl/bufIyAziLZIT4D36JytMT+vaiEYa5XA/BRQa8Igh4R7sVaqXaz9KLl7r/wHUt9Yo0DuaQTwo5iMxrHq9JgxhiwolaBaBSMWAwCLyljXMnGZcFksx8f/QggnuyeIkH3/T0dI5Jc00Xv5mOtg9ZDUfuOgyR2W8Nt3Nmvqy3tPtB/OiX9mq9ufsAta4HVi78Zt+/rFnvYmezNGX2slH1z8xFL5S95dxfWFapH+7n7Bv+uhfff2GsJhij9+iUS+X4JgJ2JltTe6HzpMdpnjeIqRpv/7iNHoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059623; c=relaxed/relaxed;
	bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCYinMYYuvMJ29N3GueipwOP4EcFz+dxar825Jsst9Lt0DD3pSsnicAU/VNrczhQvzHU0rv1HSMFfl1jC1X6H7W9s4OG1scnVP9cd8y0Mky8T9BlV8dwQtvTzNxvF7SYPjm/oIy/PIoX9LetWHyKzol2S+U1un7anx1v090MJD6Tm7w0lPdp3KKVM53n3TKcEH2ozEv5uoxdKVTs0qOLDGMAr3tgZashzsEO3EO3VPyzCxvy7svC8E/xpJSJG47EFnVmtWagAUbqbeITeIqtobb44rtsh8vodMYQbAMG3dbYWUnEWRqr7gbCcmbeUstAR1J/j9W+5JEesNp7g7wM8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3S9Shya; dkim-atps=neutral; spf=pass (client-ip=74.125.82.179; helo=mail-dy1-f179.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3S9Shya;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.179; helo=mail-dy1-f179.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPL6dsWz2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:22 +1100 (AEDT)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-381d542bc29so3310395eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059621; x=1795664421; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
        b=h3S9ShyaPwPeO8/ZZUIADIpiSxj7+1Q/uDyguFXhR/v8tJ4MhdBDXPv6FhI2N+Fy0n
         Ji/H3JS2Df+2vt0XQNU3zxYA0ZaKfemLVIF1X0W2CtK27Bw5+mR9AZtEs2dvrbL0Rw/W
         OQnwunamS5tw/8Zw6pD3shNppIPWp9SmsR9V4At2QPyE5kMObL8CUNCUv+BDrlLSXKSs
         sVxsZhIkZajiXFwjfHUsAHmIDLrF9IzVsrKC8irCTDwan/c8SQQq1ueJmJpA9LFmOJ7R
         QSvHc8cBVD4LpohqI1V3FFVPW1rywWdVqFyymzonJ4oTjAk1ZBXYupUmYYCcnCT89HR2
         DT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059621; x=1795664421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
        b=VrTgrm0sLvKYf4KTlJuLlYXVHlSSkD9lznJ2sfTCMXiLLS5BkgltfYiNLTLFyTYoMW
         7Vl0Rd74bYf7IsVJ6dweC0khthCH3qia0YMp1trCQnpyvcyXKO76BT8+6wML/HFUo7Ud
         kdnuWJlkAV4UKF3f8c9wXpFHhv8CTscqzLlpqd5WS+Rny1xNd+IkHk5RfzXP3ZimPJzH
         T7CHNRk4Ze9MxFCZkn7ZnAWtjs5RDIcXNLxj4hzfcBF3mM0JknI3UCcXC+2eN3OzJ9g5
         NtkqNxY7GfyJ+ogVLIzbFozGIRweUA6SPKFjw7r65sWfhYlgywdDTDtPp7IEuFMYqze6
         BAVg==
X-Gm-Message-State: APuU4Z++pbg2YxANo/lfGzPZjnI4cNExv1m/C9Q7bPP6FjXU7cDdO6/o
	CWgkazbWDANbeBpi4uO9aB8pt323Xo8EB1Uf7C6SQsfene79AkWtswLmpSZo0A==
X-Gm-Gg: AZFdTZcCwCibZyk1kJGpi5W2IZeNURppGexDpQgic519U3jq4dvM8+Gy3iN41oNkbOK
	9YC3mlNrzGepjcsE2si6Vzt7AkH5idHELY8v8zVYi6MCZjr5MkT5lYeLYvZwT4zG8U8C4N9k4Z4
	LnAnM/LNKm7FVlHzVj5nwmJ0lEBHTupWoMfXBn/bQOqnSgxLSxPu8SgfKP+qkXTX1KQYrxF1xYc
	+A9whA4nGeQz+PVDRM+nSTKK8elgv5n3r5Cen3OvbwAv6DtulrZ/8Re8CalGR/OmidwJLjYsHCH
	efAbsMwb0YnHbJtaqX9ostaNkxi89ANhovKFMth7a/U6MJCoNP6H+9Y5RMPYjtJZyQSMkV21oca
	++aoQJ1E7GjghKvrwKn3IqZg8ERwDFiMXsynAfojrJHWbQ6mXXo4GxVt0+pqYGDxU/9Dn2z0YIZ
	QbZJp3kAZmZQURC++q7j7pE+XzaTovax0gZF8qH5321lh9gNgDvh7etWalUXpPBA8uMDaN21kIx
	e59MHxbo2fTKe/lkvtlB7QqLXhqRF/knQpqtPBLzqOth2wY7bGNDS1T97PHxICNRBmZbpF+BNdf
	TI9uufHNOCKgaoUsqAtHmHCpoqvtWjh0JQ==
X-Received: by 2002:a05:7301:188a:b0:36f:4d62:2884 with SMTP id 5a478bee46e88-38281523fdfmr3808063eec.30.1795059620603;
        Wed, 18 Nov 2026 19:40:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:19 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 13/18] powerpc/pseries: Annotate the RTAS physical-attestation sequence lock context
Date: Thu, 19 Nov 2026 09:09:08 +0530
Message-Id: <edad5b893e5160a54bbe5c6b19c3aa31d2ac2793.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  papr-phy-attest.c:154:1: error: mutex 'rtas_ibm_physical_attestation_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-phy-attest.c:169:2: error: releasing mutex 'rtas_ibm_physical_attestation_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to phy_attest_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-phy-attest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-phy-attest.c b/arch/powerpc/platforms/pseries/papr-phy-attest.c
index 350ba26e5962..d2bc5c0da422 100644
--- a/arch/powerpc/platforms/pseries/papr-phy-attest.c
+++ b/arch/powerpc/platforms/pseries/papr-phy-attest.c
@@ -133,8 +133,11 @@ static int rtas_physical_attestation(struct rtas_phy_attest_params *params)
  * @seq: user specified parameters for RTAS call from seq struct.
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_physical_attestation_lock held.
+ * phy_attest_sequence_end() releases it.
  */
 static void phy_attest_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_physical_attestation_lock)
 {
 	struct rtas_phy_attest_params *param;
 
@@ -161,6 +164,7 @@ static void phy_attest_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by phy_attest_sequence_begin().
  */
 static void phy_attest_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_physical_attestation_lock)
 {
 	struct rtas_phy_attest_params *param;
 
-- 
2.39.5


