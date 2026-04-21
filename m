Return-Path: <linuxppc-dev+bounces-19855-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3ADF5A8A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 01:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g044J3s3Fz2yrM;
	Tue, 21 Apr 2026 11:08:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776733728;
	cv=none; b=O1RkYCfzjSwMP/7uE2Xratvs/8VbJIlTNxBC1w+coNM41/xy1mzGlIHWnlADvB21YOTuANtJnARweSAJNrJa2FOwXRvswML5ifnLJG/JKUvIYZVe4nuPV9WmRIwT4qU13xiTaKt907eYHRuTOQ25J35d3WziWOZJvI6btcA5tVEiyTng4kD84GYNQLD6N4vdNXtzr6TV4igZ0dtP3WA/kevOtcoa6EXnIcN96Y/mXiQvc7iE8k2A4M0kpteQ7vYZP1yqUDKNm0wopUJtvtsGfTcIkQRIqTGcD0xeQzbj2fmrAyWjLEr0QszbqHfbXBSYymjcBKClb8ys2F/+JvO9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776733728; c=relaxed/relaxed;
	bh=7H9M3x3bqs69kmxhQDHyqH7H3xQvadbsg0DHK6NrJqE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WB1xYY521yOJoqObIReEG0rk1iKvdwFWfCv+WjORONjThhlUb3vq0NXvpcctpzCuEWD1ZbkockWcTYXCb4/9rWT6wNYFYZvUJrWOKeNBHANktTAd0Z+mD1RTFSYsp+uTSq2YHffENfJjmRUiD8XLkUUdpEFPpNPVs2tKqAkBrOQZhAalZRMe0hicvbFf4uNiiWRnarWVXwXodLcIW+2oKQq4iB5vhOey6B5Uj0LjfCNJgS57lVQmw3MuDsyl4OjhGX7AVOMayjm7E6zLsQVrSSvFjnf8AUWLV7Iqc9qNBzAoCwNzRBtaAzLGpDyOAldRYKLBta7O+vKAz+K7Jz+FIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZVPORbL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZVPORbL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g044G4Y0Vz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 11:08:46 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1221870a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776733724; x=1777338524; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7H9M3x3bqs69kmxhQDHyqH7H3xQvadbsg0DHK6NrJqE=;
        b=JZVPORbLs8ljTLO8J+XEMFAW36SZOZef0F2qSRA/gB+n96Rs7+9BIGq+a9h+viG+ut
         2nmwhltYNKBnmS2Pmmc6p3aPZ6P0UVtmv6utUb1X2PUiaPHucuuPJkvX/Fa8dd5xT81b
         4oxiY4JpKKQEkzJg4Ml/uawaJ1Wr6O3JvInsMhSwQnLPtCazC+GUYwxRnmMuDKr1yeKX
         s9nSvP/Ujubd5k9BIHraTB93N69Kk8Z73GleIKRbaKE9eB/JOj0595NXotJ+1q3F3pdZ
         cmHFeuyahYzSoXanTzMaf063NEGKifnhl6F3KeXPjYmGWvQs05tjHNBWX4qwUZZPtOV2
         CVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776733724; x=1777338524;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H9M3x3bqs69kmxhQDHyqH7H3xQvadbsg0DHK6NrJqE=;
        b=SUOfOdLwojQj22r4PWyzhv2cM0dZ7SgVtnQysmLVkToTSA9ZCDD8tBf1/PUE8cdShA
         H64VocyiIatssFsTPc2m79VXYK9Q4SzVmOM44xYkZqCdo2WqZO7VvV1ftRf8dmH0OQYX
         dWyPFHhAW9xicx82X+apYmOS0Vj/1oY+dhiDOjyNVB91iQ4G76qVy5vjkhnZ0gPk07uo
         v7+WHAMZPtW8euUIRXP5Jv35hcZVpRsPQXHO/Yva34jaD5hzECVCzjcgCpNFwH3gPZWI
         BG79XCri+TVzofWgos1fEeuxTyFfilN9/s/QbxlsghjSV4pBbi7L8i2aUHe7hxbl1BFT
         C4Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/EmTJU5LPH+tDVcokqWh+cXZ6xmqpZWNfxcPfNxTvy1+LiOc4L8Dw5oWPvlXfvbnOwishrLkcXX0jeWrw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyCi13KaFh24h0StOiuUqMawP0o7/fV+EZ9WSEjKIr3odWS+ySZ
	o/nbcilAkijf0qJv1HqOFaT6IQWSK9IZjyFoM1t+wfD6peH8Imrspwg5
X-Gm-Gg: AeBDieuVCk1OHPl3Y+xTpUC9EGECE+P/3/GO4wUiSSzRc6B/ZwAGkWCGUVKo0jqXZB1
	O0zr7jJgX8QrUk12Bsy0vGc3AV1vSwpP1FtYLRaxXamGqDD5FbtJvg4h9kpyOF7J/B2go8Gu1D+
	F5TMxisfe0fwLunVEI0ceb/jIDlR+HFKR1lC3MHASG4ApaoG7GTvFMVRWTjwL87ZOZrmIx/xKxv
	Db9VQVzIAaSyGEtMX5mTSEDJ58pWiACu4elaM4ypmYxTJRP9nHWopvQ4Z70Xpr02gSkkjJV48Jd
	AqMjrPsW+ne7ICHjZAG9CrhzCtY/nS3H0INTEuyjJzsSxjndTQpO3LG6FPwQMbWEgRa3hz64YxO
	+MtJiyrhHybalY+37jDK3A7z7nFMffJTx3UFHJpj72+m7ksKa5AbcYx0fNbt0s00m0pmkBBPW4u
	9s/T6S4ECfMKNggMBoFKC0e3b+MBTefAQq
X-Received: by 2002:a17:902:f78d:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2b5f9d888e8mr155879795ad.0.1776733723724;
        Mon, 20 Apr 2026 18:08:43 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm114740025ad.78.2026.04.20.18.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 18:08:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Haren Myneni <haren@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
In-Reply-To: <20260420132429.128075-1-lgs201920130244@gmail.com>
Date: Tue, 21 Apr 2026 06:34:37 +0530
Message-ID: <fr4pt97e.ritesh.list@gmail.com>
References: <20260420132429.128075-1-lgs201920130244@gmail.com>
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

Guangshuo Li <lgs201920130244@gmail.com> writes:

> papr_hvpipe_dev_create_handle() transfers ownership of src_info with
> retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
> However, retain_and_null_ptr() clears src_info immediately, and the
> function then still dereferences src_info in the subsequent list_add().
>
> Store the transferred pointer in a separate variable and use that for
> the list insertion.
>
> Manually identified during code review.

Thanks. Although the fix for this and bunch of other fixes & cleanups
were already queued up for review in here [1].

[1]: https://lore.kernel.org/all/cover.1775648406.git.ritesh.list@gmail.com/

-ritesh

