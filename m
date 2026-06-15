Return-Path: <linuxppc-dev+bounces-22672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B15CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 23:37:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfRPW0YLgz3bt2;
	Tue, 16 Jun 2026 09:37:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1344"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781566670;
	cv=none; b=BHoi/MLcqQ3D6tckfjQphwzQD+XHictLgOz3KH+zKLo9VD6sTxNR+5CxxRLdxKgQz8GRi4BcMYvrCPRidPjHS1PBuOaXyrQUWt19Wm8U7aN/guXYZ/cyLHeLCGn8UYdqYc9llUwCPOmFfohGXS4nrOAlCslY8n9AOw7V4zvvmGbT1/dIoIO0xSQaycIIvjyPRZ1m+kvu74a30CaI3/0clHrCm0v87gNCrMpajJcmUZYB99xA04xAGcZGua35hxzF3+CH0zHKOhFtVC0pRQNS1lYC+ghrjfIh+vVgVo4rHtulb44Xbk63E4jJMJABFfgd4LFeqVwfQ2nTdDJGTYJGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781566670; c=relaxed/relaxed;
	bh=IWtsgQMgLXtZgryprx/woRtK4v3sMFHFdfoF1UZkXmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ah2TVOmRqDH1I6WtB+bdkBJ14spH8P+IL00hZM3sre/eDHw/lr8yfpAaIc86EUvmN+fgw1UmB0FicP4Ni12AUSIOVfbnaeFyWxaCPMGEp0KHYm+9ThRi3Woj4YTW7rqeJEaIYNX81YT0WmrhiKAwP0VVtGabDxWf1fXyFHCmgrrtQfNNno2zadAdBHwj+GQ7jMTq5+gFo1iThFazUEuvrPSHZRZMEJ4evqP7Ulf9wGrzbdg5AIHV58fAvU0keXjPRY6xW5RxMSMEdirFdEhsWPsqV+2kbNUpi0KvqmQdapXqPnkgYucQWY7sKRYjT1iYHHDWTE/19ja3sYomWkhjKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eLsNjA8U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1344; helo=mail-dy1-x1344.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eLsNjA8U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1344; helo=mail-dy1-x1344.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com [IPv6:2607:f8b0:4864:20::1344])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfRPT71d3z2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 09:37:49 +1000 (AEST)
Received: by mail-dy1-x1344.google.com with SMTP id 5a478bee46e88-304f590dd91so4539153eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 16:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781566667; x=1782171467; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWtsgQMgLXtZgryprx/woRtK4v3sMFHFdfoF1UZkXmE=;
        b=eLsNjA8UdUytcdea6SvglyabAHIpWm823RY9vbJ/AeVn1GUc5KTyvWVKdqsZ/YBGz0
         j2gfOHo3aUcgEOvLFEowshBbUWyhRCzk+FAsosKe8+84/PJmbjWhk8IB7PM1/8pWCSsz
         ccRYHQKy3BK2+MlRwkLyVeU2+4zcPI8Tk0reEhi77oKa7wHchUal+YScMZOAVZERiEDN
         NW96BkF2Ky79VLhYTevi/DRzUW6d8B5hn0FSsOB2olDnzz4j5jw/Gm7W35oeWJ7jhnUl
         1NOoKkDZxsO12+FodYnThFZrNO2qgb1u06TcDtyPgkL0Btu7jaywW8E8QlCqp6b+OZLG
         CPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781566667; x=1782171467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWtsgQMgLXtZgryprx/woRtK4v3sMFHFdfoF1UZkXmE=;
        b=UqcuJntBASaVsJfJU5sDZ4gIFY0h3cM+HBOlWr4QzOKKmLwK6spTj9bbZ9ICUqHIeP
         AwgKNM6LjT0xwiQfTjJyKoXIyLXIiwogp4PmVDL4/QKOauOIRF3mcFwsoED7egrereYB
         fmXVRwMpJqjAucF3VPUpvtmiTRvBU4nsMJeE0nGNFCJ//2AKaAoR37WCviGcGNSdkPGs
         tt+6/DqZpg9xyinAx+kCJhib5iicf436WwUy4GXeq0BlSwb7FyX48XWn4mU8hJl0TZRz
         xKT6lF0tZxRBDMSzD6h6j+xrJeDoSLK8vNCF7IcXNIm4YlT6EjsreKh38XkGBuDppl9I
         RwEw==
X-Forwarded-Encrypted: i=1; AFNElJ+3L/Ad08m8tnjTQ1JYiNABRIsBRTU9mEcZW8Gu+VHvHr5t+3LUbHanrH4uZq+sx99P1RovfsqJKEvZqSI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQZMcP6rmibrT3PQJ4AxmvGboKCwFr/d6LXFNw3VdTpvjmOHhy
	wbAz5kxkqU1HRwcf2F5CSaRt5IzwylOW1V9hypCAVlA81SqBDETAyqet
X-Gm-Gg: Acq92OHLkW4NAdM4LXHI/6jB7aAC536axIup6wZyXoP3zeoafQ2Bmf1ghmdXExb4E+F
	XjtiVdiuzYUZZcyW8EHb00pzZItkUJB2INb36avrfp0Uu+rMAHaKF7Jqr8+Pj0O2wRbQjOlb3Zl
	w1fP2jPcbBcboN22unBI3Fs5nUssmuR+3kUFz+exa5dPbhHAz/NqNFY0l/gIf33vKl9fLuNHSJ1
	nCj1c4AGnEkN7obK+pht6TrfknTaMM2CSZQxJOrG8efo8X6K6pENERLWdGwpGVg3uPyUuZZHY4+
	YfMGTVuSZhaxR3R0eZkPmBdghjxyq+Z9mh5+qJVo2oWAxG/YYQvNJB+sVJjp5GdvvDhFDASSeM9
	4GXaKDuXQCViFrwPaUQ01vPeVdIXxaeSx86Gza15iIXNff0/kjKESs+zAXIFmxNyXR4lk3BO1v5
	vTPJpB7VRt9udKcRQHQ6RsXk1F84EhranKew8fApagOhwp8wbBQB1Ugv1GkeKBa20pRVrJA8uuz
	NoeVHqQs2Mi0mMoKSs0VPldu0ktkvhsr9FVZDDeWMvujl4W6gTxZED3FLvETe1bF6PwGoUWbFoA
	wKOg3a5ik3jZsf/dQg==
X-Received: by 2002:a05:7300:1827:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-30ba59d3517mr869225eec.11.1781566667050;
        Mon, 15 Jun 2026 16:37:47 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm18158501eec.10.2026.06.15.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:37:46 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()
Date: Mon, 15 Jun 2026 16:37:26 -0700
Message-ID: <20260615233729.29386-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mask_user_address() incorrectly checks for CONFIG_E500 instead of
CONFIG_PPC_E500, causing mask_user_address_isel() to not be used on
E500 hardware. Fix the check to use the correct name.

Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")
Cc: stable@vger.kernel.org # 7.0+

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2: Correct explanation and Fixes tag (thanks Christophe)

 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e98c628e3899..619270bb7380 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 
 	if (IS_ENABLED(CONFIG_PPC64))
 		return mask_user_address_simple(ptr);
-	if (IS_ENABLED(CONFIG_E500))
+	if (IS_ENABLED(CONFIG_PPC_E500))
 		return mask_user_address_isel(ptr);
 	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
 		return mask_user_address_simple(ptr);
-- 
2.43.0


