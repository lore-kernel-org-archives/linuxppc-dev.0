Return-Path: <linuxppc-dev+bounces-26407-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E01BC624D3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 17:12:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZC8s2kbcz2xmh;
	Wed, 02 Sep 2026 03:12:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788282749;
	cv=none; b=DuDkIFRxTS1q85Q2Yg6bn5rBGjh/LpTz8ZSkyCULFLs/LqCCJ1GfgGt9YXwATmGz2UV8j48QRcEhT/hOs2bRNFmjvj0qo1/o2sB71/2Ap2m5AdH8SQOZUFqwjCdnhjBLVQ9dWURwdjTN4PG+qLP+POWD4Stkogwnsl6yLUoaC0Nk5pT/3fbP0/8orNAUP3EgbPt21xg8vY4wkjIj3Dczx9oz+4rn1KVjeUV5+EgAqyZEjoO7EOcdPp+BqntEPr6yLGa348munyUIUZnizwjQYT+hiG/n+s4J7qt6eNKfr+9/WH+VcMN/m5GjpOa1lJrnP1w0jUHuibX5dxtwv3qM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788282749; c=relaxed/relaxed;
	bh=StaeALLek35hMlcSHa6BZyUhT0ljTsLx6yTS5xCyYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZhFmemlesvcNGGdDRZskVuN4tfLB0G5pgPSnB28VtdIfON/0ETlFEH2/xMoFzaul1/Q4+VC/5iJWhXnr8ctHFqrEc1g14bUP7JxDVgsWXwjwdO6a4tnssQw70ApGA7A7oAkQ7w8Lw9vxpLL+QNb17ECxJIh4fi6JiWhmYYJEq8suaMW5xiySCPjE+7C5yF4OB4g42BQkaJ7ZHAuAtLBMRDt4ijh8ywteQ1gRKF2qIgrpFd1kSP0JOih3KgVaCsT34xgGaTLX7MEm85Kkwu2mik5cM7wzaUbaHR7UMo4IVu7+0CRbLsX3PGCv0n1JvA00jPj8uqIFdQXH0e1pNp3vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7xGurub; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7xGurub;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZC8q1QSmz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 03:12:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECEA9602D0;
	Tue,  1 Sep 2026 17:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D9A1F00A3A;
	Tue,  1 Sep 2026 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282743;
	bh=StaeALLek35hMlcSHa6BZyUhT0ljTsLx6yTS5xCyYM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7xGurub5lZpjDs1aDGfwYQjsUqqlOosQvLNchGQQWzDsAsXjm/bfgFuGkM+2goEl
	 A3tZmuNFbM2kRhPZvh9S1P22IeFE5iiGfDDDDd17F5D804y5rPdv5sEw5oeDGtpjHk
	 8fMhWsj66KRnRGkecbBoYbTDb8JlfScb/+tAumYYrtdivETCM9805zMhAy2jNPFBgG
	 3+rxVhNNGTh6W8+MHuBjYezyNfaAPbKmDaQDJzZEL8uqbRiqCFQhAdUZPRkTUZSKA5
	 Y/Jp66nLB14uDCATCQFaq6J05pPq9ClrATCE9vY0dAVxZMs/4MGJpMLvDMj+NbBsPA
	 VSWBMdQkIOIhg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 509151980082;
	Tue,  1 Sep 2026 13:12:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Sep 2026 13:12:17 -0400
X-ME-Sender: <xms:YQeXarupuu8lP4hODV4Kl4cTBMZRESUvNFli0neseEvSVdU6eTqegQ>
    <xme:YQeXaujYR-JcqcZ5XRB19_Sp4AidO5MknnGtlz5Ss_8D6FAekB1GDKTys9TKm5dQ7
    9-CzIWyGX5yW7Y4wxP7-FxE2PboOlz7Sija6KJsrP8cvzQQUwq3uQCR>
X-ME-Received: <xmr:YQeXapWFsxw_1UNeqnO8z4EZg2oOg-FIVaehIEwbl2C9sTmSY05S5RPiU9I>
X-ME-Proxy-Cause: dmFkZTE95wHRzu4Jku/uqR1uWajKbrR5zJX2cXnYtALksDxTaOWWCUqT0ALShYzFchhR19
    jABbL3NMpQdq2Q4yk1wxABfpkhz1tXbwJ0ETPbBKtnkrOsetjBDE6HJPSHCSzQ+lV8p7hR
    m8B5tw0NCYc8nr5KG+JJnI7EqrKbJ9j/iB4uBQ8v3yh2BnmhuMnsKxLkWZCbcUsikaiaIb
    afOgG11+NHa8fIFfGiaQPV11ZUcZ/PxqcPGfORQq/nrNuM+iA2OtyKWdZtMIzuN7Y+Bitk
    xOhO/HMBDeF+31R8MKrPNSYAO9QueQgK/MZ6ZozJxRSVjUBLpeca5t06PFY2rHErDLj+iW
    2yn2As7fL8DmU2YIyhDqY4qqwa2/ZrsmjL2YjjyNf5Ut5V+o1Q2jHYwdnRpVE4qQekDIlA
    0QFGDvxUI/D1PW8k3h1xG2sm2CMe+07Xc1+6x36TyY7o9SD12A1XaguCEJgvlOl/E4/LPo
    GFNx+zoYsO4VdClgp1h7hc4suTeM5K0X91cofeEj76CiP8ubXYR9unXAMBRmzaTibsCFRl
    htnRbe1HGqYqK8cW0PalkL3qgmd3CH6stsr7YLE6PHlCrh2N2VCi400sm4iXeFTUQOgmsx
    q+kN/77vj/DcD2YNv53dz8Mkn5XTiexA6E9lSNNFtklTEqyElGj/pD/1naEQ
X-ME-Proxy: <xmx:YQeXaiCrGQOdc0DQyRgUDZV_Q7rbwwtsvYy_6612aWm1Dw459aKeLg>
    <xmx:YQeXak3aszLb-RuoyQQti3VDFiBgP4eq84UZpaU9PzzzbGI3kIPqQQ>
    <xmx:YQeXagyRzlL5sf79pX7TX42r92YD-ITwLJRci3UCGMw3KLjWYgQL6Q>
    <xmx:YQeXan2N5VeJKbhgyOObCD-q2vQfw0NbQQLabtDLgtNHoJWCeTl7HA>
    <xmx:YQeXanzxgCScGaao3xUiAb6wqDwwmrMtpplfWrXaivHsO8SbqI1rMQni>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:11:59 -0400 (EDT)
Date: Tue, 1 Sep 2026 18:11:57 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 	Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 	Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, 	Usama Arif <usama.arif@linux.dev>,
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
 	Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 	Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 	Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, 	Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 	Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, 	Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, 	Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 	Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 	Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 	Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 	linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, 	linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, 	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apcFUthh0XSFg3JQ@thinkstation>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
 <apbvoN6ttgHfI_xg@gremlin>
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
In-Reply-To: <apbvoN6ttgHfI_xg@gremlin>

On Tue, Sep 01, 2026 at 04:45:14PM +0100, Lorenzo Stoakes (ARM) wrote:
> > munmap() of 64G worth of THP should be enough to demonstrate the
> > problem.
> 
> I mean you're going to hit that from RCU freeing page tables already, which
> most architectures already do right?

Not at the same rate -- tlb_remove_table() batches into struct
mmu_table_batch. One call_rcu() per MAX_TABLE_BATCH.

> So if RCU saturation is a problem, that problem already exists, but I've
> not heard of that being a problem at all?

I did quick test and I don't see a measurable difference in munmap()
wall time of 40G of THPs. I see ~17x more softirqs, but this is
expected.

The objection is retracted.

We can return to this later if it is going to be visible anywhere.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

