Return-Path: <linuxppc-dev+bounces-23053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A905C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:12:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgX132MRz2yFc;
	Mon, 29 Jun 2026 19:12:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782724321;
	cv=pass; b=WgRAT6TDR4RCaD7o4e1SpiiY5uomLitLaytrIhypRyQ/7eAeFiS2NCCMi+O8pbHp4D0L0Gngx9towaFgW8f2B61UM0NjH7bGfUVbmsgOGTUqUTQZjJXwH/5MG4rjM66VBQCpEupTcEPOnljhJoefqhR/6WFhdIJzy+vqpXzkbYfvocFxkESo3AYfysGyaFJPQkx6JMTswmRfAT6tmFbJofOeGMHdD+LcRDXgr32LYzQzclD5i7SjESaeLikaxq/OA6P9ejn4GecKiOTyVGj0FFUmu/wzVCKEG0U/hYLcYBVHtpGiqRusf2fx331zAIfhw17ZG86Oz2ibCE2ftfNNhw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782724321; c=relaxed/relaxed;
	bh=5T5WebhApI2QU7tVIw9fLdCQvq2s3y9zxINx2el0WJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5llN5GvydX775COV4eOZC4aSmxQ6WnMy1ZaaE/EbBUwG4J8PGLFPq7qDUL3WVIFmMcXNdRd0Y64CzObjivqOyR8x7viS8Oh6j75BSsVVCg+wJ5pwFlF+a/SWmYwjAhsvJc4YDl2Uj5mmrPr4lw7P6K6breulv2wZT9qT+g2cuf5f3RDXNz/gsysF03fqNg5XyMJhZHIc2RlG9k0fkCd0jlYwX7lU7RUN69jZIkGJ65nCOBs6fy0UnKqPPe0jWVg1YewRvFm2QSmmtPPqg4kqeozCrt3m3S/F8aPyLKZ5wCWKeHk4Xh/9FctyVN4RxtwvF6m74VwauH1WRGo1GIGFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMQQARul; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMQQARul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgX02ch7z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:11:59 +1000 (AEST)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1397a4855beso183334c88.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724317; cv=none;
        d=google.com; s=arc-20260327;
        b=FTzY3uz5EyXijgxCOzqt2PMnlNZ0ErctcsTkn2/XUrD9WqSGksBY6rfXfGspxi5dhw
         fba/IIWhRe8GMfiPRigo7OMjtouChiVHO8FJUcCKPfqmVNRQA22rs/2kG/DiG00wpNMQ
         bD4j6e5PA0xKqBjeY74dKK/qwgommDceWlYwbroSFCRfoek4OyI3/Rl4shr7xBEaGmNz
         +ZlkzvqIZClfecwjisRbIX6IX9+lcF5kGr9GgJcsLFDXI5rrKr9C6YN6whu3qWw1vkVT
         OA/Ah0eyhxzTx/2RtUs1TJXC+hc8dQEL6gW4Igu8eRMjTxmgERVeF0c1lHV/E194LtBv
         xzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5T5WebhApI2QU7tVIw9fLdCQvq2s3y9zxINx2el0WJc=;
        fh=gowJEiDURacQzRmg2rJVnuFQwV8Y+WCz0rCAxEqAJWE=;
        b=dyM31Xs33i4gP/PUr2dHTxnMXlahoGrVpydMWplXiigll6mtZpga/dllYkOc1WivBu
         Ef9Cu/TfVwUj3p5BW+PhLMcaxcDnpVbfm8p9heKyJml8js86SH5Q2aLgR5eUmYrDcyg8
         uv4TMtqb2NVRvquy0pJL0w5b+mgqORF51ZVsPOKV/ZOqsyikfY0M/aR7VFVXA3z+qO67
         4euMPlBpPlsTqpxcYnDFN2oYHP0i2B/FqPPn65EsZWSQ65JeMmQM5aYzQ3eMCybDAVSp
         Qpf5v4Ke5CcuMX0bduEsNqXzSHOOigDvaCFdV24YfjI9OIus1oWFYLsR7Yidp6bSxYsl
         UIBw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782724317; x=1783329117; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5T5WebhApI2QU7tVIw9fLdCQvq2s3y9zxINx2el0WJc=;
        b=OMQQARulUYOatZpwCnIIoksokiTrsJLuByt59inW2YvyJwe3ZUpZl/DxdOCWUZY7Ui
         uN5N+On2rmSpJWlR31JU8bVWnHMsoHFpv3/f4Iffjx3UaO1/yZ6ERQXnYT45/gIPRN05
         47RixXVKOs2tsMw049qIyGHj+zqWRD+CcwaFOaBt4TnD0Pc45Iv8CTURRQYiXuiocCCt
         XrLxsPG4u0wX4G+0fFzccp7nUXBG4fS864d3dJORmlBJBOvCU/pAYhYUEBZpnq8RHJJL
         VjkcQYgI7HGBl5E0mTz5yHdIhUBx1cagwrmiq7BoL+6f/5YxXxTloIiteNYTMGGy4Wjr
         3byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724317; x=1783329117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5T5WebhApI2QU7tVIw9fLdCQvq2s3y9zxINx2el0WJc=;
        b=QeMemzrok9zbprEST2/vMG4GkhNdRzGkSdhbWe34zHQz/TRpDemXS/9BTWvr5jor7l
         FpUcvlWqQ0avyheKXovdR+Xaf8ktYIWsreV+3GRNHskdzVPnU7raf9rW+DyGyL7me1t7
         WAbwV2v0ozDofgBYnwxi0HWksO4jF65IU7xZi1khWwjdKVDcIPCmF7bfAdYwJOJ4/Cjt
         v/v8Dt3ErshW4PbBODra3DyneBgyBJdJHSO+WWhSlfCVvZ36JuZZmAkQUAHG9S1r5ZdL
         6+V7Ss2oazWVCNxwdHTOSdyd6LZvQF4eE1cXr/AwVbibOWyYF5sl8truFDJwKRjw114L
         o6Rg==
X-Forwarded-Encrypted: i=1; AHgh+RrRR3+btot+dvVTZ5qEfuK5se4eYlGIVsKaP72KJ7ydZFTjVOeTxzPNd/Yahxv3lTkKmW6f47kloeADRuc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx59TCthzApLyaUow6g0GY86nUpCxcLWyyuac9pwXvisoxy/VcO
	ZuFs6jFnRWwXKmpALz2cE59B6KVN5umsTEaJNXqJ5XNed8OG5Eg5j6752gQ+YcoJPAP4Kle+vh8
	y0t94XXbLNPoWIdGQzxBMv+x2zz8lxqg=
X-Gm-Gg: AfdE7cmaxN8vmulb7DLwYfJ9/wmWkzoKjagar/MjHSjWaiU9G6xZpPCE5SfAe91XCrW
	guzxJizcNmp32or3/Trkdw8uVjLc8HIt9/va/tOqaMTMJ2Vdb5x0i07qykw0nct8nssQguEXZow
	VHeIKKSQblP+Jf1j4HIS3+W4GXS1sij002j2z/LpHfglrDu7vEd1h7YHQ1EAFFsOcwNpAgZkBGc
	DpdQBtwuJ/vPLzbF2VM/V+CnsXFch5oZ07kjXTjMX47X9RnkY6V77TcL4D6APQEcv+zczKUr8bj
	tPiV1ohZU4OrDs3VomFLUBmk2I4YbINLokJOKx0d9KePJLGqEjhG1SD16oUsrHhEpXD/gm7yP50
	x/EsJaWOxV/8B
X-Received: by 2002:a05:7300:e82c:b0:304:5074:83b1 with SMTP id
 5a478bee46e88-30c84d1d771mr6422203eec.6.1782724317312; Mon, 29 Jun 2026
 02:11:57 -0700 (PDT)
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
References: <20260520064630.1785283-1-mkchauras@gmail.com> <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com> <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jun 2026 11:11:44 +0200
X-Gm-Features: AVVi8CdD4UZYMSdVoz4Zj4b5OG2locYG8F0KrVqjoorstpkR9yzH0nWzAh9oltU
Message-ID: <CANiq72mj1P9QykK6vbPK37hZkMLwd7RcgVWEcxxuE=9OL+4bAg@mail.gmail.com>
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, 
	kees@kernel.org, lyude@redhat.com, airlied@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 6:57=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> Sure i'll bisect. Meanwhile i would still like to get this upstream.

It is very early on the cycle -- I would suggest bisecting first.

But it is up to ppc, of course.

Cheers,
Miguel

