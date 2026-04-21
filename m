Return-Path: <linuxppc-dev+bounces-19907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447C2F327D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 17:28:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0TqF6jkMz30Tx;
	Wed, 22 Apr 2026 03:28:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776792537;
	cv=none; b=T3tjx9G52Qmj2ggnEKxAzC8MgM/lB2c8TJ+vwMKk6VnB6ASjkrU7WRbyI1/JEmQKFI5e/krVzpAxTbU+N7CCK9a/F8eP557IxnopLg927RByhMoIJ/aZG0Ao9UIajIoj45UBTFTS97sx6zPjRgs1NyUXJQZ+PWoD52EBiqdGT87wC0NVWzH3WNLB58x43oaSFLFOGgrQ2PCmtptStvXD+yIGbCQhT1qGIw1OtV/BBCohAexezw+DezagvMVDOD8A89o+K8qS7mrDHv50vCp7Tw7DXhnZaXIp7TwukejPlg8zabfkSDGIhdwY73c+kjwxsQ7uH+C4CGzQLDrpgXrO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776792537; c=relaxed/relaxed;
	bh=JNWTKUwnrU4f/1KWLuTJhziy5RXD7g4YKGqyBo+QdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkyHxag6tAUQvMA02mc9+f1WDXd98bJIMQ1R/DVivWQDJAPCmKFSNR3VGgV7igvl8IiydeO0WQzsQt1rQoyWQB46S1yifR2vAyFd9olvo0qLXQFfpHvK8x2TAmZI5R67tqd5A5YmV2kgwSsWrAn54o73GPvX5xvkdJvsZfOjWuYkRjNOL8GEu7MOZt+0bmSQRczsIAwy9llL7zciux40t1NuiqcFZ9XuRiuX3moQcY9Ung9N4YLIWTbSXjkWddar/1EXix96tVXmnZbXmrGlogSA4QJE7QvUOnAZb2b1pklulLLDOiLaPJs2XLi0lhfqPvSWwbYOGeEwQ0+uyFRgJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MVNLmIUC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MVNLmIUC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0TqD2k88z30FR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 03:28:55 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1801570a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792532; x=1777397332; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNWTKUwnrU4f/1KWLuTJhziy5RXD7g4YKGqyBo+QdTo=;
        b=MVNLmIUCtHTIxb78KYQP4XeeznPbnTrPghvF8p2cSrlc+oFIxZg3WrkeRwhRaoWImQ
         UXEM7X25iscpAJPCqH44NYjVuGfTOzB7F6xp4rINOy6nfL/rCFq1xi9w5R8LpzApdBJn
         aCV2qz09LtVFxCE/QRc9OBsIxPDqG0jx3iGBQReDZDTylDKsDJzw2pQbP6CzwJK/661z
         QFOc2Rjd1H/XSn//cJbg6tdOawv6Mr27clsaEqQO/TbcU/IsmlHzJDdZIrWWaMaeM7JE
         /cpR5qGZIl9q21CPvmw1n3EGnjepcpzf8lMFCgYKWh405ewXr9aaLnSIk6D3S1HcKkKc
         FHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792532; x=1777397332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNWTKUwnrU4f/1KWLuTJhziy5RXD7g4YKGqyBo+QdTo=;
        b=ox/Wix4pr9gWkUfYBur9zyKnFBD3BGsU6U/STc/1VixzsDLMyVpY8MUo3WDHzbkpyt
         /Wy8QI+leRVUeW1tmPC1loN1haCGvqQBsq7KVDmtReFS9ewp3DNfmiZux/u/fRnA0U11
         nkkEr0drFIxhB2hZAbrPqIJGWUl/xdPTVc8mVe+odfO8lTAzr08vcCISsL0tdYaS0I9n
         L46oIMf/AFGoYWgugtpo1Z0N4gCiIPIYP0hNCjszbY02fr6IivmAAla1N8U9aQxYRZJO
         NoiPvYLs2H648FF34LFftqw/MIDmXhLbKJS0l922V+p6nTQR+tWH5v8WBoFjmfVdNE8v
         hGLg==
X-Forwarded-Encrypted: i=1; AFNElJ8w13R+RRrAl8t/tLsv1AvPZe+6CFWLHUJa+ySnXeDZd1xNCTf4AbfFcWLOHlhZgrkJHMBg04g4EAiYUDg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfOnZ/5ClWsJ0F9+4YyNPwGUSaIAqbqX54Pdf/g4GRF4iM6wIK
	25Db1NZdOWuHzbHmPf5yM5+LXKZ9kZhC/hvyzsnpOGtl9XDTcmwB59iy
X-Gm-Gg: AeBDietmUgJfE/5NxPO9i4+ZcFgnV/XGKRUPOro0TIhYucAi8tQvc+tUlaQnBwo9m5W
	cXf1gd33UHpbmmXCHy5S9SPM278MDWl2qit/WigDNCpQTnEQnTkeI1A0kQfqkEdiR7Gh9pHpQC7
	F6uffwFIPcPmyecRK+V3+OKMP43HiQTXi24wngaePJQbH2wvtEx9KFPLd8JnxgkMKG8ijkn71m4
	Cqcch+zbo3IErprxyrVlUL45s8sKb3vu/c4WH7sm4QVDkjPYvw/G8IJk6vnwMuRQaLmKOa9rmS4
	64DeQ2slZeNMNFyE8GUlRczISKg5La7qfs2PwEymAijqsZGRbwojJrYldFzHksoj1xY/dJ6Jk2u
	L5QY+fvqcFwbAm5vZWyH0XHOeyljTVCgT1+hgmn6pHasS3LMql4uZS099vCvifp8pogX7lI22kV
	tFYkD0/lKUHhu7Nl2BYzb6XfxoTa6M5SGX1plOZDmTJCbRKP79hJn409aD/wpyjzQLIgwYjPmsW
	aUByZnLbw==
X-Received: by 2002:a05:6a20:734c:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3a08d8a21bdmr21718680637.35.1776792532369;
        Tue, 21 Apr 2026 10:28:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703ddf8sm10961055a12.28.2026.04.21.10.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:28:51 -0700 (PDT)
Date: Tue, 21 Apr 2026 22:58:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, 
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aeezhtH9PCaqfg7r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna>
 <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72n57hMF+0cATWgUiE1ccqJPwMYw_KAu=3PNJdG3=6yoDw@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n57hMF+0cATWgUiE1ccqJPwMYw_KAu=3PNJdG3=6yoDw@mail.gmail.com>

On Tue, Apr 21, 2026 at 06:00:50PM +0200, Miguel Ojeda wrote:
> On Tue, Apr 21, 2026 at 5:54 PM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > The stable support is available on nightly.
> > Refer https://github.com/rust-lang/rust/pull/147996
> 
> That PR was merged for 1.95.0, so it is already available in the
> latest release, no? Or do you mean something else?
> 
> Thanks!
> 
> Cheers,
> Miguel

Hey Miguel,

Yeah that's what i mean. It's available in 1.95.

Regards,
Mukesh

