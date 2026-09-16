Return-Path: <linuxppc-dev+bounces-27485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE7DC88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 14:18:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlLZn4txWz2yfD;
	Thu, 17 Sep 2026 00:18:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789568289;
	cv=none; b=gWogakElgQiMlAm5Ie3hWZDTIfaGnoBH+sfpXO9XUKwFbXFtHMtfW87FeQFZN2fyGbq9Nijm1XRO1lAzMs5gL7ii97cSCSbHUmWi4sE36GFqFJmcTLDR6oGY3RioElV1kO9p3oUQ+RH8exk4N89O48zptpGcaqwl4DgjydA74nbtDc5la+GBqKglYoKCgDpUjy6xi5vashD/SL9ZbDGgVbDIGea2H6kKcvsSYAmichM5GwWWdQmy1ciTtaAnsHo7V1HVtx1juJP5h8FQ7AFgjGCSv5FVXvP1D+nV0nIcuOc6J8EN6lzU1QVlRsS9IRFlWSrt+l1RsUtPOiGUB8ZhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789568289; c=relaxed/relaxed;
	bh=VlFUKUT2IfapdBX0ngXWnLICIsdlboN0BkEZmE+ZMG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWkqDCTu152u3B5wPYBNLZKf4mOZr8BjQtFfgbi6qcnv82SD5iQbzH8cG7gboGJwdOtpmmh6jULKod1AWhE+d0m00oy798H+P/AMrG3if2rlmQNMy0WkCnK6dK7I2CUqp/v9JER68I7JNK70eb/v2UsMh+3GcBXNz4vq9o0dJZZ88D7r3WPg+tWG/NaQpVIRLrA+KWTo1qke2EpMwshpbBSiXvrjBiDzb+ouZAqtgtfoz8A7aWWtm2Zq8IPYyKp1TyPpWIKVYiGn4FGQU+kiXitCdZnJ/5DkjVz7x4U342vMnsCvC57KrCZqpaGlP80x84F6UbYXD4C3cR7uHtzSKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rpL5PzkE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::f; helo=mail-qk2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rpL5PzkE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::f; helo=mail-qk2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x0f.google.com (mail-qk2-x0f.google.com [IPv6:2607:f8b0:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlLZm35NKz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 00:18:07 +1000 (AEST)
Received: by mail-qk2-x0f.google.com with SMTP id af79cd13be357-93a2218d7c2so35670085a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789568284; x=1790173084; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlFUKUT2IfapdBX0ngXWnLICIsdlboN0BkEZmE+ZMG4=;
        b=rpL5PzkEm+YelQjizmN1dHgk713V9yCbDo3eiGrjDcnGJ/UnxXUOPCVkCpPnsAeuQD
         0qVluhst18gnfQEtBdFvUANf38uxdDX3Gjsy5nizyF4Dq/s6ieorc3rhz8h0bp9By0Fo
         vfqNRZP+4QKwmjanbsgKjn68YUuWSpAqDFU9u2LOf4pVym38WwUzwOiw0o2j5WoVbqGp
         OGWs/h4+Ii7xgNH2xrY+/vPpuJSKdJ/hsqbyzenaatiUT7u5LrPfKUPEZedJUQvIvS51
         9HBVntk2dwvC6lABFEVXeZBYlxaPePUtHq5i3Ki8sHqCqIn93uDTF3xddnYcj0NEvt1B
         X8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789568284; x=1790173084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VlFUKUT2IfapdBX0ngXWnLICIsdlboN0BkEZmE+ZMG4=;
        b=wOGVNJeW9k28OkbzpsPg528gglo1lmS6nkGFJRycWW+4Q3y/r8gQTkTy9Xm/LJfSET
         Im5zKi7QAkAS47Qn7nKmxh9j2ts7p0U64xK+M7wAboViwWvYCAWrt7NIw9zJcu18Pbuo
         yaWGSbSGyFr6JKKqblo4gqxKMICtec4Dk59UN4wTTauWCl+huHL6aNv5wkX5QcB5I7i8
         TzGdMtdT/ZZxTbg5tPpAfaKI6aL6ksvCoA/sCP5d80/d6vBDrrVPQOhVma+eKALSNSi8
         NaAoywCQh2PanTkgzrl4HZMk9CtNwxE2pl0jGZkqh7C/uXWV+ImPsA2MnxNSfyZTzRO5
         ak/A==
X-Forwarded-Encrypted: i=1; AKwUvBxXgaqNETpHKWmoOHJojBIL3CyLHs9EmJiUgQZwSF+p1kpdhIkBaNPTRlsIcUnaZGkLbIqmFXFdFhvBseo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mTgVrDQJ0r7aWaHoboUyz6e9OmK+LOFUW8Y6+DJeHxxSUQZI95
	Nk+cEctJhp/tbfkd0R372wH+qgJiUP5fWGinliyI1N11ajt9Zv6wjE2n
X-Gm-Gg: AYBFou1gY6CpmE+xDskETOfEYxsIyN4Y6ODc5v0fMuKhUyni5lbhbnFlmMUZRAMFz6T
	asXhWBJ8bCybrhbF5bD94GL3U3Xp0Vz3wHJg5none+jY/dhwnsMbIM5jKpqSnf1N2gcTYK+R0gD
	qCLFkx7c9nedc9XWOdcKqHbbLWTZtxNksUwJePK1qmfYr1IO5rb2ibJwcBJyU+nX+c8ai2x2gNn
	akAgMgbUChLmHWSXXS9csdJd4VtCG9jYGtvvCz3BRQ1VjRZnlx9ecs66PspbQIGGCN+yQDucyNO
	EyxBqcFQCANvYdLpJGfvF2Wt2zts0e2SvsP2lgTrPEbQlBbJf/8XhnZmG0SFvBZ/+vPLLN9bHwC
	tICtVH9TO3gj0ayfUlR2p2wqDOji7U6Gix4hcpgvsb8gzYgGmgGIWjEGGlTNgldPo35vpYeqvQJ
	ADqRiCd5l1gmPmzxJrw63/wukHUnbY+yVO0lzOdNvJHpjumQhXKIIV+qXUD92Gc5vcAKveTMznQ
	yX7Mm222zW344Vrb0K+UA5pDXIWkBrQNeYIiOdpKQRLUQ==
X-Received: by 2002:a05:620a:318c:b0:939:83c1:d8c6 with SMTP id af79cd13be357-93bb71b6f5cmr340423285a.8.1789568284122;
        Wed, 16 Sep 2026 07:18:04 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d19df1sm228561685a.45.2026.09.16.07.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:18:03 -0700 (PDT)
Date: Wed, 16 Sep 2026 19:47:47 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, ynorov@nvidia.com, david@davidgow.net, 
	joelagnelf@nvidia.com, fujita.tomonori@gmail.com, linkmauve@linkmauve.fr, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH V5 2/2] rust: kernel: Add KUnit tests for powerpc
 ARCH_WARN_ASM bug table emission
Message-ID: <aqqk-YRcGcUsqOiI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260915090453.1227034-1-mkchauras@gmail.com>
 <20260915090453.1227034-3-mkchauras@gmail.com>
 <20260916.230658.2266384286281034372.tomo@flapping.org>
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
In-Reply-To: <20260916.230658.2266384286281034372.tomo@flapping.org>

On Wed, Sep 16, 2026 at 11:06:58PM +0900, FUJITA Tomonori wrote:
> On Tue, 15 Sep 2026 14:34:53 +0530
> "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
> 
> > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > bug_addr displacement ― i.e. the '1b' label reference in _EMIT_BUG_ENTRY
> > resolves to the trap instruction ― by calling find_bug() with the exact
> > virtual address of the twi instruction, mirroring what the real powerpc
> > trap handler does.
> > 
> > The trap address is captured at link time via a .dc.a 1b relocation placed
> > in .data by the global_asm! block. global_asm! is used instead of asm!
> > because LLVM eliminates asm! blocks in dead branches; global_asm! is
> > file-scope and always emitted. BUG_KUNIT_TRAP_ADDR is defined as a .global
> > symbol directly on the .dc.a word so the linker relocation lands on it ―
> > a Rust static initialized to zero would end up in BSS where relocations are
> > not applied.
> > 
> > .dc.a emits a pointer-width word (4 bytes on ppc32, 8 bytes on ppc64),
> > so BUG_KUNIT_TRAP_ADDR is declared as usize on the Rust side, making the
> > tests correct on both ppc32 and ppc64. The global_asm! block is split into
> > two cfg-gated variants (CONFIG_PPC64 / !CONFIG_PPC64) to select the right
> > .balign since concat!() only accepts literals.
> > 
> > Five tests are included in the rust_kernel_bug_powerpc suite:
> > 
> >   bug_entry_found         - find_bug() returns non-NULL for the trap address,
> >                             proving the bug_addr displacement is correct
> >   bug_entry_is_warning    - the emitted entry has BUGFLAG_WARNING set
> >   bug_entry_file          - bug_get_file_line() returns the correct source
> >                             file (requires CONFIG_DEBUG_BUGVERBOSE)
> >   bug_entry_line          - the recorded line number is non-zero, confirming
> >                             the {line} operand was substituted correctly
> >                             (requires CONFIG_DEBUG_BUGVERBOSE)
> >   bug_entry_addr_is_in_text - kernel_text_address() confirms the trap address
> >                             lies in kernel text, not data or zero
> > 
> > The suite is named rust_kernel_bug_powerpc and the Kconfig option
> > CONFIG_RUST_BUG_POWERPC_KUNIT_TEST depends on PPC && GENERIC_BUG,
> > covering both ppc32 and ppc64.
> > 
> > Tested on ppc64le (ltcfujiaac-lp3, 7.3.0-rc1+): pass:5 fail:0 skip:0.
> > Tested on ppc32 Book3S (QEMU mac99 G4, chrp32_defconfig): pass:5 fail:0 skip:0.
> > Tested on ppc64le (QEMU pseries, pseries_le_defconfig): pass:5 fail:0 skip:0.
> > 
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  rust/kernel/Kconfig.test |  13 +++
> >  rust/kernel/bug.rs       | 209 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 222 insertions(+)
> 
> I think that testing warn_on!, in particular that the right address is
> put in the bug entry, is a good idea.
> 
> I'd prefer such a test to work on every architecture. This one depends on
> details of powerpc's ARCH_WARN_ASM, such as the '1b' label. KUnit has a
> warning suppression API. A test can call warn_on! inside a suppression
> block and check that one warning was counted. The counter is only
> incremented after find_bug() found the entry, so a wrong address is caught
> too.
> 
> I'll send a patch for that shortly.

yeah,

makes sense.

Regards,
Mukesh

