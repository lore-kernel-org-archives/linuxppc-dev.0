Return-Path: <linuxppc-dev+bounces-16770-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE50DEA3F30
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:42:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9Gn93VcKz30MZ;
	Tue, 10 Feb 2026 20:42:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770716541;
	cv=none; b=mIwf86/U+DNRLSoaRq5OEnqKbM4rtzGmjiM1CGXuJ0Eh2YbY5+qLaCdDyJLiq7oLPcHPmeGWfLojJp8iKKHOn7Yr4xTk5f0LgBLbKNrC/9/yRDwWH9ZtV59zzVFKBKlKblSCl7rcC1/tSQAdgepmckFxiVYVOXeAJJJHIcAytVmKbHpzXkbQ8TTqoi2X7WZ6sMdDNYsY2C4bnmIFk8GxFxEtFblMZ0W1aSybzxiUvtO87Wdz/FpATLaWJIvtCjRmnrwUrrM4hgvXr3K1XkYLPkGIOCWaij4RuYjy86BG0DGHJB6I4MV0VQ/pDAIhIyvQPx/Wu6NIwg+CzqbdBb9J7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770716541; c=relaxed/relaxed;
	bh=EG0zXJ8ltsyxJXATW/asHing3gKZtEbi10dCNb045iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lahIZHOnCStqS1R8auo5Tcn1TQX188VM1ADpQDRYaG0qZUe97GTI+UPM7GknEMViKf4bpOYoMD3v3Nngff82JFFYrQQnTWcWSUb8gdCA9YPvUQcwBZ3F5oL+CfrHZqP9pm2UzPt9KSYGEK9o0tPSyd50uwfaal7aC8lZPicf02OS+2Q91mkr7HA1/jh3FwpxaUicMgM8pTjOt3Vne3WkIQC7InGXNhCbA9IEzkx/9LMct7fQQ5w5LtejyXHk4OCbJeSUb4fY8uTEWnShfbcxp5g7tOkO7IrVGg/J3f1AqcEGGIwTV74+rV5EvnPlbrM6xs+arD80JlOLiaeEtjkVhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9Gn83BQHz30M6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2026 20:42:19 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 7ACCEF43B79; Tue, 10 Feb 2026 10:42:11 +0100 (CET)
Date: Tue, 10 Feb 2026 10:42:11 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, corbet@lwn.net, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
	ardb@kernel.org, rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/3] rust: Add PowerPC support
Message-ID: <aYr9c90CWAXZ3AVl@luna>
References: <20260209105456.1551677-1-mkchauras@gmail.com>
 <20260209105456.1551677-3-mkchauras@gmail.com>
 <CANiq72nqH=H4a_Yo17KPmku5pPRMVRBADgj8j+=TcR=3r0vOdQ@mail.gmail.com>
 <b07f1bc6-c63e-4b97-95d6-c639186a89dd@kernel.org>
 <CANiq72nkVmE_91yz82e1cRuJK8F9SPP5GpD1mT=NYLBbRTL8OQ@mail.gmail.com>
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
In-Reply-To: <CANiq72nkVmE_91yz82e1cRuJK8F9SPP5GpD1mT=NYLBbRTL8OQ@mail.gmail.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

On Mon, Feb 09, 2026 at 01:48:01PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 9, 2026 at 1:29 PM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > As far as I understand the patch is complete, the problem is outside the
> > kernel, it is in the libcore provided by rust or the rust compiler.
> >
> > That libcore seems to call __udivdi3() and __umoddi3() which are not
> > provided by the kernel. Instead if should call the functions do_div()
> > and friends provided by include/asm-generic/div64.h, or provide
> > __udivdi3() and __umoddi3() on its own.
> 
> Yeah, but what I mean is, should we add this if it doesn't link,
> especially without a note or comment of some kind? (Perhaps to your
> tracking issue in GitHub?)
> 
> i.e. if I understand correctly, you prefer to not add the panicking
> intrinsics to `rust/compiler_builtins.rs`, which I agree isn't ideal.
> By the way, it would be nice if IBM could join one of the meetings
> with have with upstream Rust to raise this topic again with them.

I’m just an unemployed contributor, with no ties to any of that but
sheer interest, would it be ok for me to join that call as well?  I am
interested in resolving that issue in core, only three types have that
issue and only in their formatting code so far.

> 
> In any case, it is up to you, of course. My only concern on the Rust
> bits is on the docs side, the rest looks fine.
> 
> Thanks!
> 
> Cheers,
> Miguel
> 

-- 
Link Mauve

