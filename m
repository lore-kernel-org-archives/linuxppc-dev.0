Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1vNwKfc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZk5N1Pw5z2yDc;
	Thu, 26 Nov 2026 15:26:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795667192;
	cv=none; b=g7FQ8J4yNJKf6ZOVJkmfgvI1oSklsOXSZLylcgbbUgRkYtS4o4V7iIDJxTOG1zDgA3Wbn/tGRsSQnYJYwaTMJUc6zGIzjdmWd/HQcnHHd1+yPjwDwzoJajvzfRJVFXhl8Zd4qZGkc1B6Mrr7mxWYBvKjO+2cHFYugC3isz94ImLHXvw4btBvFd2FQ/FoN2c6Nn7zJCaLSyguR1yBpfzNi+G4zja4uYFeMPiP8GXYjHfO2G2LGYgPzwt6GJdNVdYu6CDnxon0Th3ms2TKOPHfMejDJf9DrrDKa33orIQD6PBeKnC/PcBnLCaR7E9I9hLKDp3NWoPNXiKmbL40MmxKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795667192; c=relaxed/relaxed;
	bh=JaZ96BFP7w1Op/oWAR3qnpvuRVSOJcqekj9/BhNvATA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b303jXMM51hyhzxyikHBtzPOC02b+ORnF1SHg5IFFtNLc9lzGrQnYOPnkLX/IARynDdSpBZwFZ1nCBkoNPwPcqkhpOY+4q3W+eI8g3/eb2NhuUXbcgJlInn5UV/drkZv3EIKm0n0Vxc21i6/jyAONaKCVxWfgA/E1Ugj5sBbELfZt7RY7w/t0TTP5z16iLn4zG8Mne6yZY4jhzTh5QLYRa9uEfBHmAEKGUYToOzK12B/u5tcJB2Hfod6WynaVDL9a5DYhisphA9c210Wq3JB6CIKtIVkoN5CDUi52WsODHUg3b3phJUtkIjxA6FRyetmVVTGvoYIH3e0zR7/2UnTVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1vNwKfc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1vNwKfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZk5M4L4Vz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 15:26:31 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-385c497bf94so4558060eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667190; x=1796271990; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JaZ96BFP7w1Op/oWAR3qnpvuRVSOJcqekj9/BhNvATA=;
        b=H1vNwKfcV6tMbXpi5AhlKM2T9ssiWoiR24diIL+vM5OfWzm811scEnoo3t/n7Cj+nC
         x3uOqDTfQOpHnooCbODoA1bqWalXcqaAMO2H8WdjU46d09l4ciOfHnk1BlbT86Nhq8L5
         hCkRUUYNBFLvoukDVJioAbCQ0ZuwftwXGgl9mDr9FLONglewQR7w7M3biz97Ifr++s/y
         oKtf9Azahwegdoia2YSqM17jilcjYyZSkhcg0VHROr0AfQ8o3OCV65U41lKLrbQ4qTfh
         1y8AJTsJT6gor3W471fhGHYYLjyqAYk0bxYheIX8Oj/I2/Vf4Sv+I5c/IkTZKxhCQnRP
         so8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667190; x=1796271990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaZ96BFP7w1Op/oWAR3qnpvuRVSOJcqekj9/BhNvATA=;
        b=mes6vWvrx576XSa4EPPZWnD7OgEfdL30oCvPFLnUzjlCf+ntx60ZQ2lg9dDNiNfjlG
         mRSEO+64Vfh3Y2sLv0Xk/D82nWVeFrSFSiziSk6fck0TUB6z5mRX1q72as8JzLhfgKfB
         +RCpOhh36BtKfQPhekb/99HoHiUE4R7YhtoJUZFxZFMIRLs6vC7+y9CHsBHc672dvplt
         9rNqQ38/P896LtEgIlqxn8Hcwn8DgQMMnqo1Fuoq9pE/bKXOY4eTKkBXdzdBKsn6wv3u
         YwjOlPWJKBCyYSTDRZgEdPUxMIOM9tAa+a+UbUG+Ch0gu8zDpU0LURPNddr08yOJ/2FK
         MgyA==
X-Gm-Message-State: APuU4Z88/3ZVx7x57Al7by2NzYFeveS8BCzcKmAGrkTCvzmdgIhY6EZL
	+NrXA4uhFzXe53g3HI0IB7o7oQ2f2C9MHnVwNrSjEk6D+w5DPKooRXnasc+0dA==
X-Gm-Gg: AZFdTZfTrDB2YEEpRXeNsSDoDfD03D7LHZhsM1Kh+c7sjacViLswF2NVF6LOReq0hZS
	8rmclwkztQMCDfScDXplDPozirqhqWag/4/6qMCsnlhPF7ZQoxDoOoszduBnGdA59lbeU4cOVdz
	jzMo34StdBma8pSdcsl1dZpssop0ozZDxCTFZtdXY5Kqy5BEI0Xsl4mS9dY1018dD4Ct0nNp2bt
	AP64kXxC5Zy/ybVuWBTPPzRQJpWdGRD90ShBFiN7wiRUOHwMvVWvo5xrIHO5xIL9AjHUXyjfpwk
	0h1IpJMNtsVMukt6bnGUVBDEGTJj0NMp830+XrXqUzI84xUiC1KA6o2VxzyM82Y8ZwIRY+yWeuU
	RHnJa1eWGYfnynvGtL579gxAqVYlsh8W5Exp6rLaHgIB8TLYBBXhxQnaT0/Z3FjGyzAHer8jVL7
	ZPg3hOkz4VyPQjnCwiNud6uOpe77k0NOwZbK8MoWIK6LviWrsL/Q45NG0dJiEl3XBmwH3JO2SR0
	T+UkDTlA5t6MhVOB1kSWclbmivgEKwepsj8/x51/Scf+IrYtaqvpza4rifPRF7fMwpeBnmyrra2
	zY/w1bPtP7oAdfzeTNRucJE9IBt9G51F1g==
X-Received: by 2002:a05:7301:fd06:b0:369:f05d:6c5c with SMTP id 5a478bee46e88-3856f549471mr20273704eec.28.1795667189587;
        Wed, 25 Nov 2026 20:26:29 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54542185eec.7.2026.11.25.20.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:26:28 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 3/4] powerpc/ptdump: Show the exec flag of kernel mappings on e500
Date: Thu, 26 Nov 2026 09:56:01 +0530
Message-Id: <4f37adb9ce2d3e2cc485e97f67121b4006a2053b.1795666663.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795666663.git.ritesh.list@gmail.com>
References: <cover.1795666663.git.ritesh.list@gmail.com>
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

On e500, _PAGE_EXEC is made of two bits, _PAGE_BAP_SX and _PAGE_BAP_UX,
and a kernel mapping only has _PAGE_BAP_SX (supervisor bit). The flag
table requires all the bits of the mask to be set to print "X", so
kernel_page_tables never shows a kernel mapping as executable:

w/o this patch:
  0xf1015000-0xf1015fff  0x00000000         4K PTE   r          present  coherent                  accessed

Print "X" when any of the bits is set the same way it is done for
_PAGE_READ and _PAGE_WRITE:

with this patch:
  0xf1015000-0xf1015fff  0x00000000         4K PTE   r      X   present  coherent                  accessed

This only changes what is displayed. ptdump_check_wx() uses pte_exec()
which already tests for either of the bits.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/ptdump/shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index edc69da19b85..e28a41a8b1ac 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -22,9 +22,9 @@ static const struct flag_info flag_array[] = {
 		.clear	= "w",
 	}, {
 		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
+		.val	= 0,
+		.set	= "   ",
+		.clear	= " X ",
 	}, {
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
-- 
2.39.5


