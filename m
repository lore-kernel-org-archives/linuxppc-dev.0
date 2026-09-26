Return-Path: <linuxppc-dev+bounces-28264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB22C98328
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 09:16:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsMPg34h9z2yd7;
	Sat, 26 Sep 2026 19:16:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790414167;
	cv=none; b=JbLrDO9cDnmEp0F5DkmEHaTESEAwGllu3HB9kHTaZqW58NH46NdsywE+0deHv9wXMZ3MipAf9OFCWiQXULdYPXRPOj18aGRGM+xOkgWqAWI/gphWsIa4Sv7T3YaPaEGzKb2szjItLlS+WpnAVaobBxaeKhXII5CmAZxG02FvnnDlwcMiTqTPBjXNqTz+KYnQJLKpsUdg3K42LZLcKi5hgghuUBrD0aU79RoFRZGcmwgN4fR88GjQVMKMIUgZ3TIQNFc436RQ1FoapCVQikVKrU5w0wj60CJ3Ao5meITVc6WBiZKH86DvPhkexaQEjjK05syPCkJx/BTb1fn39kBQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790414167; c=relaxed/relaxed;
	bh=N4bWsh+Pc9s6sIGPF4Grv7BRltIPfKgjNpbCy4AEEXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGRCGq86Pbi8O2EZXg+GTuCcI6werVUMKyFMc1wVu7j49x4PAoybF39MfjspbOZ1DYzPin+U1HOZOoIxCkwLGrpxggQ9YVCUMoSvwwXk3TypQ880vGnvZwkgcUTP79VrNzi7MID8iOv9yJLcO33d5OoNZLltK+HJVta9m2/tfb03V3o1kN6nJTlkiagFE0/ZpSRh4eq7iI6DY3s0vYtjD6pIvus41jhiO+8vS56Zm+YZl46SCoD2jS4m+Gk9InCpYKbuaFW+uLnplBmi8QW7dAY2+EyZBd7E/Yc06F8Avwb6yQ1nPwzmH6Sxpl9rdu8ERJAKVpzyIg5/drm6b26xcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/cy2uAq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/cy2uAq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsMPf2xwHz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:16:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8459343D1D;
	Sat, 26 Sep 2026 09:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6591F000FF;
	Sat, 26 Sep 2026 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414163;
	bh=N4bWsh+Pc9s6sIGPF4Grv7BRltIPfKgjNpbCy4AEEXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i/cy2uAqCW0oNOWoQHl6gMve0xGBebGA1qmqR1XrS9a5R9KjUOKFr6umhqPOwVAfq
	 JV6o+g9ZbwsyFiC1yXxh+8YSz9r3KSw26jRgxGioo81b3ckcBjRXINtVkE5FLLobZm
	 cEXp3py7fiL/jCemhyNfo4o04u6qGas4PLNjGw3xPqVwYER6r75qK1Kpvp2M23DpoY
	 0BBb6c0Da8U0FS8/BGW5K1g9Jfq3Q/44IR7oFF8xFbzjaFcMlW6oTmaVRUNooMJemG
	 74S09dqAtiFGHl507QSUC4HwsG7rqGMANSDx0f//8KLgYHgnF7DXbYK/029YJkc1x3
	 aMwcgwNgXEt7w==
Date: Sat, 26 Sep 2026 10:15:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] arch, mm: promote DEBUG_WX to CHECK_WX
Message-ID: <areNQfnAdkfR8fAf@gremlin>
References: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
 <91d800d6-03f3-4068-8c12-618529a81528@kernel.org>
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
In-Reply-To: <91d800d6-03f3-4068-8c12-618529a81528@kernel.org>

On Fri, Sep 25, 2026 at 01:01:51PM +0200, David Hildenbrand (Arm) wrote:
> On 9/25/26 11:53, Mike Rapoport (Microsoft) wrote:
> > Verification that the kernel does not have writable + executable
> > mappings is about detecting security risks rather than a pure debug
> > feature.
> >
> > Major distribution configurations enable it in their kernels as well as
> > defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
> >
> > Rename relevant generic configuration options to use CHECK_WX and move
> > their definitions from mm/Kconfig.debug to mm/Kconfig.
> >
> > For arm that does not widely enable it, only rename its variants of the
> > config options.
> >
> > Enabling CHECK_WX adds a few kilobytes to the kernel binary and while
> > the added size can be slightly reduced with churny updates of
> > architecture implementations of ptdump, the core functionality takes
> > most of the added size. It cannot be moved to .init.text because the
> > verification has to happen after init sections are freed.
> >
> > With this, make generic CHECK_WX default to STRICT_KERNEL_RWX while
> > still leaving users targeting small kernels the possibility to opt-out.
> >
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
>
> Makes sense to me
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Similarly LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

