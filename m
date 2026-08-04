Return-Path: <linuxppc-dev+bounces-25392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64182C55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 20:22:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF4j323jPz2yMl;
	Wed, 05 Aug 2026 06:22:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785874951;
	cv=none; b=EW2iRaL0tTr38jbHYa6Mo0dTn4COs1yesTpsZ1+9EgOGlmQK6fNYuOSKgfSOYkVzvwFfabDAb1EhXd9gMnQTHZmmCAXsdu2ywS8bD4N80bDY4znHQjPLmW8Byyqe4JRgsWtuwuQOxNwFDsY5bk36H8AzokxeuHp7s4WEvaZFaUjq9sHUppMpm/1eIutFgDW89r/QRnGElCOYud+w/KPGkE6MtXaEl+9FBcQu+blJY5VkJWgo4s2F3wPNCawLSDrzzfasrmVmI3mGjOQuOQCFpr7roaobLLMQh+QfdRCRjZZr26NMK0RuXH5x2652et0h936VIJq1119vVpLjA04QhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785874951; c=relaxed/relaxed;
	bh=jFIVhfgvSqAlsE9N2/sLKjxiJvjv6VPYe409DbZ+ZU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHRNnBvFTTNYIeD/tvO5DXZn9vpZekpXoGURRnyGE26wBPqPktJReiXur6LFQis2ozl3Ex/2mwpn+2K8I+VD9iSmx7XlpchGlRcMSWXj77ajCyTf3dMyt8Jp4b3Bzg0Tyyu+YiXe/pEfBBphjFZXbgXJ3DbCCAlhWHFD51duJEkCINyiDVUv9l50nIYfs4ZKLGII1JmLg6ehj7RLETPRCwD08fwmw8nvJPK9eADvsMyFnMdirm5ClxeVHCUIn+Jr0SLs+v2Zq4AE0TKxTVVzoRjwhhdesrFHyu6W2p1i8VlcUJjJcVB1AuRSJGQSQgfh5tRC3k5BAOQ0XX+c+TAvqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+LikZPd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+LikZPd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF4j20jQPz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 06:22:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD99A600B1;
	Tue,  4 Aug 2026 20:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747871F000E9;
	Tue,  4 Aug 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785874946;
	bh=jFIVhfgvSqAlsE9N2/sLKjxiJvjv6VPYe409DbZ+ZU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+LikZPdVznp+MiyMPRisKW8QWQF24vkumWCG6xvBu7OW254yhKSa7nGURaLsrtBi
	 GOc9epUdIHSifXt1KnHewtT5Bs4GCGXl+VP7IRJ4A3M+SxBfEnwXvF/q3LIaI2UOAV
	 QqtlxsvZmWX0/uMHsyewSYEmx7DTV3DqjMUM9JklBR2gpfMM4wy+JDzHCQelx1rwQI
	 wXqiMfxznxgIqHF+p5K/urKjqDteSWk5m+o17ru3KGb6uH7O7ISCK7YzVBms/ieLqf
	 xg3Wfrkfr9hw7wcay5JHLQw0dh+SwmIZlCz3/Ch23ihIHdy2+mRdgaAKMowyeRhpYk
	 5Z7/iZhp/6A9A==
Date: Tue, 4 Aug 2026 13:22:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org,
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com,
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <20260804202217.GA1109939@ax162>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anG67Q6Y59kDqh-c@desktop>

On Tue, Aug 04, 2026 at 12:11:57PM +0200, Link Mauve wrote:
> Hi,
> 
> On Mon, Aug 03, 2026 at 12:27:13PM +0530, Madhavan Srinivasan wrote:
> > On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > Enable experimental rust support for ppc64le and ppc32be. The patch for
> > > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> > > merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> > > `rust: Add PowerPC support` and the discussion for that is done here[1].
> > > 
> > > This has been tested on
> > > - powernv9 hardware
> > > - pseries P11 hardware
> > > - pseries(9, 10) qemu
> > > - powernv(9, 10) qemu
> > > - rustdoc on x86 and powerpc64le
> > > - rusttest on x86 and powerpc64le
> > > 
> > > [...]
> > 
> > Applied to powerpc/next.
> > 
> > [1/7] rust: Fix "multiple candidates for rmeta dependency core" error
> >       https://git.kernel.org/powerpc/c/00cdfd072c709c608606461d7d44d4613119bfa9
> > [2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
> >       https://git.kernel.org/powerpc/c/be809b60cbb61aab96179f44ac3670242ae72996
> > [3/7] powerpc/jump_label: adjust inline asm to be consistent
> >       https://git.kernel.org/powerpc/c/13244c0a40139fe66c4c5c5655f4d732a6002957
> > [4/7] rust/powerpc: Set min rustc version for powerpc
> >       https://git.kernel.org/powerpc/c/e299147cdc8e19c6421a6b7863dc82a35b09d967
> > [5/7] rust: Make __udivdi3() and __umoddi3() panic
> >       https://git.kernel.org/powerpc/c/c93c194e4ee71a734986fd99a8b1ec9fbb7a9b8b
> > [6/7] rust: Add PowerPC support
> >       https://git.kernel.org/powerpc/c/73b741adb264967093ef4eb59905618a7e0d0de0
> > [7/7] powerpc: Enable Rust for ppc64le
> >       https://git.kernel.org/powerpc/c/bc87cbdb952e9223616b839d64bdb4723aa2ed1d
> > 
> > cheers
> > 
> 
> I just tested those again in linux-next, with the Wii support series on
> top, but now the kernel fails to build due to ARCH_WARN_ASM and
> ARCH_WARN_REACHABLE not being defined on PowerPC:

I also see the following warnings (in addition to that error):

  warning: unknown and unstable feature specified for `-Ctarget-feature`: `mma`
    |
    = note: it is still passed through to the codegen backend, but use of this feature might be unsound and the behavior of this feature can change in the future
    = help: consider filing a feature request

  warning: unstable feature specified for `-Ctarget-feature`: `vsx`
    |
    = note: this feature is not stably supported; its behavior can change in the future

  warning: unknown and unstable feature specified for `-Ctarget-feature`: `hard-float`
    |
    = note: it is still passed through to the codegen backend, but use of this feature might be unsound and the behavior of this feature can change in the future
    = help: consider filing a feature request

  warning: unstable feature specified for `-Ctarget-feature`: `altivec`
    |
    = note: this feature is not stably supported; its behavior can change in the future

  clang diag: arch/powerpc/include/uapi/asm/ioctl.h:5:9: warning: '_IOC_SIZEBITS' macro redefined [-Wmacro-redefined]
  clang diag: arch/powerpc/include/uapi/asm/ioctl.h:6:9: warning: '_IOC_DIRBITS' macro redefined [-Wmacro-redefined]
  clang diag: arch/powerpc/include/uapi/asm/ioctl.h:8:9: warning: '_IOC_NONE' macro redefined [-Wmacro-redefined]
  clang diag: arch/powerpc/include/uapi/asm/ioctl.h:10:9: warning: '_IOC_WRITE' macro redefined [-Wmacro-redefined]
  warning: 4 warnings emitted

when building this series in next-20260804 with rustc 1.97.1. I am not
sure where the clang diagnostic warnings come from. I assume the target
feature warnings are expected but it would be good to get those
addressed sooner rather than later. I see '-hard-float' has an issue
open

  https://github.com/rust-lang/rust/issues/117347

but I don't think I see issues open for the other ones.

-- 
Cheers,
Nathan

