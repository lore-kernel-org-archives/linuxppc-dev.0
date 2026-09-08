Return-Path: <linuxppc-dev+bounces-26787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045FFC79FAE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 11:30:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfMDj0ztcz2y2b;
	Tue, 08 Sep 2026 21:30:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788867013;
	cv=none; b=DUGkMZPdfQmCrJsiPrUO+AWQUZdBnEMiYGq8At5Wh1MVdTFQurN2/zqHp2Dn0WDIqRRj6kHK8RweFhln2kyTGQs+t3Yb7E3XrpWkQN95xRID2+ykAc6Xz5rcYWECkIC/Qn348NIhw+W77v93XGEr8HOZs2rGYwv0o4Xot/5NS8oZLvn4ui8gfLjOg9sgVewv0ccfCeYc/HQUD1DhrcUtqYd5ha1frYAUeQcNbyt31vpkegrjw8oQcbxf9cbYlzORYNjPrnFJlFgF5/BQwbJqHTIKD+ShFZ7t27FmnF6pQ7Qa/E5DEtcHgVjqOIPmNCPupSgGQQThZcYbMvIXs8ZvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788867013; c=relaxed/relaxed;
	bh=mB8nfc2dyoUj8MneI5XtqKUJWAX+H2A9jp3sF5M1qbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2wNEMQw7JNhRTTqtaxx2/NpvPvsYciZj5p1ux+k5O5s+clVpTLDgvwv79+ExDe9xAzxwwu4SLzcyURYDLj/XyswTCLEGwvCkmUKz5nEcbsCItGGddrutcK/k46LH1EQvzup3+8NjlWdgWkp/sBB7FXxHmfrUAT6+cyoKgbR0nlHkEFFSCY3N2yukDovoWxZoll2wxzr+Ow+Nkyck/Ml517YBWjTO9MxQtNv0pyW08hwpfTHSmAHlZzdmp8d0gd9am+Pozz6fzRLY98tXNjZLfJKExAAYMz2B6L1QGYNt48RrxaPEbAPDvt7iQxyBcmt7YCOSXjWCcBQutpb+sLvSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbzZ3F73; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbzZ3F73;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfMDh0lR5z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 21:30:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 74F4D43C1E;
	Tue,  8 Sep 2026 11:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CBD1F00A3A;
	Tue,  8 Sep 2026 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867009;
	bh=mB8nfc2dyoUj8MneI5XtqKUJWAX+H2A9jp3sF5M1qbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BbzZ3F73x9vlPWvAcrfnuEIBJXW3qsffsRXzmqRI35CWZGCBYksgG+FZ6D4aufx7+
	 sEVq9yImHXZGqNWFVp5OCg/tUPoqmbCnXM4gOVpEztvlmpfzA1qGnFHu5hqumBWzdY
	 N5H85H7ubmL/KpLoi3BPX0MUJ8xr61MTWOAacXoR48MSTMJ0Wfiiqe1Y/y4kuLcp+l
	 khOBR7+6+n4ltCTDSLtuvWLW78S/WOu2iBGYFFag5m3jqVXrl0QqQoIKHO1R75ph5X
	 Qb1cRBjIYoRUQrLjUPvWxDGa1pvp8BiecTbRNMlM0odqliUSIGX+UuU4BPhFAXN8b9
	 dTjdPKOeABgjg==
Date: Tue, 8 Sep 2026 12:29:46 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <ap_xj3W3SjsnRBXv@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation>
 <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation>
 <apcJhtvnd45EkjJI@gremlin>
 <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>
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
In-Reply-To: <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>

On Mon, Sep 07, 2026 at 09:53:43AM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 1, 2026 at 10:25 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > So, maybe something like:
> > > >
> > > >  * Note that free_pgtables(), used after unampping detached vmas, or when
> > > >  * exiting the whoel mm, does not take a page table lock before freeing a page
> > > >  * table.
> > > >  *
> > > >  * As page table freeing itself is RCU-safe, page table readers can safely run
> > > >  * concurrently with page table teardown. However, writers cannot, as without
> > > >  * a lock nothing prevents concurrent teardown.
> > > >  */
> > > >
> > > > Instead? What do you think?
> > >
> > > s/whoel/whole/
> >
> > Haha yup the inevitable typo...
>
> Also s/unampping/unmapping please.

Ack will fix on respin! I am the typo master ;)

--
Cheers, Lorenzo

