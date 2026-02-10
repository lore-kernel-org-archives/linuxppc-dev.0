Return-Path: <linuxppc-dev+bounces-16780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD4DEA8128
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:50:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9PcZ41nGz2xN5;
	Wed, 11 Feb 2026 01:50:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770735022;
	cv=none; b=aL2sxtjBzea/AS5BSG89WvtVf+qVX+5c9dgJhp43rW6XltG9qk4rU8dOzNfdlwDbyTFX6wrrXXNc3OplgVG0YvMvyJu5YmU7xyil7LA2DCKLywHIdP9+EaubGgIVCGXixYcd45XX/vKADqLCgj3xKv1oZlQj6zGUKR7NvJMDxzTkEAzXEZ4+VZXWSFIV0eHc9auYvKWn8plBjGCwdaYDq7hPK3DqN81Pec2993myQvUnLJhN2yXYRmHLJY7BdNbFi1EXEbj39AGnjADr7cfCp2d+rqkF2DxHp2MTItvdzGZJX5NeVgOGHiF8F6J/twvbt1sbVN/wxiok8WheQKyyag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770735022; c=relaxed/relaxed;
	bh=jNWP9iqlvwh83wB1j0uD2/DZwiUKhBK19x4095q7W6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlZSMbdEuoEHh3FuCoNaDTh7nUq+3PpSAB7Egly4AIv147yvv/s8gztKQdlw9W1+od5MR5IWEDlG+j5ThSZUPGl8UjxAReB+cCaBr0p4Ci7GXJi15tpMhtjtKYw08kQtbFZTDH3xt6JqiyRFtYe+v1RXBkdfzKIILqKt7GEqSdrymcBeDv+m8J72IRru1NzB31455OUGiuxc+73i9s2dB/2FxvAAl2vMQ8YQdRRI884dzJVssjsMr0vGiz7c6IRpYftlHjP1O1UPmvy2k7buypZW/DPuWB/G3n9CURFtBt2D+ESamB4DDGnXuNII61hqGatWCvOT84VOunSo7DA4tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W3ex2H+6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W3ex2H+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9PcY4y0Xz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 01:50:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BDB860137;
	Tue, 10 Feb 2026 14:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E02CC116C6;
	Tue, 10 Feb 2026 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770735018;
	bh=YqNhqDan6ig5Eg8FfWiJBfgfNLXjdOvNf1vIcFRh5H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3ex2H+6njMxfdkQtt4hfXP8xNYoYvUybMgCjkdXkRHCgKGQQudxPVj6r6Yq4X87J
	 qKQk4SPbkNxJjifgbRHYB0LIbaEKgNT1q7EAGZDodtYWpYtXt+PLTjreRRyYh0ZuB+
	 0XRCg3HQoTLA4LhyIdFuLZzdVr/SSw9/Ndr1QL+8Jlw7RzN+PIW/LRCopkpQH6Rwal
	 J24gsB2JhUZnmKMnS2yaIoTinVPtyDQgj4UHrG750qhTNlhIvb22kewZVjFgo8FCOz
	 fm9CerA5/tgkSQquoEeuWIQfz2qcaZ22uCaDVSNGjTWlgBnoS+i6Uy7a10vU89BO1/
	 TkxTBVLkg+EFQ==
Date: Tue, 10 Feb 2026 16:50:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 2/4] mm: rename my_zero_pfn() to zero_pfn()
Message-ID: <aYtFmCQQMYkZh7Wh@kernel.org>
References: <20260209144058.2092871-1-rppt@kernel.org>
 <20260209144058.2092871-3-rppt@kernel.org>
 <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>

On Mon, Feb 09, 2026 at 04:08:32PM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 09/02/2026 à 15:40, Mike Rapoport a écrit :
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > my_zero_pfn() is a silly name.
> > 
> > Rename zero_pfn variable to zero_page_pfn and my_zero_pfn() function to
> > zero_pfn().
> > 
> > While on it, move extern declarations of zero_page_pfn outside the
> > functions that use it and add a comment about what ZERO_PAGE is.
> 
> I guess the idea of the extern declaration being inside its only external
> users was to ensure nobody would start using it directly, hence bypassing
> the overloadable helpers.
> 
> Should we at least call the variable __zero_page_pfn instead in order to
> warn people that using it directly requires care ?

I'd better move it back inside the helpers.
 
> Christophe
> 

-- 
Sincerely yours,
Mike.

