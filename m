Return-Path: <linuxppc-dev+bounces-28316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E38C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6RH5sQhz3048;
	Mon, 28 Sep 2026 00:35:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519707;
	cv=none; b=AF8dkJ0AnhxYr962s/Z/xW+4Viso4kYzgxFS78mPvlbNeUprOgK/sDHWEB8TcHdlyntXHsrF/MYpBYPhgpcFLEtAPPY+U0omZWvXBh+1yCpfVi1EzXr+bxZBrFR4M4z1CERbunKMGrztENeg8v8K5PCdYduPkkmrFUKcnMuD22wYDyFMWc7qKQBdJlwuFi86dvwBEGmJmjqwlsBPIRQjkwdLGa86L1aLni7BMTO2+nPmArgivcTCEo2Y1NPn3xMe0aIEXVLIfBd/idvW6cEgjJR7ftnJR9QUoq8s99LU+Fta9dWWZPqwQ9xo+E+1lk5EDsuqs1EqUe4VGG/CkOK3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519707; c=relaxed/relaxed;
	bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNUGYfa5KcXq0uoEXBLzRPTkJ+bV9swl5lIRKj1qDGPpeff4W+iuMlMrlDFHVMBVX8+UjF/v1yJKQVNT8wNzF3ur2JDH6Aq802XXMGaC6gKCjForWtQiiHIgAm2L2+pe+gXcwA1LZT68B4cd01Z96B0yK6e4Hn5YtA6qSCd0oBaXYWfw7xYdsB9D+XF+cK+FUNtR9Xw/J6N6cqOKsuybPc8EIVnHcAzkDRRv9v7QK31JLmpaRLK7h6eFG1qU040z8XfQJ0u+AKDhuHWdJcNBcFtkN6i8Ze1ioZB4D/R9VWk7L8Y2H/3qhLTX17RtpHhV5ITJV+5JaYhfYU/eU37TSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+BjwvB/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+BjwvB/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6RH0cSSz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:07 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-341fe27b718so2183842eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519704; x=1791124504; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
        b=k+BjwvB/8y1lsRdaXPEJPY8gfWOZS4DLz3oiHp8bMUnXjOr2qColWpeQgxMRCzzE/o
         pAhR1UiArthJ9DKUuk4xbhtyR02swCCDN4DxDb4mtCCA6/8Mnw98G5dZ45qN/WVZPMlq
         gYEgv0//rdyJCM3UCWTLf/8WWBlBUr1cAsLGrDNuiqGj5z1oe5keCAZJ3s4TWGAkYrOx
         iReJfYZS6DbvOpCiRWRyElE4XKbtejGnwuDxML3MEuztdaujniiC5w2igrFEAJ+SCOux
         No8W3bOma+6dB9SXuD3TR8d+E8yy4dMhtCvNb+SPt+kn3qa/AACwoxBouXwREZ41QIvL
         EcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519705; x=1791124505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
        b=TGVx/4hMaKVYD9TbYvaIrRfULqyUF9cZj4hnKMboOOEguzihdevClny+HFX9Tcn4Bg
         WyrkSdFIdEQvSUiddm+Yc7MjVV/bp90WM1m1DL+uugylMJytNEsyiSBXzx5hdukgsKDP
         y3IKiFg2bxBSYklH4bx+vbotkRQY0bniLqdfoBFG38EZW1e0QntIh0hFrTqOMvyPcru3
         0Eq3iEMqc29FrmEEwBvc+6Q7RwJ7uWC2x624QqCMxhIdMzmnb4AezGfEtVNiuXjFmbKh
         V/vZ/Xn8VgFu/q0FJh99SVdObo179Xt9XK4LnzNeuLs86pDpgECVNRhv//OzVQvupisT
         G19A==
X-Gm-Message-State: AFq9FYI/TZjuy+IOZzy1OoaJGsE8IAk2RKbEauFzNRzYtKLnxlbWFrgI
	bhHVRUdnDKal+ct+t9CydYwsjRvGLBVAlw5I6RPe3TEV4qYw719/yEqDs+N+lQ==
X-Gm-Gg: AYBFou3bMhroEziwC+2S6JfHqQlVcPMk+0mjMRzsBjI+LwnfkvCVu8v/2CzIhreuke1
	9DnPsN/0LmGxxtyhAaZefRw0LnDltZexdh7k7F726nyV0chAMw7ZXMOsv/F2pMS8WxbqXAbCl6k
	5d8zr5gtKA3k0lzko+/Fb6meBJdZdQyBeoXR++NjLiJ5U9TpSPKjSZjHJKQ6ElG/XRWZifzo+8W
	T6SRjUQHnvk29oW/UfbeIa4BgaNslNYqJBgdgHGg/prHzrEMo5WWB4rtt3Gt+IoAOv7CNnuBz2y
	VDqwYW8d35dtAixKgJ++xS0Wk0GPi5qf9u+bR7n4Y/wnqOwhV50Vt50WZizLyRJvZGCAHrviv0x
	yT6mvXJ7Yw80Rj7Q0KYZUVePktBSmv5RmVrQrJIenpvAVGZJG9hBP9Q58G5kP77zK+dvKRrEm7s
	NW7ouU0oafgg+s2O2NQ3Hb+345bxrTdsBUCelAg0jDXR+YiSK8r50qXlmQI3yiQpW2e4SZPomJP
	jcIWkavSvq2D5zZD2i9XG++XV3/pLYhfzsh7aO7VeEAnGIj9O+Jue55qQVSlUPARNlj44SU
X-Received: by 2002:a05:7301:1403:b0:346:d790:9e0d with SMTP id 5a478bee46e88-346d790a2a7mr1438024eec.19.1790519704521;
        Sun, 27 Sep 2026 07:35:04 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:35:03 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 07/12] powerpc/pseries: Annotate the RTAS physical-attestation sequence lock context
Date: Sun, 27 Sep 2026 20:03:48 +0530
Message-Id: <8ba89d7a07cc356a0b31a09b01faa761ebd56504.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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


