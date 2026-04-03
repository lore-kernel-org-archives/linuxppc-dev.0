Return-Path: <linuxppc-dev+bounces-19278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C28BE8536F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:58:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMKz6ty2z2xLt;
	Sat, 04 Apr 2026 01:58:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228311;
	cv=none; b=ew+2FTDLOKfp/ys4fT4s4LmcfULvzHkkjJcYx/pyNNmlR2Nv43FUknWXPuhKiGND4YMXZgz0D9zQO5RG26mjQ1kATHljkHqFBRvCl2wVkLZLHWSfXi/2IEBHrWL0eG3uC5Fe0pjW8lL45quVBbzJSJfBf3/sfXnknAqxojSfxgnGp/58EvBw+KCgPMWofgsWIc6e4qOIl5prHhTSnQyQ9DY1xmxOUn+0DNlKVe5sLg3NZb/fBC+JkUtho2OGaYF1g8mSggneqV9/8wYjaDg/gcgHW0lEh87srngIF1sqgIQhSUYI8SfYkVSDu1nG8Bk2L/Ld2EXVxrlyHfXXI1Ig4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228311; c=relaxed/relaxed;
	bh=t/XQC98vdqHlSXICaicJyLajHPRR9Jaz0GQ0v3XHDoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhW+6bsCL9GH9Nv94y+x2QL/DBaEbfdlQGQUpgHwRKBRpcDR7W/S86KvyZ5fim4SCYxJ00SLWXrXCj6Ftb884ebKmhY4N8/75TDCX4RK4BVa5G6mdwdrKKV2vHPaHcAUYwOWv15roaMIrHScYP26AHzHVPgP0S9ZpUXfdn+IItCXHuVgWio9te2u9OsNXwiTax9MCKjryASck5CCZ5vb/2o2HZkmLdFXPpcGBezk6l1mRA4IhOhf8coUtzF5gPLvae2/UEqfq8opx3vvXQucWdrrSF3Za3oeR7s7VCNU8lsK8T75VQ60UuW81CDys+ta74c+gYu/bwqeFL05yCW0aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TseHw9AW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TseHw9AW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMKz0RKhz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 01:58:30 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82ce09b61beso920062b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228308; x=1775833108; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/XQC98vdqHlSXICaicJyLajHPRR9Jaz0GQ0v3XHDoM=;
        b=TseHw9AWMcSZhurF/nTgjkR9blIpLfbluE/3btzTASbXUOVvcJ8RaQaoV5YQQPcJAn
         6QUPsp7KTuLNBgf1D+rAkraG2GJLK0WQLq9MvWCS+4Qi4IixoDnpsMmCkZ+BkAz7p3lI
         3yaql6vdjsRMNno3dNfd4/CPloV7UmobcjrJ+iexFQR9ykGI9c3yYJ10+NP8euIMBL2t
         molPMTdgRAcojVVuIpxfBvrfweFX4AiqdIBgVosPvOQkNjU52wrLVG3NptMOD2pt7g1a
         GL05ezMgvNLbbkLMJ522OH7ZHYDfgKjqObFdMjaGHeLxOaIJ4+xKlqCJtH1bnQl0SEeX
         5fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228308; x=1775833108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/XQC98vdqHlSXICaicJyLajHPRR9Jaz0GQ0v3XHDoM=;
        b=eulXejIaQFlqX6/goU2+ziBUjsCNtwftkHIlg6XMQeJDeIMCTD1fk6/k0O7fr5uKKt
         wsGeUa20H1CbMVGdjj2nthLy9e1WKprbWavoQJ55GJTFT7XqpyQ45kNaVBUjv8Bx1V+s
         oZpY3hP5/MsW5SuTJV1AMxyE9zDKyu8kMAhYFrf1OMd2MML5h3VG0nR+cBhOhYZYNK/G
         46lA1H4nkwMiE8DU7pBNnGKDSaJDDuUuOPRVzrqJXQ0wznJ43C9/272hDit7UJDgMJ2n
         EoiBpnYKrtqs67E/V4p5Zl0YCrCBBcez2p2emwMlnJnDjroyCHA7JDWwl0hTz4eBmI1D
         IknQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrNDXD7f9uPCBT+2ab9f5SbQOQvv11cQV07YGnBzo80DmV06a4jaiadqZYhIib/Y5GFA41Wo07FaX72BU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRrMhgUoVQgPVPBhAHZeJ/u7+PWMPZuUVeQ5XzBH12rvrykG74
	90OzOOGe+gFlUZQiWQyzJiO+ie8UZz4u7VvSoYR31YujmvjhtHuc19T1
X-Gm-Gg: ATEYQzwH9cy8P1twyX+VUBnS0cSjyy7bgPI/5v2HLgWtnC3U66eMfs/14J7mBtImt0p
	LsFVHemx4B/MWqMZgyAIwiHZ/nN5Yu9sX85LwnJCCKMox/W4gY0LQDVItisn9CWM1V11mDghTVl
	lucIDxy3fZ8Vm9OHPyqOOb7aRrUCgZ6roAwuD5TKLb0gVH64LkjLOOnrc22E3wL8l0/IFV7oIZA
	waUEDak3dl7nN4w+yE1454GYlvIXklMvQNXlP5ZFmw2tIrwlc/IPYPheCQt7JWFXMDpOLK7PU+w
	Hc7ReR96eppiJKjc8dk3XzL7TGRfEjwyukHFQq0hc+mUlYEjVjXqCrFGz6NE8884bNn/gqdvQbL
	5KPxtJk+Nd7q8J4xGFxFRt5EUEJtQ0fiDt3h1+BFiCCRG4NauLzrhd4pGzUhLW4UeH10jRyNT+E
	8lGvZLFa8h+jho8gl60+jJm9ZQN4aiT4/ckASh4XgZP3ovnFaN91t36KdwQVYZNRa09JJX3w==
X-Received: by 2002:a05:6a00:3926:b0:7f7:2f82:9904 with SMTP id d2e1a72fcca58-82d0da2c50cmr3484244b3a.5.1775228308163;
        Fri, 03 Apr 2026 07:58:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm6522973b3a.40.2026.04.03.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:58:27 -0700 (PDT)
Date: Fri, 3 Apr 2026 20:28:17 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 0/4] Rust support for powerpc
Message-ID: <ac_VLVEELvJ4KuI5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <CANiq72nUf7cikhf+kCdCgoydpMJZ7HuFWR8jzRvHSoGNGCv-0Q@mail.gmail.com>
 <acpBUJ9xdkS4b-zG@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <acpBUJ9xdkS4b-zG@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Mon, Mar 30, 2026 at 02:55:32PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Sun, Mar 29, 2026 at 06:20:58PM +0200, Miguel Ojeda wrote:
> > On Sun, Mar 29, 2026 at 6:03 PM Mukesh Kumar Chaurasiya (IBM)
> > <mkchauras@gmail.com> wrote:
> > >
> > > We are actively working with our LLVM team to get the target for ppc,
> > > ppc64 and ppc64le in the rust compiler.
> > 
> > That sounds great -- I imagine you refer to a `-none` target? Are
> > there any links to e.g. upstream Rust issues or PRs that could be nice
> > to add for context, if any?
> > 
> I couldn't find any as of now. I'll try to fetch em and update
> accordingly.
Hey Miguel,

There are no issues or PR publically available yet. I have sent out a V8
without any links over this as of now.

Regards,
Mukesh

> > It may be good to put this in the commit message. Also, other links
> > that we should add:
> > 
> > Link: https://github.com/Rust-for-Linux/linux/issues/105
> > Link: https://github.com/linuxppc/issues/issues/451
> > 
> That sounds great.
> 
> > Thanks!
> > 
> > Cheers,
> > Miguel
> 
> Regards,
> Mukesh

