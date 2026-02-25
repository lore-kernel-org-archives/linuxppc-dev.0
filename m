Return-Path: <linuxppc-dev+bounces-17210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795CBFD45F7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 21:35:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLntg4rxvz3f1c;
	Thu, 26 Feb 2026 08:35:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772055307;
	cv=none; b=O50xqAGhZ0jF59/LTp0c4Mj4QtbBj/kak+AJCx3EJYKgGmxGsvx8pb9+mIOW6npcYS6GlB76PGP4MBPjokQQhzloD0fIS1GhOci0s96CYDvHvcW25YDIzgXfw+o71AsqR3ZDZfwwLSfzJWMFATeLnxXGveMs2k4vVM+OXxYg2/MwQ70XHgleDE/SQDdSHJa2HtLlDDYccbCu9or+BXxP7GEZrME9CWVJB+nGZhIcF1JanGXKG/o292KDywb0k5wJFoMpcDewnOf764IfPzSAbXZ+nG19Akhq/7Og/YqjpyV21lE3Jl14wYtI7JjlGF/FdQnnt1KYs+QTKfNB4yCTog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772055307; c=relaxed/relaxed;
	bh=en/JvXIfupenm3okIOE1FnmDCefKL7wqbMuXB1gncaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPRB76SFE7uOAYhmMQZZ4i19pv6VNXELbVs8QFsgVXLaLFqseZMk08OahYTj3zGfyKjnoocj9VQuXd2ilZbM5CElLiQILzeUGbucuvr4K3TNXBlLZe0H5LQHpmGbgF3phU7q39rWLX929ztFoqQ/dNWHUN0Drni1xwf+6GBSM2W0+oGbfh5oRK8i435UY4Gzhb/lNw5nnjJFCMkf8NkL5Gx4sPbpqKoE0ALP8tQ1CKiIjM1BlYjEgLz5TqrOynPN6j4G0hirVSjnU5xdwg7JiElUdUfJ7SNwBObTMt0cBmhKAuFkk8eAQZb1OjWTx6V6kQw4+/WpDsFKr+m5UcfTzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TqXb2aen; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TqXb2aen;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLntf5wMZz3f1Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 08:35:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A04360054;
	Wed, 25 Feb 2026 21:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B74C116D0;
	Wed, 25 Feb 2026 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772055304;
	bh=Bf/KZHOSyjrfchLf1TkP1vhNwc6+8dsnnl9EQTuW7sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqXb2aenkiPaYp1gJtTBwfuD317E/BSExbt6zNVu9/i42oA37W2o/+G5AqgrFv2Q1
	 jEc2r0q7NdT4dFLNKDOXdCnpZv+1gOVGLEAdtG+C8lV+LKd4dEcxiYfPQJ6J3iiq2s
	 jKO1StHCGSIGrMPovjoKoSYBgeOvsXDPfUQjKzXQTO2TlrkXMghUuyQvcY2izA9rdT
	 mTCcEb9kGhdlQ1jlef7efc7mE4cHlsJGythEgSnx+ZojwSU96HAPxphMrym4L8tzQG
	 J1kwU/BaR9Dr5qQUuIlCfDhz8ik0I9USAkAle9/BY1jAAjxfyP6MCcYlPufAM/FCIY
	 dO8imCdmgBiCA==
Date: Wed, 25 Feb 2026 14:35:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Aelin <aelin@mainlining.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: Failure to build with LLVM for the Wii
Message-ID: <20260225213500.GI2755225@ax162>
References: <aXs8sgAcci9FKKpx@luna>
 <20260129223136.GA1614447@ax162>
 <77cd40dd-bc40-4223-a5db-7eb514c13b78@mainlining.org>
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
In-Reply-To: <77cd40dd-bc40-4223-a5db-7eb514c13b78@mainlining.org>

Hi Aelin,

On Wed, Feb 25, 2026 at 12:30:30AM +0100, Aelin wrote:
> On 1/29/26 11:31 PM, Nathan Chancellor wrote:
> > Hi Link,
> > 
> > On Thu, Jan 29, 2026 at 11:55:46AM +0100, Link Mauve wrote:
> > > I’m trying to build the kernel for the Nintendo Wii, using LLVM instead
> > > of gcc, in order to bring Rust support to this architecture (and also
> > > because my distribution doesn’t ship a cross-compiling gcc), but I get
> > > this build issue near the end:
> > > ```
> > > % make O=wii LLVM=1 ARCH=powerpc -j1
> > > make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
> > >    GEN     Makefile
> > >    CALL    ../scripts/checksyscalls.sh
> > >    DESCEND objtool
> > >    INSTALL libsubcmd_headers
> > >    WRAP    arch/powerpc/boot/dtbImage.wii
> > > objcopy: Unable to recognise the format of the input file `vmlinux'
> > > make[3]: *** [../arch/powerpc/boot/Makefile:394: arch/powerpc/boot/dtbImage.wii] Error 1
> > > make[2]: *** [../arch/powerpc/Makefile:236: zImage] Error 2
> > > make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
> > > make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
> > > make: *** [Makefile:248: __sub-make] Error 2
> > > ```
> > > 
> > > I believe it should use $(OBJCOPY) instead of objcopy, which is set to
> > > llvm-objcopy, but couldn’t figure out where it is misconfigured.
> > > 
> > > Thanks for your help!
> > 
> > It is the arch/powerpc/boot/wrapper script:
> > 
> >    https://github.com/ClangBuiltLinux/linux/issues/1601
> > 
> > I have a WIP series from long ago that may be a good starting point for
> > getting something working but there were some errors I never got around
> > to solving before having to shelve it for other issues:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/log/?h=wip/llvm-1-powerpc-boot-wrapper
> > 
> > Maybe something I (or someone else) can get back to soon.
> > 
> > Cheers,
> > Nathan
> > 
> 
> Hi Nathan,
> 
> your last 3 patches on this branch do indeed fix the wrapper script for the
> cross-compilation with LLVM=1 ARCH=powerpc without CROSS_COMPILE set or GNU
> binutils in PATH. They look good to me! Would you be willing to submit them
> now without touching the VDSO? That part does not seem to be necessary to
> fix the wrapper script for this usecase, so it should strictly be an
> improvement. I'd also be happy to pick up your patches, send them and
> follow-up on feedback if you don't want to do it yourself.

Thanks a lot for testing. For the record, I submitted the vDSO parts
separately and it landed as

  4406b12214f6 ("powerpc/vdso: Link with ld.lld when requested")

so it can safely be ignored altogether.

I am a little busy with things at the moment so I am not sure how soon I
will be able to pick this up. I am more than happy to let you take over
from here if you have the time and energy to get it tested and
submitted now. You can either take full authorship or stick a
Co-developed-by on it, does not matter to me.

Cheers,
Nathan

