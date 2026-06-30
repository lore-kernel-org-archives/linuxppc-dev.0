Return-Path: <linuxppc-dev+bounces-23148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1882C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 05:45:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqBv432Q8z2yZ6;
	Tue, 30 Jun 2026 15:45:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782798320;
	cv=none; b=Pcl30IR9FzBq5r4p/tOmSTEj9ellDdoAgTkRGlMgWUVeGOzoBegixsj0IVqj61dwP4oc4Tf0LrBdDvATA6UluIoQwciRgkXGyW8E16ebzQHs75xxvi4fi99rKgbbRSUIX1Keu1BGO9oW38/WEV1W0JtAZHH1UHn8Vhj1ZpBhiiHbr1aKIDqPQ9PhZietXG+dyfbv26P8LqQxYxhExLwk82LFGxnbjU/JvCIFF9YqKkObsp2JDVVRVAg4bXwI2EZxXnG2ZZ/QBzcyd8hCXPPW5P91EaF2cQ+wu9aH6V7oeznXx0uvqMWfhoGbTEeJXz/wxUEWAyiIl7rAorciUwehNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782798320; c=relaxed/relaxed;
	bh=xie8EscmE8LK37ZpMwS/Fq6rd1I8uHsenBWRCUghSAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVhxIjBv9IZ1C1AiFnzHvhbbMc3hyi7Zepgjz6USunwEpMiFWMXFzIXHHTAoEjnreOKX9uwsx5kp3he3yLtw8x9Z9YmGOqTkl+lovt4yL02bBvb1t4dnGS1XV4vTryqKeX7eUHD1P12ggTEXLtRxw6d1kXpbidFt3mqF5EuZc3u4gGwHReM4xDSsUg0mb1dik29k2e/+KdvPJ7EItRnwjOYqMhJ9v/MKqsPLr1IgJXkPdO1zDs6o3Qbz2vjRuOGehXcGHjlON+ZJpcsbZ+lAFEmuqQizAacLBynx6Qtr8u76FaE3Z79bD51y2jVGN9X43gGUpwQhp6Zq3bzlOtZE/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ESv5dVd2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ESv5dVd2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com [IPv6:2607:f8b0:4864:20::122d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqBv2749pz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 15:45:18 +1000 (AEST)
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-139f1dfc9faso3638503c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782798315; x=1783403115; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xie8EscmE8LK37ZpMwS/Fq6rd1I8uHsenBWRCUghSAM=;
        b=ESv5dVd2nAAjIbhAWlk8XB1IHlluZcLKLA7ux/w4VcF1eq23+4sJHdtkYW00Ta2Z3s
         +p/uGaL/dTWmRhKsMYd7TNz+JhIYrCjVvnWtGRcSUpJeF0IZ8VWXtloCf3bUi5c0dJsf
         zrLcS5a7jFgPcCrtM5QIWst3poaEmPPOkHHVIVspWzJzTmyVxXTrNQHVyqaWWxU568I5
         1oVkzBrezQE9gjR8l3dsmLYs1GygaZqgngQj0KR8NQHI1Z44qhmE1TKqIIzzfCg0r0kd
         hoIp9RPLkLCdKHN6sI0Lw/3YRgzwnXrWVEiXc9BWlm1QDSshl7y4+IziozwapYlYIFLt
         5nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798315; x=1783403115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xie8EscmE8LK37ZpMwS/Fq6rd1I8uHsenBWRCUghSAM=;
        b=PzZbllwhJ2UvOygwt4iAoLheQLixhFGUpxmgqbgZGekgpPUopQBkm9t136dYD8dgv/
         xlaqBGe0xoeyoVI1mWAXeBHEcGs4zRV/flJA+8yMCI1Ed259ZfCO2siKwnOU+sEm1l/1
         lwRQico4T3TKkQ+5/VDAoVAYB0/h1ZF2aQ0ijnUiYUNmIDCD+iCHmlQrebbIKiDWjXcI
         w+g3eStRgmGV3Uky9b/T07huxBn1w+9OM8qnzwlJRMC5ykDtyEppLhe9SNw0vt+BxB7u
         sfYgnOYpJMeN6mfkrFfSTcC7WwqgyfXyBLFyuRbsKGPX6D856+DBBjsU/tbzTMdwKdKc
         eVug==
X-Forwarded-Encrypted: i=1; AFNElJ8SKYuc5ry9mEU+ok3l2S1p1YZ5wbk4EDzocaLj0u9cAOIEKcw+O3QnybWgsXOogclRfrHzBA1Si5Snu8Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTFqUmmC4i6f1BS+Vdi/+JJHXc/wk+y0vMmffBu2wTHQzvSJiB
	P28HmDI2ZwwzY1H7o2ftpbsD8X+TPcCkgZvLkxX2TbPh6SfvasR3Gk7e
X-Gm-Gg: AfdE7cm+UI3o+UqOwLyng+JlW8VOwJ/3pQ20lIUVAXX1ZnUeG4h3qkZLpb/ZkEJNhh2
	zr7868DR3Zv+Z2vxf2hEYR09SLUTz8JLSf7l3/KU+YOoRmrRIscIux3Hp5visfDVsi1/t5W58Jr
	I07KLSbnL/ESTng5m7tt6dJQ1S8YlarvPodsbkYg1hp7QpmqH/tMDfICxJXleXKp0J+shgbJqLq
	fXtdLjTmKb7kxaYq89WPHUglCz4Dk7aVcx2genUzIfn0pKy8pP4AXexkWyb9gE3MqQaC1GXlh+A
	sbe5+jIyHeua8ABSMpWTL76AOo2obw9G+4VLRGrqa5FQWdOiXKJ3+mU0thB3PXhy26j9Xz8CgJk
	RQk0HojQVPqNbnu9qDFpuPz++qTVkWy2XLfadG+RD2bwpnNQpiyvlw21F9XyX3U6m+EkWOEt8Tm
	xUyYlm1w0T+dlBxc94IkZZYkM+5T0sNMQTvfwMhM8uHBZMWY8W+DZ20cW4
X-Received: by 2002:a05:7022:ec0c:b0:138:637:6227 with SMTP id a92af1059eb24-13b2a1603famr1467281c88.11.1782798315173;
        Mon, 29 Jun 2026 22:45:15 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab0fc83sm3351411c88.3.2026.06.29.22.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:45:14 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:15:03 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, kees@kernel.org, 
	lyude@redhat.com, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <akNXvfSfue7_3tyd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>
 <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72mj1P9QykK6vbPK37hZkMLwd7RcgVWEcxxuE=9OL+4bAg@mail.gmail.com>
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
In-Reply-To: <CANiq72mj1P9QykK6vbPK37hZkMLwd7RcgVWEcxxuE=9OL+4bAg@mail.gmail.com>

On Mon, Jun 29, 2026 at 11:11:44AM +0200, Miguel Ojeda wrote:
> On Mon, Jun 29, 2026 at 6:57 AM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > Sure i'll bisect. Meanwhile i would still like to get this upstream.
> 
> It is very early on the cycle -- I would suggest bisecting first.
> 
> But it is up to ppc, of course.
> 
> Cheers,
> Miguel
Sure, I'll bisect it first.

Regards,
Mukesh

