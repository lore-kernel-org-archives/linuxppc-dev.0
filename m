Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5648606A334
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i1rWqHAd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPm0V26z2yVT;
	Thu, 19 Nov 2026 14:40:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059644;
	cv=none; b=YsMTOiemB7B1B574hqgqdzx2xuvAoi25Zty1l0cHx3n0FUTzGW9K3VKsA2JTjCcrEh0MdK8d1Ko/5xtm9Kwyw4FnQepnitA3W/ZSNL96rLQkkoVpbXDTGmbJu7uOUSwAAmZmvjVuJCR/u3j4tN0NgSXhP8SumDMvA8M/Y3JAP5jDllxmXfLJrXdl8u2kYUEvQTrY+yWKctuTHTor+p5bVqsXG5fDfcrNiDs/rqfIINehLdWJFHdyMT1iF9PBL90XP4YuR/GUmJn3eWEWm345Pxlfqilb9cDYGvjTduiwPicJ+skugueP0LIKHxy723vCg65JTrMh40iwF4UAeR1pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059644; c=relaxed/relaxed;
	bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nag+2aOq0CSKeUevpWzDoFdw861MxdRPUdWgoDKmPDwKTqfQ7+f5lpNf0L+TBcSzOifONLqqWSEc9HfdW5At7ec+lzfa2htvkDwEGLpbaRclxTKrprEyOMZsFqLos4LrdOwRdNMzvztgnki5StnD5BRJrVLxCwxouP2uMF+6OdCnDreVf5nm2ZNUvDVDUw/loMQe9iZ6HzTNnIjlV6ca0w5cXl0vM8eQa73zYkQM/I68a3HeA01pBSshWK4WZfl4qQ8mycBEp8DMP3p12GKTQw1wvMY9UP7xR+Twyxtw+nugdeRM5TAHNo6OBGm4f5UjcQQjdQnUl0vOcWLkxdEwEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i1rWqHAd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i1rWqHAd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPl2fW0z2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:43 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-381d542bc29so3310798eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059641; x=1795664441; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
        b=i1rWqHAdswSt4+Nrb/bzbiqjmtR4sdNOAp3NCZKfRqHVZKB8vqRFNsIDAloCD1MBGf
         gFLS4m+8K41jTaoE48a0SHt1QdtqlJzSARLA0yL4Jk4/subcl8q78t1o6h16gAQ4nQ6Z
         H1JI2+wXE4nZo45iM/lnTym9aemayL2vELduKZt5R/qAQaxnQ8vIKdBp/PKtd+o4I8H2
         xTzkGAhthMOSlkzlHBmOcScSeA0hrPKlz+JbA4ErZBa+McbAsLe96d4bnDAA2fRMUQtn
         fOuJ+w1Bk0avpwdxe/Imkh/W+L7CyE4au4N2hid33v2qfnUhe2VJso/3TTjPsVtee9/N
         wNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059641; x=1795664441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
        b=muhX+hM9NOIKYgq4d3HJaj8jzrPFkSqRdMAsiEFR6MkBO5eCc8K/1QL4TEaeRVmUxy
         sRDM3xwGB405z1zYyeQcEiP/ldJSndWK1VOFya1tMyGg3Z3mk0wKF7LCvpyM05j7umR5
         E1Bs7gIPj9NHgyAidK07KMEPMuaVm+5r1uXb7laXCAsSrBi3qY/vs2XmwrLw+4EeustK
         D/CqxXUg/pkjk+M4zhES3/I/JauzNVHkPtCwn1zsZ2W4xJ53zVhX3i2Gyi+kOAx09KwV
         ehPiE7uZQrGdN2ZNcxhPi71tCoxW82nNPcSwdb75qpGHp1f3xsFNM84By40Ml/8KiKWV
         PCtw==
X-Gm-Message-State: APuU4Z+caJXsCuAcm11R6x2+eAqHkCT5xBES1QiUk4lAFBEA9WuY2/aw
	22TqLphGF95L/aPun0jU0GCt14VdiyLhQtIl/D2bzozDCL+bQBFEBN2XW/1Vfw==
X-Gm-Gg: AZFdTZcDVy+va3PTgeCxynFs9yKwIPWhYq4bk2MKUdukH7KRbraOL6hJiHiXJkjfjbk
	nAYIH60OWlAzbiYxbEoqFTTXgjq3OnBe7/YfLQpmXTx15TOFmngatBFYNBLev/FmpK37JWllfYv
	2jrb6L8XL2Sl9yl5ZdROl+jI4m/g7boGQiBkVbKO3QJqT/y8mzj9ncNNqissfsIGQWyjWpMexGV
	+PzZ/6lIRsW6EBGcQh9Ksaw8seBdzjmRe5KrbT8r14W/WMlOe/J0Xk+ukoFmc5PD2P/oS04Qx8M
	qI1z1kahxYrklWmMNBgFZl7s5JcOrQ60tOn4VYas9bzKfszwyU0JXr9Cp5GFQK+qfqX11jehKEb
	6no5izAbOjAvZJGUGkKJM0u7C0G2hQms/7H1Sx0UuwthkuXhUOCXGqXmSwWrwiujhspn+qqKmdz
	+qJqBhWAZNwSlCmCEpRs1OSoeVrZeqYFxmZdINgek9vRJfXRko4Pyh4KU5Ar3N2uQOQgMXHZZCV
	8K0l6ZKJXFmFk7+iP9/a7m0DmS9V5iS1e1/TrF0a7+sp/ANDf+tLUxM/jaRaa62zMapr4ba9MFv
	erEQDd1V0UsTE+8GELvPQeeBRWGraVPGyQ==
X-Received: by 2002:a05:693c:69c2:b0:369:1401:c5c2 with SMTP id 5a478bee46e88-3828141dcdfmr4038754eec.26.1795059641236;
        Wed, 18 Nov 2026 19:40:41 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:40 -0800 (PST)
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
Subject: [PATCHv2 18/18] powerpc/powernv: Enable context analysis
Date: Thu, 19 Nov 2026 09:09:13 +0530
Message-Id: <05a02d2da257e95033e7ee87e48d80ef9b1006af.1795058683.git.ritesh.list@gmail.com>
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

powernv objects now build with Clang context analysis enabled.
Turn it on for the directory.

This checks that each lock taken in this code is dropped on every path.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/powernv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 9e5d0c847ee2..834a56122aaa 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS	:= y
+
 # nothing that deals with real mode is safe to KASAN
 # in particular, idle code runs a bunch of things in real mode
 KASAN_SANITIZE_idle.o := n
-- 
2.39.5


