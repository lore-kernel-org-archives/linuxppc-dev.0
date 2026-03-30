Return-Path: <linuxppc-dev+bounces-19003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5522FB3CE6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 09:19:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkm0j3cX9z2xpt;
	Mon, 30 Mar 2026 20:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774862373;
	cv=none; b=BDaXs/52Fugz3g9mUTx5mLtI07pv1Km5ksAqeACWtkU/70Qgb4Z5bomGwZdKnmMp8zJZXqKpoJgp0O+h7bWkM437789PWO+fzOL0IbtltL/RuVYgRYV9VxXi+wlYu8vuhY+s6rDmyvlVHFMHFgVlrA+o//ILGqHymogpMTkgEcu2ZOxedFUaio00eN+KXQ2MLM237msnHnwMnZOLYvtSTVLAEDX5FK3K8mD8zUl39MKjZeblYWRpiWJEsmkAWDdId6bW0cASpGNe4EVLudSD8Yv0+xoey1sUUD7RaL7ZguaOxuJVajMYfcNiM+qwjT5PXPTG9EsnnklAPPBit0tQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774862373; c=relaxed/relaxed;
	bh=xGALccOgtUVKb8ynYPgQbEzvhqor5CbjYx+rsGEXTzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIStlCNQ3EkgDvAk7fRk1H65XAhDa70/WIQ0G3t2e6eT3DRIUB3DFMMro/HMthGpKQu3RxOEfQCxODZBPiwVJXYSZsWCVMPhFP2Pvozpq8Ri0Q8hOXbU5DvVO09hWt7vrwUfZk/BTnCnh2eXdCOxHIPKQF59GYapzu8aAObpteU6aVVdhuZrCMyvm8iOMrHR3akdoFEnikJKfP2LKVQ7f3DKwlXmjfng4kcTJTVVYSjd2ZbVbgv/IcyLNyjS38w9k559/UswiRaxepjxUoNDsuIej8pxzGJOVSxCKXu0fYo3/Z40KP3vVEVKbOqkex4GJbXD8+bhYyfzVwF1pbBEaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTN5LiMX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTN5LiMX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkm0h40Z5z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 20:19:32 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso3033720b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862370; x=1775467170; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xGALccOgtUVKb8ynYPgQbEzvhqor5CbjYx+rsGEXTzQ=;
        b=rTN5LiMXoiYUQcXWwnwp9rP+/QV/zQEPraAu+OzyCCFXXc59/dNxjf9eIrZ4cLEKKw
         XkUXA9ROi9RGf9KV35fDlqxIZ219MiqoqhuIR2DGU8/0BrtCwjfKIcbdmlhwKUL9j8hG
         N5UwXA/QKQTk9ZL/2hlxE9E4wDwteQfk+UDohYRQyCRAT36dhbqKLs/Vo4TBsSyLNyrw
         rBB4G+CpC/yMyQ7GThB4YDJ7DhiU/NegmKsgJwGOWk3PInSY1NRCLzEh/2OqF4fLkMrT
         uPjhXyyIkkbu1GInq5wKCocrCG/JeUycWqWyrpUz3Se8PlCZE0cqHH8zUuF9aafOi2Bi
         1Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862370; x=1775467170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGALccOgtUVKb8ynYPgQbEzvhqor5CbjYx+rsGEXTzQ=;
        b=IzyppmKxrFh+vFyHJ07YCQxLuYEcy5VKDXJ5XCEjHJM2Q2lLdf4cOpIJnQ7tAlp0XR
         JcNoUJR74YKhiQpP8V/EB6O7mIiJsu8BPc6ELYK9FmQwy5neRJ37kmp6yal+rLCwmEpi
         VOiKYZdRtbEJm9ww4xOmmpdzJ+345Dz0YsmF9pcB63kzKdWQ8Ajg/KrZZnEKXpjYenSy
         usWS2P3UW8Cv+Q+fbaMdCXyMpyTnQPZkLc9/1WkD7DnW/pfxlZGFOxdpNTfFoCiS2fN5
         bXc628ltiJFa9COJFLtPfuS8C/TOg4KFE5BuvQg9CZP6N6amG3PFPMlaBrQtWP2KYBr/
         RAHA==
X-Forwarded-Encrypted: i=1; AJvYcCXB5sdGvF6uGU3QUUxmfzkuuiu/VtqU5mOuAnTL0DHCK/3EiCbs//o+4VdbD9P0ENOYw6UkwpEzEczGkVY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+AOzvXp/TxyTACkaRKc5QLinSKqTGPnIQG/Try56VG8fXrK/Z
	NHpOiwYj3ulsGxpm5O3YhIoNqWU0KTb68qo4v3yS2M9hOPlycBSCS2jb
X-Gm-Gg: ATEYQzygqRy6vz8QP+yqrTmALb5tuh+Iq8XSTR+9A6HxeL8EkIPA3E2aovxW/bd3wSf
	9Ese8vzJdouSNT8ERJWbwKGnXoWDQnB8JR0PbfNdUymJexx5weLGWogwemjRf3PAYNiChPYgKyd
	Snm+kUkFd54TLPmOlhSblR1dCrd3ZiNCSmTDo5RzzPQuJPQl1Q1gNcapREBMqnQnaOhHHHjKKGP
	dp5cTDxbq0WCsumDaKlWKKzTdIoBwwk5KenPh2Sexq07mlFCasGyMtZVmqxSstc9q/LZStWQ7eC
	MgUT145xw53YaccuLVFiG6kCzBTU3q0HcgeN63E8amLUTGux3HS1nNbQixplDN/7kJETzdPO4pg
	GrSwMCooLm5nBDaPPtHTkvreEisWa2YD7KjqYG2NKyyVfmgvVqwS0Yv1RtOIfp+PY2sq9gXzL4C
	5uyyRK0hv0wGh0evQdWF5YlKAoDfCbbQoG2IWD1Lh+f22n5NUu/XswR+ND86BlZzTsdtA=
X-Received: by 2002:a05:6a00:6ca8:b0:82c:6ba6:607f with SMTP id d2e1a72fcca58-82c96026331mr11486694b3a.53.1774862369945;
        Mon, 30 Mar 2026 02:19:29 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm5625780b3a.1.2026.03.30.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:19:29 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:49:19 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 1/4] rust: Fix a race condition in Makefile
Message-ID: <aco-FbkAGGXDM946@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <20260329160254.2592207-2-mkchauras@gmail.com>
 <CANiq72nxgwPUv1AJhRQSFNWtV+w_a-VqK3VWtjaKncRJkNNETw@mail.gmail.com>
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
In-Reply-To: <CANiq72nxgwPUv1AJhRQSFNWtV+w_a-VqK3VWtjaKncRJkNNETw@mail.gmail.com>

On Sun, Mar 29, 2026 at 07:25:19PM +0200, Miguel Ojeda wrote:
> On Sun, Mar 29, 2026 at 6:03 PM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
> >
> > When compiling with -j1 flag in powerpc, the libproc_macro finds the
> > libcore.rmeta both in toolchain and local rust directory. libproc_macro
> > should use the toolchain provided libcore.rmeta.
> 
> By toolchain, do you mean the sysroot one or something else?
> 
Hey Miguel,

yeah the sysroot one.
> We should make it such that `rustc` does not try to use them to begin
> with, e.g. we added `--sysroot=/dev/null` to prevent that in the past,
> please see:
> 
>   71479eee9da8 ("rust: Suppress searching builtin sysroot")
> 
> In other words, we should try to avoid adding dependencies (even if
> order-only) to workaround the issue, but instead we should get rid of
> the root issue.
> 
> Otherwise, after a build, if we rebuild only one of them, wouldn't it
> find again both? i.e. this is not really a "race condition".
> 
Yeah this makes sense.

> From the original message, I see this was happening when building the
> host libraries, because the targets happen to match, i.e. you are
> doing a native build on powerpc, right?
Yes we are doing a native powerpc build.
> 
> Perhaps we could put the host `.rmeta`s separately, or something like that.
I didn't understand this part, `.rmeta` for host are kept in sysroot
path, are we trying to change the sysroot directory?

Regards,
Mukesh
>
> Thanks!
> 
> Cheers,
> Miguel

