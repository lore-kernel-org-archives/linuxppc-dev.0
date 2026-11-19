Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDE60A2616
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2V8fzMZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPb47nMz3c3x;
	Thu, 19 Nov 2026 14:40:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059635;
	cv=none; b=Ts1DZb1qKBYpzzqirP8b2sb8u3El/EvEuTy3cbICtqNvwVPlSLYuVf6k3ZQqN5GqXrrw+LKArTzDz4Bbcg1P+amoLYLGzwNu19XcH5DypMl0ZrezY9kWU2fhS8CGmyy6HQh5lHu/Ezq5XS3lJTm1A/n3iLr2gOFwJlvDnmvBgFoBX70vIp7uq245c0njWrod0tGqtC+mwJ58Tt38CuRod8hUrLfH/QkKwI4L4Kv5bCDjoA5meNpl4oBwjV0x61jU1cKHeE85Ec8vfWdrhCuIXmhTG64YooMx+JZ6hjNQRWe8ID6zqfGbhnJUoWHhqupHJUhUVXowDxEqfkND+Rd8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059635; c=relaxed/relaxed;
	bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5JdYaLjYYsp1LmVqO7OZoijjuOuklpt+LawtLdc5qbDz1W+o9BaQa8tuqXUvFI7Q/WNvnBUFwR1AZTXV1Wyjuqv94QOy51WQzJv8EYQDxh5/Dl8dn/WbP3wdUPaK8NHBAHnuMs3IyEBUbSBvkT3Ra4GkH5mCBcxGtORvMZct5SB1QgNxdi78gTAPVju5sXeVgFdYCuojS5bBqpPm46t9Nxz8qZIm4tAEU/FXuKcgCWkkcxf++DZmpeoPx1bGATbTc06VV7vKj4VPE0x0MB0AWt6RfiXLcjqL+JxZXvyRcBRf5XNPTcBZ59huiGzxfrINtbv9vh1TR/lmhkwgvX+6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2V8fzMZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2V8fzMZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPZ6Dr4z2yVT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:34 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-372bdb942dbso2393408eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059633; x=1795664433; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
        b=H2V8fzMZh3Vl+kuGg+OYwIAsqsZ4uEB0272ohIIaSqZeYsHvXuzXq5BeDSUXxwqATV
         bqT+5qy9IEOHUyF2B4L6hF9I04cTfO3Dk827A0/4m5oQGT5wojs6BP3DWRRBskY6sGzY
         wEujUX5s1/oSMAdOJSQVbTdvdXIDfw+LlYjIMcsTpKHAE4rxgH+Nbv7DggiMYDFG6ZoS
         knRUMhj3iINe4b5jpO0vcjg9cem/8MjP4y0JnLUTpS1+wIdyhSLYc6kycJ6WpsS60Fyn
         vi04sXsJm8+UWxlM3wMtYTlNJ8tqSXKiLZjyLx+5nl/IduRu6YAvvq5h+ebFcMMG+SWW
         5npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059633; x=1795664433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
        b=TrQ+/nIjyyTHqwZXC2ZMt5hXBKA+jb2rfbEwevmuWVBF1H1NPl5d03hbXgraceSKI4
         gmxbkbOYRtxVbU4n4my4JOCGzfgDCiTQXSZImHtFy0vND7Red5nyBTzZFx13X95CIW9P
         oHfUNFyA3WxXo4qOHx2H46UeH0Gz1x8QW/UG2HuwhBc8uzFxJNnRkDY7h/rpKPB8P+55
         6TZCtBad9kenE2jSgFdnDe6KYuE7aGSuZMiup1Y5ILAXkK9d7kNZTAvyKj5+c9BQHdc3
         iXJcq6wWkXHAzeFH7cHYvxGOaXJdGljbrj3VQjFPqn+PqT6HOBIZu3N376c0wdG32x2X
         9oyg==
X-Gm-Message-State: APuU4Z/+soRufddUDstzcDZv3Un8yHoT2pTXBvbLUazsiyI3IMV+FTNU
	8rQsA1r2R0+/0qsJ2eQA3MwxGBQMm+1bIaGbJqO7y3UHzCR84iT98Hgj9MR2lQ==
X-Gm-Gg: AZFdTZcTrhokRzGgCMxWMJfOijF6/NxYaxZcQh0ZjaBBhNCby8CMN4Os8Mnd8CL1cpk
	DO+tkCMWF2bN8clu4mNxaFNcvL6m0OwlbUH+0lOcU5R2z4ZYu+y28IykKtQmBFNWYdw3/FK3zKc
	Y8M8TsDtcQBPX2NDXDckkE67At2LKgi3S+sWclu+GWuQ/8Wi9kZ/5AnZTkrs4nb7P/r+8YlHNIb
	VabH/9wsXI1Y1bDlgZsP5QWFpVenDtuzFpxT49uWkdZGkOESBOw1JkJExfePqkmK+d2+Nwcq4pi
	QRRBZiscVIu7q8O/kTN0G+fe+wfzxcvMWnyyvBo9Fj8qEuLF0PdTENo/PeC85azobn6NC0Mk/Xc
	1wZZLiScp+X+6ppf+F83QmySu+KZ9e2xsm93PDXS0RjWgWn65oJf9wP+kEbY44tFDkjpbmkt7OM
	2DC1CfKfbbK5ModVGxgmllmu2zvbQxmGZSQ5XX/bl/QVQsoFA8XnCRin0REMLtzIRYHHMGAapw4
	GBVvVSU8z7BsP9h+scp9oL8sYKGvHGmFD5mlyFJYxVIHXgswPay3egrsFKwdJFURUhxYRfgfi7A
	uqGP7WWNB1lg+F/3ct4Upl4yPn1mmi2njA==
X-Received: by 2002:a05:7300:ff43:b0:369:5583:bf4c with SMTP id 5a478bee46e88-382820de610mr3957455eec.28.1795059633028;
        Wed, 18 Nov 2026 19:40:33 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:32 -0800 (PST)
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
Subject: [PATCHv2 16/18] powerpc/pseries: Enable context analysis
Date: Thu, 19 Nov 2026 09:09:11 +0530
Message-Id: <57dd6459820b7c92907123a67659c8fb6a3e7fa0.1795058683.git.ritesh.list@gmail.com>
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

pseries objects now build with Clang context analysis enabled.
Turn it on for the directory.

This checks that each lock taken in this code is dropped on every path.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 3ced289a675b..d5f9beec33cc 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CONTEXT_ANALYSIS			:= y
+
 ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
-- 
2.39.5


