Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915A606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhloDf5h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZy5664PCz2xl0;
	Fri, 27 Nov 2026 00:27:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795699626;
	cv=none; b=SgwaSVXpDGhwMiTVFkJ8tVzez8/Pz0/TaSyiXS9Ogjv0HwdPE02M8mNkCwE69IhIiYtjgk0bDmZrEiyWEn5tfzFw30f+XjFxlCYwCsqbFgumQaEJ9Zz8ZU7U5TGq8SDR66bISofy0ZVEeh534z26feOWJdH+NrFBe0dW7VWmYwSdCFGh4FESlK6jfsQnPrP5C4tjcN9VLZV6ujvXoqqn/scwKT0GiXQKdiyM9i+0rlC00wiND1z7ubPrY66GhUfsZnsF8mtvlvVUaW8LQbFnuk4BmlyUFMG9w1Jlc86tcCcMyAKtcWOaPAUCq90JZHm9kC26xt1f4gEi+kZP47fAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795699626; c=relaxed/relaxed;
	bh=ZokuwfU4kATqyfaTag6SaT3MT9q8pH3IyIO6M5PAlLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0LIbC797RqHUZCLZiDmQzSy4JYBkSA3X3RhYtb4s8pTxPYtKhAnoowjCpzASY+XNGVQaFF9tMMz5sNs0l5ljV+8nf6XqX7THAOdGa6cBGeU2ynxp/k/Wr+b4XKHipwWPu+ymeMTDAXSs0/XRwEccbgZD7SMSiBuptWsm3UhtxtfAeH31bmvQOAUcHNbU2KLjpCjGtSKLqrGfk/KrzW4wJceljCiRUlabuiIZLbDi5fliBEK7QGuOSl2IBOw2ZUDZw6jT/pJFeel8+IhM3/AChHdP6gmSLcqeWz5vOWmFvR9uGz/tNsOxF4LS+QD8kwvwDeNU/lKl1pYMubUGDqNDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhloDf5h; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhloDf5h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZy556zSBz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:27:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E75D462E3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75A71F008B2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699622;
	bh=ZokuwfU4kATqyfaTag6SaT3MT9q8pH3IyIO6M5PAlLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RhloDf5hjViDM1wa120MCgd7yIwpKXtodHert8PQGCu3nBm3Jhrb09TaNG4V8Vs5/
	 d1vXZiZry4y/sMZO+BHWZqI6I8kbwDjJ5tj7eo69vxWr3+mO790EUTeE93erN6DUug
	 /+Xrz1C+FBXYxu00wHMRsUx0TeB7gI6IBwCtH6p4ScNc3/1sNZ48q1pUb+ZpywnDgZ
	 XVRPR+txQwLdlqSwSwgjtDaLOXnffR1tbfJNLZDhTgUKD7e3Yw05AETznW/H3wSsTH
	 XVEdiem2CXwXSMkBzP2IING/Njo/LlWbqYyIccI4XEG2KwHon9RuKWhsn/TqVpF2si
	 RlvpUjUD9LcsQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so6883862e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:27:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH1y6xpiNH2ysELVwTq68QIME+48hVzHhsctUDcGQT3K/t1LHls8ULHwNDeiQBsLxBNSJgJ2BHlGBkdobQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8NHyYLSdluv3xHe9T1vzacXIDfjbGIUe2QC9uImIHYFltPAvND
	B6crGrHwWALbyOBSaTM1hm1Mc5VTydll7RjmDrFylxcPa/SYkhV6RrTNO3flRVdgRNJuHp3HCoZ
	dC1gQ5luUGIEbcvvQ9uC4UmfZC+ifH9A=
X-Received: by 2002:a05:6512:23a0:b0:5c1:5a42:37ad with SMTP id
 2adb3069b0e04-5c1b7beabfcmr5752337e87.16.1795699621444; Thu, 26 Nov 2026
 05:27:01 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-4-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-4-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:26:47 +0100
X-Gmail-Original-Message-ID: <CAD++jL=TmzH8tm46CvCd1=B_YMyiZM=f1vys_NhDZOM4MdxzFg@mail.gmail.com>
X-Gm-Features: Aa3M54oJhuqbanKDTHMwhtXUm4eQYbQ6svpItwvRIwSjJelTST1VrzQM13SDhkU
Message-ID: <CAD++jL=TmzH8tm46CvCd1=B_YMyiZM=f1vys_NhDZOM4MdxzFg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] ARM: pxa: support arbitrary PAGE_OFFSET
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Malin Jonsson <malin.jonsson@est.tech>, 
	Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nishanth Menon <nm@ti.com>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The pxa3xx_cpu_pm_suspend() implementation hardcodes the default
> PAGE_OFFSET value for CONFIG_VMSPLIT_3G. This has always been broken
> for other configurations but becomes much worse now that the default
> is changing.
>
> Fix this to use the correct compile-time constant instead.
>
> Reported-by: sashiko-bot@kernel.org
> Fixes: c4d1fb627ff3 ("[ARM] pxa: add preliminary suspend/resume code for =
pxa3xx")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212719@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

