Return-Path: <linuxppc-dev+bounces-28310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4D7C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:34:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6Qp0jfJz2yfS;
	Mon, 28 Sep 2026 00:34:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::28"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519682;
	cv=none; b=e5V8cIkqjE1cWw4gX/LWt8CCOzyjwgNOh+G8YGH0SVLNhVOk3KZ/HjJ2hlQ+atq8/yzJZTNiknZIj98uUL9DjeJlWNyXqevPGXX5FOrlXYLB5491hL3bo/OBK7LF93+DFNR47dm5uCkd8uzBiCL4R0bWpCRB7XqLAtn0Xq3o0HbdRWfXULdiTWHAj+JDz1S0ZuPQhc/7yvfIYTH4uTtCRG6dreWEL2VJp3S2UZxdskbIysi2/XktUa5qINKemZG9MawCJ4Zc2j98+XXWEj2f46OQ5PeSvv7TM0duHdbfdhf+kFxEeFG/xBFQd1toUMsU35+59CNgjH1Q12Gjw5Uenw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519682; c=relaxed/relaxed;
	bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWB6cDFCcLc+3hg6tszKMemYlve5PSxZWgwtUVIkPH0Ul5XZk0F4vk9PI/nxHhponCJjAkpM6+7G7cdOx3+5HWJzxykyiNXaMcDZuJI51c1eJuG6UolpogaRC1n+vojGURsxPpf6kcNs5PEk4EDidNuycWJ1LajJVp8AUbVvhYKrzNG4kRhEey4KU4lnDlkprvbl8VgkM+teS69/JK+dvoXY6wwxjqossRp4aZzuUTIuPKqiM6Soxap+zjEw3ZH6O9AMOZeEauv6EJnsD4x402uSp/umBAy8mQkaYuLiF4EhkoLVI1TxLHrZQGgOfqlqwqBTL22dTC1MtkhgGbKG/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MwRVhD3G; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::28; helo=mail-dy2-x28.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MwRVhD3G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::28; helo=mail-dy2-x28.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x28.google.com (mail-dy2-x28.google.com [IPv6:2607:f8b0:4864:36::28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6Qn1Bgpz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:34:40 +1000 (AEST)
Received: by mail-dy2-x28.google.com with SMTP id 5a478bee46e88-328664c2da6so1762268eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519678; x=1791124478; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
        b=MwRVhD3G58qblCWw8SkHFjhF2EOst7FiV4dF4KUDtmf/fa2wlkoRbEbdWmEHeB69zF
         sMAWfLDPnwDS5qwzzn7dSOxqk5izdPjnik/qa6nI6bSB5sQBjzlxFBpD1mfKgsGo+5lu
         o2DFHPE6l13vXPZ9J6ANI1YZc9CMjd/UCdVA+cTGK3emVXOuFCUsq1yp3xXHXoLpMPdF
         cUr1G+I4eJaxpJG2W2D1KK/7MEt77b79fSF7UKiptmVNB6QhJgPtXdaoOv2WxUMVzTRT
         0WcI8J/hmfGBYZ9jf+8vIoXtOk9QI4XDieHy/XtbTL7FZYlNUTwSC03+N3Z6NEBaiw1+
         4Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519678; x=1791124478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
        b=E1zinbLucb9x04QAYq/7LsJZ/xdy99vwD1Qy07UqXuiYmLaqAh22f55DO0dvi3/1K1
         TrwgMkOul4W5ylmdOclapq8EyvQ7IEwABCAMgXv7g8iAKjU03eQHJH07SKdowoh6343d
         Chq346O0otB5CZz8mFvkGBwga10lI1N5AoBSFgpFqPRhQA9VFc+j5hmsT63IlSAKW4lH
         +Vc9IJRxQtVJ5g5GhC2COBF7r0xZo+YF985fbj5WFL54ywmJvsauEVPRQXyy65RsY6oC
         77UHYNvWX4MXD1P8QwrOkyHBpAoSkge5HcB36Vs0I9wUqU/EuDkDWN+Hh3WM9VjlB2zl
         t3TA==
X-Gm-Message-State: AFq9FYJL5sAHy5uwk/sjT+cwsMkAI7NYZzB4V0tif9ZMEsXShZGY9otQ
	YdClGW+YzZHFZ6TNkAhpkiCVK1VSaWZQszHJzwYhWlzrcjEga+iEO23YbEB1RA==
X-Gm-Gg: AYBFou0EDcrJxUoaasa7ZvvBblvU6+qT/E17Q8s0YjNwpZZl49a0F0eMayMFlBoPXB/
	LRaLUECalGvXz+zl+2AfKhP9GOpVdSPhgDc7CH9Ka0bGWAWABzd2l1l6rq4jBvb4DpUFgIojeW0
	+zV9dS8/71hn/3XfwIMa1d7Y/1dPZqq/OaOFjD3fQDm9xhjNKIFtuCtcJaXgsTLM+3x1JlewJ1K
	S1zVn9vH2wpXSZIiJXqIAwQaxXrwDsO9FE89QSnaPabINk0D53iGhyhax96Xb6Yu9t0NaHKARdl
	qrPAfVptub+7FZqqo8LyDmrmiGV/9TPyH8i643Oui3+KRokv0K36jzKbwveiXbSagDpqnmBNqt+
	h8yJu0UHOCabkTiTa28vRykb7wbmqOPv+069yMl2dj5tudIcjo6EmTZ58hrVD7E09sjNf3WHYVH
	7fC0PqjSBgg0RQZASuy+fVZgvY10glNpApD+k4mHxoh/CbRSFEKVwY6jeMq0tHQxUnIlfNjJjp2
	qcTbDq/poLLHOAxbV4Y1f+em6O+jJ1spt0abCRmlLjHpg2ZFKZRjrVUPVwS
X-Received: by 2002:a05:7300:a987:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34271a8dd5emr8654973eec.21.1790519678071;
        Sun, 27 Sep 2026 07:34:38 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:37 -0700 (PDT)
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
Subject: [RFC 01/12] powerpc/pseries: Drop inline from hugepage invalidate
Date: Sun, 27 Sep 2026 20:03:42 +0530
Message-Id: <a7ae0f64960ba1ef21d2a836974420f08bf0ee50.1790517984.git.ritesh.list@gmail.com>
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

Leave __pSeries_lpar_hugepage_invalidate() static and let the
compiler decide whether to inline it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6a415febc53b..94cd30e9f6e1 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1225,7 +1225,7 @@ static void hugepage_bulk_invalidate(unsigned long *slot, unsigned long *vpn,
 	}
 }
 
-static inline void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 						      unsigned long *vpn,
 						      int count, int psize,
 						      int ssize)
-- 
2.39.5


