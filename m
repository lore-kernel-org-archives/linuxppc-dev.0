Return-Path: <linuxppc-dev+bounces-16769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48110EA3F2E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:18:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9GF94VK2z30MY;
	Tue, 10 Feb 2026 20:18:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1229" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770715085;
	cv=pass; b=ZPg1axXZN1pEPkmebyOgkmEUvMVwstpdkSPLp51qLMzyEExdPpUx8PSfhiVoSMIvoZG4LJhOAOGrVjvcMg4mAs3c5p1mBai4P1sf+nUpyCIK6MadBOD+GJi2cxtmqIHIkeOP5yBGVpfZ67p9xa5A+Vt/lFK9tHlt5gLZ+wx03Rvzgs21oBfA3Mspa4CTEYYgvafq+kUpLNTQTHE7sJVQPc8fB1g/RzuJCH1999foETBw5af8pcLLDIOnXYquM1C4UwGypKBK9wZz5inuMgRJW3a50VbkaGvwPZ/9PKfEZQU+mZP54jgwZXzdR2uizu+LXl/uEllhXEoulowpkKsTTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770715085; c=relaxed/relaxed;
	bh=Bjmbq5mCbC4T5DcDtYejLhUrsUYcDi/tzNdDS8UWm6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCIHOqjJDDfM7ZlcN9kmbcbkvLjyeH4ou41mHRf2vzStwQGGbkQMG0BeYjgO7vkq6S7UxrXc4tCXvjoRo3vBH+o1vm8hJFpC5PY1c5YA7PueQbZX0Ntvzv77w7nERYjzuPolZsEX21F6236CPDQj596ICOXq4ra1REWCx2Wbt2/Z9ubjb9q7vcV+WvY5ikK0pWiPgIaR7cup6JJNZc4qEmyvOiMeovTaiBiThLKhsgD8UGCKRcJEcn0ZxoE5bQAbi/xcReREBGHoDvXdQAyvGGKU70a+K8ttRbVDzE1Ksj3F3lAatKImThcZUyRkjsciXo+1vJFePr5RyQZj9CJ/5A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LwU4N0MP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LwU4N0MP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9GF82Pl9z30M6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2026 20:18:03 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-124a2dc92dbso328351c88.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2026 01:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770715081; cv=none;
        d=google.com; s=arc-20240605;
        b=ONbHLjKln4dl+k47/ochOCCDrRH8tD3piuG9r967ESWDg8oypZRJcIXJnofTwMEqHn
         EO5ysWa4WyeD5tsMMfep72Qcw0xNE8cj4uai54FfIkP6azK7gPWc8/QGwl9HUcNcF6xX
         Uq/iPHbBXBORXRNi9gEwIh5F1EP/iHNhoslOl2YixjXeK6F74/cX6qfW7ino43rIK3f5
         kDBno6mtVn6F0DTqP7fvdqLfzIWh7dy9Mfmqmrhs9WLN+0uCaf3AwlWIeA6X2jyXTBBb
         LjklJAKc/mTjELiFi9P/wkEIppwjTHPgdiSVXM/x3VjUpkaJojjf44GB7vp2XDcw6sIH
         zdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bjmbq5mCbC4T5DcDtYejLhUrsUYcDi/tzNdDS8UWm6I=;
        fh=lVkIX+BmDq12HMRE7cRittZhau3e1XrMduqzQOsf1YY=;
        b=DWVYOwmlktlq7uLe4CdjF8XAT+Wb3C6tvtnogcAYjPz6fAA/wTtLXpGOj9kAZcxBAS
         GB4aW58qOoEZDsp/ytgKvUZWcoa6M13Qqq9b/7GRa8qMvtuFMfLThQQamjZ1ScH8sjda
         s/N3P3nSs42GqHMhEcEDqg5MluCofMdG5E1vEw09XULjkFAhkbx2KN/8icaMLurhCoKC
         N6DMecZtSf7G4y1ML+RVe1V3RspxZT5RlnmqzyIkkKtNc2x1X/XaPLWbegQyxGbd1VNJ
         e2l3buCWVnJJ6olzBcw7w67ovqWA9QZa5hQeHXbFagSRLFeh4hJsb58X5udgKcyjU0hE
         Qlqw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770715081; x=1771319881; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bjmbq5mCbC4T5DcDtYejLhUrsUYcDi/tzNdDS8UWm6I=;
        b=LwU4N0MPNPQ0ggRsJE+vmVlKHnbHJBpesQfkLyLDbYO4aCMXMn0ZIk9qnFNoGAn0rn
         yvs46O7hVI3Jix5UczvGUn7z4d/F8nebaYzHUB5AgycO/CGZF9+2UJluuoawF/3LsWKT
         9nzlxLrc51s3MxMKRSnLbvfB6ur68ZjvAyNWyHH+6YehEDnifwam1TRvNBZ2H6sapItF
         JmrNFKv3qkdh5fs7YZssqnuCs94MkS89fbRn6LGaeHKDR8F32/dAOkWajODRHStuH7ak
         7pSrGBURcIUljM4wiNz78c9N02diooOw7oAN85K6qYYAIBgg+YAMSgVjL4CFFo/etdcN
         m7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770715081; x=1771319881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bjmbq5mCbC4T5DcDtYejLhUrsUYcDi/tzNdDS8UWm6I=;
        b=JPJiWWgnu7ZXLCdP9DhkacoV/ks8sl5iqUxtabUYh6O24iupg8PSZB6QZjDvCKCr0s
         RMhO+DqvpKcBjeDbV+wozYsm5I9MtWaVmzaU1KStlAdQKDRIZyN4a22by8GZE3XJ6r8S
         h9kbbmnP5rTz1qZe1QVpgl3PmZY3fA2uhRf6YfeinreawAWpA+LIsi7uZ/BvElcn6WFu
         Oq+vY9I3yZlppPGJ84J9MLZEgJIF0DgcnCF7AfNRrHNQtdox4aTZTIVn5ItiYD00syXc
         GDB0MwQwRerMlRNp5k7bYe9qxrvRrkc3PNr1C3LrepN8nQH+rZkkEV4Pupwuv4ASAb5q
         iS4A==
X-Forwarded-Encrypted: i=1; AJvYcCUzDQVC+ucomgksGJQ6j44yaS07/X67HPLpuUK3ngXhb96bQRNYyA+d5lkz7BW8huK+Wh0NWUv+Oo2BAB4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnFYqsGaTGXvSkgAjZ668jd1S0Jsq8mRsOOXLoowLHocEaM96B
	tKUHMGAxtBwCuFtR5V0j0YTu22GWB5vdavjuiZUxshvz1bUVdrH2r8ej1Y6ZQ/Uq4wTKfNrRbf9
	0OfbWdvARuSX9JaRjfqR9TzbFSGz7TvM=
X-Gm-Gg: AZuq6aKN9/pFyw1Mtj4Up4gtWlJd3+NgHMI0bhoQXuZGJZw9ogsyV57kqrQYNCfUrs3
	+ZBvpMg0bV6dTkyH7KJeb7FciJpsqIGZuPqjw9ZkE3bMc6ZhUloS3AyZxaYJPGmvoNbpvLsnXpT
	JrL+K1tMC9KgpDalel9kDZdZbslmKrq04SwGIsaMBroFZd1ic0DIWibS4oHVIGBhjVJUE+LFC2S
	4jpjZEoLnrRXXoQRvwaH6JARwUHm1xUTy048aZTYFH4tiFvAZ7M1P17Md3PU3huJJvNauAPfXxs
	Ose+qRcoRwlzaYe3cMg8DOoEPHBeluRa+IMdT2mzgaEyrn2mr8u4lfZMJTCJkoK1jo2txTtPEFi
	yUsFTtwG60/xC9EsU7jM55bTN
X-Received: by 2002:a05:7022:a92:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-1272494f67dmr219752c88.7.1770715080987; Tue, 10 Feb 2026
 01:18:00 -0800 (PST)
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
References: <20260209105456.1551677-1-mkchauras@gmail.com> <20260209105456.1551677-3-mkchauras@gmail.com>
 <CANiq72nqH=H4a_Yo17KPmku5pPRMVRBADgj8j+=TcR=3r0vOdQ@mail.gmail.com>
 <b07f1bc6-c63e-4b97-95d6-c639186a89dd@kernel.org> <CANiq72nkVmE_91yz82e1cRuJK8F9SPP5GpD1mT=NYLBbRTL8OQ@mail.gmail.com>
 <aYrBU52OBCgR-chY@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aYrBU52OBCgR-chY@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Feb 2026 10:17:48 +0100
X-Gm-Features: AZwV_QjkDsbIYoiftCtGkfNW-taiiY4Gt3cD7LsM0k76oSccc34AX2xXNP97awU
Message-ID: <CANiq72now=ymUnmqV6ckaynKgSW7xB_3QpWpFmiG8Hvm_yV--Q@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] rust: Add PowerPC support
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linkmauve@linkmauve.fr, ojeda@kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, corbet@lwn.net, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 6:27=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> Sure, i'll try to join the call and bring this up.

Thanks! Added you to the call.

Any of the weeks we do it should be fine, but if the time zone is bad,
please let me know.

Cheers,
Miguel

