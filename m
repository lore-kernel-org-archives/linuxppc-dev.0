Return-Path: <linuxppc-dev+bounces-23700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58163C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 10:27:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvcq330Pmz2xyh;
	Tue, 07 Jul 2026 20:27:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783420031;
	cv=none; b=XIFeQxxpwMGYQyHAm0BzIcIoFjMqfwF1sI4yrTWoPLLicCQtcltx2rkG6jbBipg+80pk48zo5X97EheZelObLfucDzsNjVM7cF9F32TV1v+z0UwRMbyizUyiK1yRPbvmQru24pXEf8AB61b2+xVZB7cbCKQuQxWiGS+87HXZilCb+NCSKfwb9pZEf1fu26KIg3Vq1TiYGUHm/7NPtrxp2P0BNwA4QLx4xkcVAdjBnyBFEUfOTTPHeEDrRcFfB900VQWQCtwc5j0auORkSWIeJxbHS7uQuR0PmwozScFMsfZ6MMxR/pdewj4xkU+4NnsQUXN506xH1V6v5kTTMhm0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783420031; c=relaxed/relaxed;
	bh=Jpb9fVdn1cz2f5jjHR7Lg4KnIVzewfTp5wXWe1lGbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVZv6L1VGw7C8m5pYwnbjH+zw5h6kB6iBf6VP69jNT/kAtrU5mgivJttXlmeeHymu/lkyMJjbnIPkBauMAoqupYWinotlroge44If7XWQlbkzNay8b2t8LVX8QKzYla/yhH8/qlDCv6okK8YH60Cqwc9oGh2ka+m3IMNdSg5KkKklap+dbNbBFpmhHO0fD/z0RYM/SM9oMyqZSPPE5D5LV9+l1RI8tgtuYgaVMeo/s8mfxxyAdPv5HEtENaylZCaHrqGRrcSm6w8ePHaRsFxFsX5XASWJ5NgYq6iL2IylXVzZ8v9+2DhhWOFb7XGnVzjh2s6JkDI24DPk4ay1ZWEIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 356 seconds by postgrey-1.37 at boromir; Tue, 07 Jul 2026 20:27:07 AEST
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvcpz5Df9z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 20:27:07 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id A7880F40C4B; Tue, 07 Jul 2026 12:20:59 +0200 (CEST)
Date: Tue, 7 Jul 2026 12:20:59 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, daniel.almeida@collabora.com,
	acourbot@nvidia.com, fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org, prafulrai522@gmail.com,
	tamird@kernel.org, kees@kernel.org, lyude@redhat.com,
	airlied@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <akzTCxnSgxba7Yen@luna>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>
 <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72mj1P9QykK6vbPK37hZkMLwd7RcgVWEcxxuE=9OL+4bAg@mail.gmail.com>
 <akNXvfSfue7_3tyd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akyiZBPCaZOOyTw6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <akyiZBPCaZOOyTw6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Jabber-ID: linkmauve@linkmauve.fr

On Tue, Jul 07, 2026 at 12:41:37PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Jun 30, 2026 at 11:15:03AM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Mon, Jun 29, 2026 at 11:11:44AM +0200, Miguel Ojeda wrote:
> > > On Mon, Jun 29, 2026 at 6:57 AM Mukesh Kumar Chaurasiya
> > > <mkchauras@gmail.com> wrote:
> > > >
> > > > Sure i'll bisect. Meanwhile i would still like to get this upstream.
> > > 
> > > It is very early on the cycle -- I would suggest bisecting first.
> > > 
> > > But it is up to ppc, of course.
> > > 
> > > Cheers,
> > > Miguel
> Hey Miguel,
> 
> I was able to bisect this. This got fixed in 1.87 with
> #![feature(asm_experimental_arch)].

On 1.85.0 though, with this feature allowed, the kernel gets built
perfectly without any need for 1.87.0.  You might want to require 1.87.0
only with altivec enabled, whereas on 32-bit we can build on 1.85.0 just
fine.

> 
> 1st commit that contributed towards this is
> e4f539ea17a3 ("Bump to version 1.87.0")
> 
> This caused another issue to come up while building
> 
> ```
> error: extern blocks must be unsafe
>   --> /home/mkchauras/.local/rustc-src/lib/rustlib/src/rust/library/core/src/../../stdarch/crates/core_arch/src/powerpc/vsx.rs:38:1
>    |
> 38 | / extern "C" {
> 39 | |     #[link_name = "llvm.ppc.altivec.vperm"]
> 40 | |     fn vperm(
> 41 | |         a: vector_signed_int,
> ...  |
> 44 | |     ) -> vector_signed_int;
> 45 | | }
>    | |_^
> ```
> 
> Which is fixed by 
> a78d1b092c9c ("Update stdarch")
> 
> Both these commits went in 1.87.0 and fixed the build.
> 
> Regards,
> Mukesh
> 
> > Sure, I'll bisect it first.
> > 
> > Regards,
> > Mukesh
> 

-- 
Link Mauve

