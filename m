Return-Path: <linuxppc-dev+bounces-25873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B206EC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 16:26:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM7070Tlsz2ypW;
	Sat, 15 Aug 2026 02:26:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786724790;
	cv=none; b=l7bEPOTvUolUV8aWrY1GYm/QTASNOmfSYdgK2rpp3lAPzzLvu2SgGsz2WI3HGfHmHvy99x8P5PtCricGQeIXWlNfs+c+jF02x4d8C8koSp1ZRWPGtBfYN/8plHq1BKJwBylR7t3O0mw+ItJfNJYANbllEp1GKZb9B9KUuGi/NN3OPsOWnv1dWA3AwJXsYpbrAAp3/disr1YsqI+MMjFZhbgu0l+D0yKm7oqXdcpNC87zfflwrVjvGtylZTb+3wdKZCEre9MEtHNZAF4rgpo8EW275I0n+xCzduR2dWUBmfa/VnSBXkJ9wXD4mnP81NNGwaK9ITNUFfWjVSoIDZBogg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786724790; c=relaxed/relaxed;
	bh=y8L9gAWKHdFbBHmHBP3V1LTHp9D98CyhXqgwBwp5N0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OC5t60pHcfi7vPWhqB/PMUpjeUu/81/yjgE6sbJ5Irs4JFymZGReCJ1qJRi1CoJqcCyI00hhmZVfyZlx+YkCf/ZGhdugOr34AdZ5Zrbz2SCLl56uTqXQ8c/peXmjeOkrPgtue1UUCy+GZ7NA0RlAgHL5LlbULdxpRW2KiGcAUWqe8mCQlOkRq8UxXOnY8FwjSmEabkfcaJZl5dv5ylQct/hxdLgk92fZYQOY+kQv3dx9MWr3d2qjgT6/4KnI6mNmj2PDUMz2vR1CtdaO1oxOCuI/rBgamgqcc+QI11/qc+OvRpY9bEzTDIV+d2+l2TFd0ZDWsDxyeFsUA27we38Twg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hj3+rdGJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hj3+rdGJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM7052Gk1z2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 02:26:27 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-848743155bcso444685b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786724785; x=1787329585; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8L9gAWKHdFbBHmHBP3V1LTHp9D98CyhXqgwBwp5N0U=;
        b=hj3+rdGJVTnNviAW8SKbfFeNU8BVxEA2YCh7Ny61DHS3OA2lPSQ20nSehYiHCQqkkf
         h5CkgsEwYjk5kQx8g3U8xQZXemijHQYTGDRMTk2jc8Mp4FyG/D5x5Ro6lAP7fNGcwpGf
         TltBjaNyYJZC3CExo0ydtqlHvVpmhDw2fm7sG9hWF4tDU4djrudkKLmZw7YYJ6wXtoyI
         F1DHhGxmIS9xYjsbWdYw22xxxNrdACYU3H5GAxYo13RAIewJeROB+1+F05WlY0HjdxYu
         Ue8ru82y645/qv8pkd1p35nPpPmu2WGedVHHa6YMIBLnBO11qA/EEslciIFuyLO80DYz
         D35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786724785; x=1787329585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8L9gAWKHdFbBHmHBP3V1LTHp9D98CyhXqgwBwp5N0U=;
        b=Sxheo97bA4du7yLoM0udlYLut4EKYvxxUH5GEByL2zDnmZk2oSC0riq83w4N1msRlX
         P/DSWnEXkNJNNI6Ct/LtuLiZZ/GG3Tt9jDUHOjR9/Uz5vta7pCeiPzs6VAcKw84mRQqK
         z9T1lo0qAU/0n+8ndOPPE5jJr/YUI3jo6rG7lALqHh4ueKQsEQbklgbZaPtSlsXZNRTk
         ItZ5KvBMjss7ulAFEDU/mqFRtJTtVfPx80BBNjm0Xhjs3Ue1mUj6OgUATvnYrWI1Ioxc
         543+bIY/CoD+aSg5PtkLcIHTlMK1V+k8SV7lJT5+DLoqIEMYZ7mXYqHw7/qbBiJjpam0
         87mA==
X-Gm-Message-State: AOJu0YwIN1/JRMZhD5m/GIhtGaUYisN6NXFMB/1OQ7YaaTjXHRA/HYo5
	dVQh62EgK2gJlNEDWNT/yj6XqBLGQ+KCwDKSTpCJ7rhKQHqXUw8bgDlR
X-Gm-Gg: AR+sD13plq4zZF25GLJfTspuaXBtc6jqCI7p24+rLK0zakZI9mQUP7gSGCKG2h1qlsX
	z4ptThX846AiPl8fT5KAAJ++7T/8CW0OXaxzwA7rGO/nsKBDO+mbKQjJakLFMXucuxt81ma8R7t
	ztd+RrS2rUYFW3WwW+MlsQ0XOaOI9aLSiUdUdqUP4bDq9co5eQ/ZqgPZq4eWIuzZf+O9RFOHjH7
	J/8TfnJSeRR612SuigENURg2NaeBuaPZLj2VCIfEKlAsenlo/bByztMc6GNxVtioSPd++MQ+gzV
	tdPdD7ypMyONKs9JAK+6vJLI8y7SAI++x0TJXLXXeRnwIuC+iIExqSc2oxZIIVne5BYxZ0/KPVi
	1nUxr7V3qlc+Np2XDKOybd2bKiBEgPDcGkz7SV7x62vj/TJsR5Wt+os5R2iTZfM4YgN5WPR2D9I
	uX2IHx520HG/gqJ+gpQfo2MC6vrw27M3yobOgQVwriajE7ZZlGCgJ7FfyRbaA=
X-Received: by 2002:a05:6a00:1c9e:b0:845:ba94:a56 with SMTP id d2e1a72fcca58-84fddfbf1cbmr7727022b3a.5.1786724784867;
        Fri, 14 Aug 2026 09:26:24 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a1fd06sm854391a12.17.2026.08.14.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:26:24 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Paul Mackerras <paulus@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org,
	Zhenhao Wan <whi4ed0g@gmail.com>
Subject: Re: [PATCH 0/3] powerpc/spufs: fix a refcount, a type confusion and a coredump underflow
Date: Sat, 15 Aug 2026 00:25:38 +0800
Message-Id: <20260814162538.669042-1-whi4ed0g@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
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

Follow-up on testing: this series now builds cleanly with no new
warnings on powerpc cell_defconfig (clang 17, LLVM=1) -- the two
affected objects,

  arch/powerpc/platforms/cell/spufs/inode.o
  arch/powerpc/platforms/cell/spufs/file.o

compile without error. It is still untested at runtime, as I do not
have Cell/PS3 hardware.

Apologies for the "not build-tested" note in the cover letter; that
was accurate at submission time and has since been addressed.

Thanks,
Zhenhao

