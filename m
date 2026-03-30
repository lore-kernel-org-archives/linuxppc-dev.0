Return-Path: <linuxppc-dev+bounces-19006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66172FB3CE8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 09:25:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkm7s0tmSz2xpt;
	Mon, 30 Mar 2026 20:25:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774862745;
	cv=none; b=kDSK0bGZSyKiQGRWpeU2OcpMrmJx8Kc+drBBfa+As9NSHo11BwkmJgsBFu2C8gYTJaJ1yf9W2U8BCHRjTg1LLzIlNMCJ1kQFa1n0GW9FPxh5IN+D1zED6pR70i1MVvKKYNdRpeB1fLBd0LTpIl0DYxD5sV71RlGYky9LKQarSZ9iU/MAz5CFVix9sJd2DlAscJtC9oVWaQCadffc+AqZ61c6Tjfz00WHWPySk92CTLNuXQDr3ETwmNJ8vfy6inchUEAz6QEyDvocicOhSuA4zZZcqySNmur8CGywFgSpJ0fHaGTzBxOP2nc6bPqhlezixtjFKXH1d6BpkZs9x7URtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774862745; c=relaxed/relaxed;
	bh=B8stYRZwzqp0V8QAn071tcL8Pp7ef3Yw9Bh6FKgFO5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuLOGAiUEm2WU34GfZmy0vUzPkoTf367FoiW2O9X3VnWNwD1GsB9nAbzMdceIYBWcOhtvFAp8zIhNNgiduozs8RcxqPi87lraAiJzTrcxe56OEXOBOisLPQ43siVN3Kg/BgSAxf2jL5jc8j+mqHHrF/aHot9SsYsjFKamP8spHAgrJa3O4oKWLepOS8XmiODlnB/gcX9ft7KFurhBeDozP1OpgeuLhjoK0j4fCrrCwkdcvjaN6Bv9iS12WAvx9bwQDpl6TZFJPd6pyp2xq7KzwtEPX6LiYq2+6F05Crpm15AcYNvQXS33Gh5tZ8SW9H63mszUllYWvvxzWuY2Oct+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OtnbVXvD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OtnbVXvD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkm7r2VP9z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 20:25:44 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so1216791a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862742; x=1775467542; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8stYRZwzqp0V8QAn071tcL8Pp7ef3Yw9Bh6FKgFO5Q=;
        b=OtnbVXvDkp4AJbr9WRqoPzSRYtF7Z0/OsKq4wkZ3pN+SOeKkRff9LP7xCa5l7JKmht
         Xw0qvEmJp8S269+WKndbXi9Hn83ki4pcqPufyp0xGwbtvFTJj7nM8H9t78pJh/IQtLYp
         y3HWDJNHMZqN82FbU3ebpybQqCJMjUdhBf2uqPwtGyiOGfNv7ZMzrV2uSOMqOq/KtA/o
         +4mjTXQKhvzEOHJ/uW8GtdHyViuWrYe70xaJdqmQq4danNoywXqhHfvzjV1+k8Nr/4zp
         uEcGazp8w0AsRQCzpkUUkSH8LVS/h2lB6g51x8DtPJFHJiE5qso1327tFpbhyG1Kx0Ry
         QYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862742; x=1775467542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8stYRZwzqp0V8QAn071tcL8Pp7ef3Yw9Bh6FKgFO5Q=;
        b=HAcnE1MhwGUVdaMI05kTkirisBb3O3OjO1U/kM9GsiC+PgGTustKv9AQH5hkw7FlSc
         C4AiTc9W49oLrYvyK1eEQ92JbGLB0Fykra5DQqwG1jiJTYEeO5C0oqAy3DC67qy7seCr
         WvEEkyx7NDQFMtkhFpvTaoSvhefyy6Tv5kj+otcCwoommKNAta4vIj5tBmDjnCA8OslX
         jJxgH26FgVFD9X72T4OzjKCXRmKt/xqmYBW3vn6T372q+R76RR0lyBo9N7miFpWW8BR0
         gdnthrPYp1l39pzjcCJ7pU9TI/raeVgKZcofU7YGTYDFXACLMwGsalQiuvpHGZac9CvI
         hJjw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Y5mUz/z2pDUR1HTAXvV63zsh0JcnxqzV6t7RoAMe/Tj+AZaUkZiTjueHRxWJJ94C5U4qY5Wgbgeqhzc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpMD0RU9PZ8zMZ0/uqI69uSNx7Vx9BKT1RI9j7RtBtk3Cx64to
	jGyhPGJjyIft4ke9c7aJVL/TFSlJHR+RYkC9ZLjvKsIuyV9APK21/Kok
X-Gm-Gg: ATEYQzzHx5YkOr5/Vjb+pdDalael0vOX8gqcta6RHNFJEkCiRszfHtvj5rxEM4vmqDj
	jTE8wPkfJWy+5F27z2vZoyzpx9Nb6VlVGm8cGV70lOtQ8eZ+kBOEyy59hCw7UHHnugTLumY6OvI
	Eda8wcVBwO+IyqzPOAi0nKn8OxQBUbtRqdf60mT3SWsoNMPoM9iQGQmQ9VeOPFwPXKdIKiG/HJW
	Ey27KDc34DfjhZQdJtoHvQGu38zYL0js/0CEbh2KjXqxU3kxXxSsRn+j1NtbDYT4wbYOVU2+7ir
	/VR6LA/FgCV1SzvN9E19KT3JMWSyfJOFgrPqQE75W8GpCZ0glCPwphEf8TQhasaiTdJs+3sb5fG
	FuucO1XqMv0w+NMOjVgIO1lOPbft9uSxWOWgxGCPz3jTEjP4HFkHyIsTX8dfKGHKtEDfJxRmQN2
	SHLatrLaEvDFDnBXENieEBnrY8Bcb23qmlyy/+OUjZeXp8PKZYfmEYL0RdAKapcYbIoXc=
X-Received: by 2002:a17:90b:3d81:b0:35b:952c:43ab with SMTP id 98e67ed59e1d1-35c30bb5f2amr8499127a91.4.1774862742032;
        Mon, 30 Mar 2026 02:25:42 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2ec9c8d8sm3685797a91.12.2026.03.30.02.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:25:41 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:55:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 0/4] Rust support for powerpc
Message-ID: <acpBUJ9xdkS4b-zG@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <CANiq72nUf7cikhf+kCdCgoydpMJZ7HuFWR8jzRvHSoGNGCv-0Q@mail.gmail.com>
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
In-Reply-To: <CANiq72nUf7cikhf+kCdCgoydpMJZ7HuFWR8jzRvHSoGNGCv-0Q@mail.gmail.com>

On Sun, Mar 29, 2026 at 06:20:58PM +0200, Miguel Ojeda wrote:
> On Sun, Mar 29, 2026 at 6:03 PM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
> >
> > We are actively working with our LLVM team to get the target for ppc,
> > ppc64 and ppc64le in the rust compiler.
> 
> That sounds great -- I imagine you refer to a `-none` target? Are
> there any links to e.g. upstream Rust issues or PRs that could be nice
> to add for context, if any?
> 
I couldn't find any as of now. I'll try to fetch em and update
accordingly.
> It may be good to put this in the commit message. Also, other links
> that we should add:
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> 
That sounds great.

> Thanks!
> 
> Cheers,
> Miguel

Regards,
Mukesh

