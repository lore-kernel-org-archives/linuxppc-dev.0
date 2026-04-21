Return-Path: <linuxppc-dev+bounces-19905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C33F8FA90
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 17:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0TQF56Zzz30MZ;
	Wed, 22 Apr 2026 03:10:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776791445;
	cv=none; b=hLvfat70i88HcsOMGPXUUJn2H0fNS4IrG/EKEO/ZRNobXUP8iXmIar7456FCTiYTKSwrwm7KNoIDMufberonsZZTcsh//Cg1LfV2DYT+sToqBJ6CH3U2/GxUhZbXQDPrt1stX467YhB39TTfySyhUnGQ5OCrXW841TyPvep5PxiHs6a8Hq6kMOC+5QcXD1WAdzMFKLqMyrecCXAisUakAdLieqFWvewb7uR12a6pFMP/vRPYDolW5A0Lwva/asgUedFZW0PHWCKda88PH4RrjG9tM6wLbc1MlyK8t+hwhR90AqPgJnbVk8CHPy+yMj9oc8JoIoiowbJgiSaI1bNvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776791445; c=relaxed/relaxed;
	bh=T0UcJJJkQIpFBNgMmbTp5NlKvYP/db1mBT/eUt0sPTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHzQ2MfQLSDojO4IZKHrGN96Vkf2sPnK4Rhnuut59JOCFE2vmHVesRADGqdo1jJCAwH7sgArvRGsMcxzWBfrN2PoqRQw9UYkHO8lhmqbMsVEFneKE6aN3kinXTAMgEIC1KpD8A96eBm5Lw+zaw6IxMUiF+A84g4PN8LBEAUMg7Kj7JyasQOEoBielvbSRjpXgoQyUedkXcAO8egypGQYT82pmoDI9MLbyr8DjvphFPapZIqTDj9t3Z2j+CE1hGy7OvoCmZQUp1kymNsFsJclWOpJyTLHYhpGrAEeYtcAxZuh4Rp/UyqqZ9ni9rrffboEj56P/JnXIs1FLmGwQYQrqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0TQD6bN2z30M6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 03:10:44 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 47C8AF40852; Tue, 21 Apr 2026 19:10:39 +0200 (CEST)
Date: Tue, 21 Apr 2026 19:10:38 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Gary Guo <gary@garyguo.net>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aeevjubaW30LP8Pi@luna>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <DHYYH903GZVW.EU2UKXD2ET0S@garyguo.net>
 <aeenqoV-dWWW3tZv@luna>
 <DHYZLGGNTTLL.AV3V11M454BO@garyguo.net>
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
In-Reply-To: <DHYZLGGNTTLL.AV3V11M454BO@garyguo.net>
Jabber-ID: linkmauve@linkmauve.fr

On Tue, Apr 21, 2026 at 05:51:42PM +0100, Gary Guo wrote:
> On Tue Apr 21, 2026 at 5:36 PM BST, Link Mauve wrote:
> 
> > This works fine for the core crate, but now panic_qr also gets the same
> > issue, here it is with V=1:
> > ```
> > + powerpc-linux-musl-ld -EB -m elf32ppc -z noexecstack --no-warn-rwx-segments -Bstatic --build-id=sha1 --orphan-handling=warn --script=./arch/powerpc/kernel/vmlinux.lds --strip-debug -o .tmp_vmlinux1 --whole-archive vmlinux.a .vmlinux.export.o init/version-timestamp.o --no-whole-archive --start-group --end-group .tmp_vmlinux0.kallsyms.o
> > powerpc-linux-musl-ld: drivers/gpu/drm/drm_panic_qr.o: in function `<drm_panic_qr::SegmentIterator as core::iter::traits::iterator::Iterator>::next':
> > drm_panic_qr.f39a15fa3c72e9fe-cgu.0:(.text+0x200c): undefined reference to `__udivdi3'
> > ```
> >
> > From a cursory look at the SegmentIterator::next() function I don’t
> > understand where the division could come up, but it’s actually nice to
> > get an error when operations which shouldn’t happen happen anyway, it
> > makes it more likely to get them fixed.
> 
> There is divide / modular by 10 code. Although, this shouldn't really cause
> __udivdi3 to be generated for constant divisor, unless `-C opt-level=s` is used.
> Do you happen to use that opt-level?

Indeed that was it!

With CONFIG_CC_OPTIMIZE_FOR_SIZE=y the kernel is 4 MiB large, and with
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y it is 4.9 MiB large, but
CONFIG_DRM_PANIC_SCREEN_QR_CODE=y works.

As I target the Wii which has only 88 MiB of RAM, a difference of
920 KiB is actually quite important, and someone[1] is even making it
work on the GameCube and its 24 MiB of RAM where it becomes critical.

> 
> Best,
> Gary
> 

[1] https://github.com/Wii-Linux/wii-linux-ngx/pull/13#issuecomment-4233447365

-- 
Link Mauve

