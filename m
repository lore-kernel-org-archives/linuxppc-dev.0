Return-Path: <linuxppc-dev+bounces-21211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA97CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2Cw5dg6z2xnK;
	Wed, 20 May 2026 16:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259660;
	cv=none; b=FHrMIwe3tC8iMFnLP7usdqlx3lAdSnGS5Ho8+EpdAKuUaEf/S4pxMZ/4L23Ce78d/S8TfnIDfnAtUFBIcVAjXhENI5YaAGpi8UGID60nlaOrzBt7vTToadXTTtu2InrjPswBLpZVmS5VAuoqzG2wA+3WETt82eg2LTGqIK4klA/d0VjASQIs2L4TGKhMljhep/oTiEYOaWBMt5eaO53LXBHl+DG4YNFnNbOGMgw2VTfNxoHt8bnG6iCEKco8TvwJTOpkoP6fbfSVAjGNCn6ubCVnmBJle7fhZbLV2GgdfO6/LXaWT3O+o85erc+LRrrtmpSTZighDuFEqFswCnosrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259660; c=relaxed/relaxed;
	bh=yAXxYbsc5I9eqWTeSv6j9oBSm3zo+5SB8Z+tNOyX718=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbK91bak2vTNZO/q5JWV/CNSI1+4H7EMYIDwBTxgKU5n86o4WOR8GCMmNIKpH5ZoD0tSS1suG+FwQtKwQp0J5aCte0w7ybtDMI9JeyGE1m0Kiz4TV32R0Lfrf6cwUbGmBebUJhKgIye9dha8JxMr8njnnV6W1FJHW4tmQ1QNYZ8CGbKpW1Y2ZIYzRV0V5ToRLwZzkZj7GlanOs0E27hOSiDROJCwpC9FugjlzPamOKeqRsW2Bn0Dn5iEBRtUDwNJbCETALsLiu11a7PFZ35BunUsDw7/W7RwdBfYJpoAb9OOx0k4seGWalfnzFJbmiKYH9R2mxgA+zKrmGvaz0HjoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bJfUn0kT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bJfUn0kT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2Cw131Dz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:47:40 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so2810375a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259658; x=1779864458; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAXxYbsc5I9eqWTeSv6j9oBSm3zo+5SB8Z+tNOyX718=;
        b=bJfUn0kToLsPn+2zCf8YTlK1YYP8HRoJa2A+i8+a0nD6xUx4jouZRwiFBHtXwaux/n
         DMilD904FPz+qOBkWUOdryVz+VxjUIF5YlAKh/zoCkiyjj/eOUeoXoX0Fd4wMS7LwKwU
         rMbJd7uBeR2r/HX6m67Z0DYZFultdKTirM5Zwdz5/DgyEVHRUyAMsDQPNfoRCR6KJTXA
         kXGRmjPW3VMXw9O/yXfRKYVSRUJo5+WqpGG+INJPX81Ave6nTDog4v3EGYVw9Bl+fOoo
         5t9pwfhStUqmUIi1Fy7OJWEhg7nJpAHY3+z5n2DjwLRekekaAacmFG9S/VHEKoQBbrUr
         3ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259658; x=1779864458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yAXxYbsc5I9eqWTeSv6j9oBSm3zo+5SB8Z+tNOyX718=;
        b=dhpuSUc7aHd5ZbcKx+zprz4BJXatyPtrPd+FCMx8s9UKSxffdJSHZtkLO/J2m6UOFZ
         ORYAGWN8uokkOc7ns+cDm8QLfaWn6+7HsscAEXaX+La0YjlQjXE7wYbM3iqrfmoh/c8g
         QNcn1O0xiOWiK8xOF3eBobAQ+MOBU7wYR68JFS2z+Ea5lj5yleEBUAp76EubjcQuU1dA
         bxlMBowd466EuB8tdrrpRq68u0MvYa20+i7VQUc4T/tXdTu2kkI3jXBxB54/5DHch1Y3
         XKDPz0tM/bc9MO1MotmO+Sv8Ga16pkvSqE1+CT22rtlYI/zmbLwcIKAxlAMWrsE/dHeT
         3VYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+i2ozNoIrInLLXuVLgiaUwytnebMH9PFsLk9e/MuPDVtGawiQ7VGiQ0cNXTGqPTJYrOPg0TjV0+/u6Ptk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0Hk+FZMeavriGIN2+JYj6v+dgfG1lCfxl17BiEwYkHTknytgu
	M6oZkd5gbhj9EzYktFTPLVMqn9JF0JznldYk/J+MWpI1Lv8D28UO4QhR
X-Gm-Gg: Acq92OFHiwEheUTB82utJnj2Aepdc8lIgHOkRa4yI0bMIXpQyT0+NJyvrhcbYZZV2P4
	UqEBboH1uGleYAVQpCM/gl8O6c0888F1Lx62zFDtMAaYvKU2yspA9nr6G48ytXuHMhlwGWBW0EQ
	Dloo5YZ494NFFTHRhWB8QE/fHO4nvukVJT/ZBPkKusWNJbx8KzNsFApRazBTYFZcJ2wAG9OFPLX
	368sS9G+CDVZXm1G4Y+BAGNSsKfcKq0EoAcDPmgJ36c/fp+QbWoEAQh30wDQQgHcOpouZ0QqR2j
	+WYcF7+Mu/lMJkJk46Xu/5epX3ZiTy35pVnILtVfPvLO+mgzB5W1p4AsuJficHRGo7xCyb1g8DG
	ET7AZjljDRd80j49zGkTKt1aQioOyNwsvfCNbVAw8PmjKO5UkIraG7QTnB94tEy05l2RcN/oq+h
	03eRM0mQMGE7vaCXDRuoN9Joy0g5QJo6QztQibTEKpATtMhfgf0dUvxSSViUxlbm6f1dlJ1wdGK
	7TROm/ONGgIf6g=
X-Received: by 2002:a17:90b:5688:b0:369:a9e8:dbf5 with SMTP id 98e67ed59e1d1-369a9e8dc51mr13102353a91.3.1779259658100;
        Tue, 19 May 2026 23:47:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:47:37 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	daniel.almeida@collabora.com,
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Date: Wed, 20 May 2026 12:16:26 +0530
Message-ID: <20260520064630.1785283-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520064630.1785283-1-mkchauras@gmail.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
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

Minimum `rustc` version required for powerpc is 1.95 as some critical
features required for compiling rust code for kernel are not there.

For example Stable inline asm support which got merged in 1.95.

Link: https://github.com/rust-lang/rust/pull/147996
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 scripts/min-tool-version.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index b96ec2d379b6..406895621511 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,11 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.85.0
+	if [ "$ARCH" = powerpc ]; then
+		echo 1.95.0
+	else
+		echo 1.85.0
+	fi
 	;;
 bindgen)
 	echo 0.71.1
-- 
2.54.0


