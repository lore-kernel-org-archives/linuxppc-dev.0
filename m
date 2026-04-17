Return-Path: <linuxppc-dev+bounces-19834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D93F436B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 15:23:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxzDH6zTpz2xc8;
	Sat, 18 Apr 2026 01:23:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776439407;
	cv=none; b=R+D8qK6a8Z5+/lLR3xVt3waVcH1XaJLCC0kvP9PvlpuxejWicDGefRz1scoiqlxpORXAEozH3MaEKqu/cLgytHsccEYIHvC3RJO1slwYMRcYmMk2ayMEk4rho5x1ZI4wg1d1h93VCP2yxNMOwK5Y74pCrgFKn+cmARtM8pf8ZYLYzEiq8qUtI1zYMM5yGfYQbI1eRfyuS9LuTFEpA+6UTwRIxL+meRYUG3DC7qQ9e7UaICLn6z1mejDA9uq4mLJGCbn8NKaK9Ym5o9BsyisfL048fR0rma65tezYZ1+4byBLoMSkRSn557ImYe588Nq/UPc+/vvUJvayzWEjZ+VWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776439407; c=relaxed/relaxed;
	bh=aMmJ/7DZqgJfjSSozz++1zO4MV2X84JpIm5qryS5QKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WG+Gks78gyW6E1avJRAEBtl7r4jv/ShhIcu/dLH+H/CI9JPiV62MUzaUZPxfVzTcuKzFBT0Ga9Yxn9mQininhPKOShU3j3Gc/s/zsntI+3OnkuiLrz0GtK1Z5nrq8gzduwCT7/BbcQhBMKWi4DVPwfH21CnmF7KT7YENIK5kXUTXqI2ZeNFEvmPKsnvee0moI00WS1Qr+qrno0lOtgGSHRsLsN3nBn+35A0fTulz5S1WxKHMcTXccgUi2dRc2+lY9bwFEPHbUz1g2cxQwBKPMVQEF841NOD484Vh/BH5EnLTYJfXX3R3IEeqxEALnBD7tZkjHwleig9deo1baKDtjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=if5GU3Us; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=if5GU3Us;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxzDG23HFz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2026 01:23:25 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c736261ee8dso321995a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776439403; x=1777044203; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMmJ/7DZqgJfjSSozz++1zO4MV2X84JpIm5qryS5QKk=;
        b=if5GU3Us/U6IYim5kqiEslvmVE+zMaBlLUH20EYKPKFU7V47VIwRwC3T94u+l5H7Yu
         nfsyqPwgdXnhFi7kxDyIGexcv+ILLSsYc54AYZPtWU1Q3qeziVY/ifSTwFmMm3iZ1aTC
         WtluAtPRM5MFjQDWhLpHEFpH7Y6VK/Utfa/Nv0krD6IFk05NIwAwIzAqgkOuo/LTl/qI
         by11DhRP8SnrcqXklIBDBcVqdGPZsbz0knThhG38ZzEHQqneWcji80C2jskljbn/b/Kw
         69rJGW3EIZQLnyD5tLnd0HOd01A3pgTW+tOmVDlezIzRxfHyv1YXycJkuqnrOcJBdf55
         sr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439403; x=1777044203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMmJ/7DZqgJfjSSozz++1zO4MV2X84JpIm5qryS5QKk=;
        b=rRE0K9wvxTPl6/FIFKLiqIdSrwms4pG2TJTX8qOdowLDeYL9C1TYk81l3P1IwSr7bN
         ub/iCJiWogdPxKNWwnRJElqkHarougs9KK683zpBKAeSODDpH8VJVkc/w7TvsBTK4uII
         3KgJbyc+XCA953EGAprYLJSRk2C15L5b/lok8u0o2E2Cr0MjOyDtmXbMHSVTfSVx0GqX
         TPbw7JtVxNyqteK8RlBO4b6DLZkFf3r5rBnD1nfrLN71EbqIB8BQBCEigBXsAYzkT4+n
         lDmZHOQ+pEaUkJnjbsCqVgPo5uv/ksr5SrTmu5vPrJjWRnoX7pTvV/tvvcujKmJ6wWu7
         wJFg==
X-Forwarded-Encrypted: i=1; AFNElJ+6glv86Ifa0hhxq2252b+f5lXpN94K7ZLq7wlbd9R1dMpvt1es5EcOnkTJ4i9rmyBULhGHu+u8sPVdLz0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdP3TGSjw4usSvKKqF3YsTRRMwY5Ub01/96F8NG4BUbVjUG7hX
	eixEJYjeK8BxlAf/4tfL0ckvKjxzvdGOxL9ShIwuE/bfAS092y66u3JP
X-Gm-Gg: AeBDietsNDyphv8ljidU5R0BmyYAOSOfHNI7kooyCwgEk8bMENiWzcBUIiYSd9h38E6
	VBT8o/+4vpKeg9AxEPrct2CBZz9iooWTKD5C68nW0C880J8qdQH4jNGsarMf2VFnO8G6a/hCubH
	yI6u89/iYxnTaRWykhTxg5nRVSYfdikKQAX0LIjcGY7wCOO8iIN+YfaU9W/dxS8qKUx0g2t8h5T
	YBZxzlVHXE8K4FE80Px6C9SJ07C7dQhW5TGw2nv7j8x7LhvkkvKP0xuQIFEYdRQZa2APuc2xkJF
	YqKZBo+y78z/vNjkJyRxGYeCKoOH8trSSoRseyusw9wzESHb6doOBG3IqJgGyIiP7gLpb7HxlVu
	JjUHinEg6wZWxJEYCR4QuDUjOh2ecmfvSLH7xsKx7ZEvUbY54cgkh7Z1ns/cdolykryp/zvWTpq
	sK/9dxRqE42WMlXP0aN8BaRHVGr6iDryPUscr1lwe0Sl0aca8dagl0jVtSkQT+ziPbDVCLFnsT8
	fFIg5m9nfIC62ZDnbH4z2kRZA==
X-Received: by 2002:a05:6300:2788:10b0:39e:f994:f685 with SMTP id adf61e73a8af0-3a08d703732mr2161771637.6.1776439402392;
        Fri, 17 Apr 2026 08:23:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm2384373b3a.31.2026.04.17.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:23:22 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V11 0/4] Rust support for powerpc
Date: Fri, 17 Apr 2026 20:52:49 +0530
Message-ID: <20260417152253.2312961-1-mkchauras@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable experimental rust support for ppc64le and ppc32be. The patch for
ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
merged over it. ppc32 needs some toolchain fixes mentioned in the patch
`rust: Add PowerPC support` and the discussion for that is done here[1].

This has been tested on
- powernv9 hardware
- pseries P11 hardware
- pseries(9, 10) qemu
- powernv(9, 10) qemu
- rustdoc on x86 and powerpc64le
- rusttest on x86 and powerpc64le

We are actively working with our LLVM team to get the target for ppc,
ppc64 and ppc64le in the rust compiler.


[1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
[2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com

Changelog:
V10 -> V11:
- Updated `rust/Makefile`
- Not all libraries are move to `rust/host` directory now. Only
  proc_macro2, quote and syn are moved
- Special handling for pin init is added. Details in commit
- Removed mkdir for `rust/host`, this is now handled by toolchain.
V10: https://lore.kernel.org/all/20260406200149.3727922-1-mkchauras@gmail.com/

V9 -> V10:
- rust/Makefile updated with review comments from Miguel
- Patch 1/4 updated with commit message and subject
V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@gmail.com/

V8 -> V9:
- rust/Makefile updated with a directory instead of abspath
V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@gmail.com/

V7 -> V8:
- rust/Makefile updated to separate host libraries from target
V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@gmail.com/

Changelog:
V6 -> V7:
- Documentation removed as powerpc is still under development
- Added a fix for race condition in rust/Makefile
V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@gmail.com

V5 -> V6:
- Added a missing Tested by from Venkat which got missed since V3
- Support is marked as Maintained instead of experimental
V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com

V4 -> V5:
- Removed a nested ifdef from PPC64 for Little endian toolchain
V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com

V3 -> V4:
- Co-developed-by header added in patch 1
V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com

V2 -> V3:
- Splited HAVE_RUST in 2 lines
- BINDGEN_TARGET_powerpc initialized before assigning the same to
  BINDGEN_TARGET
V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com

V1 -> V2:
- jump label fix for rust has been moved to a separate patch
- PPC32 support has been taken
- rust support has been marked experimental
- target.json dependency has been removed
- HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64


Link Mauve (1):
  rust: Add PowerPC support

Mukesh Kumar Chaurasiya (IBM) (3):
  rust: Fix "multiple candidates for rmeta dependency core" error
  powerpc/jump_label: adjust inline asm to be consistent
  powerpc: Enable Rust for ppc64le

 arch/powerpc/Kconfig                  |  2 ++
 arch/powerpc/Makefile                 |  7 ++++
 arch/powerpc/include/asm/jump_label.h | 23 +++++++------
 rust/Makefile                         | 48 +++++++++++++++++----------
 4 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.53.0


