Return-Path: <linuxppc-dev+bounces-26392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72623C624D4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ6r46Tk9z2xmh;
	Tue, 01 Sep 2026 23:57:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788271060;
	cv=none; b=ZPL6TYTnlQw3UjJEsJfZt/gLpnbZtmUWKBJyTM1/kLaJ6+HqhE7nSjhzOE+qKkBysS5WMu++UFK9TvGEbPSOzxBi/E1OfCHj7p7wMzlOtj0esDj0/KSx6dNaPcHhqpNf2VL1PxvGY2048Jxt1DN7HeRHQgKCmaIX9L8L2aFTmR4wPO3I75i7fUmBA3qDYRSsrCqXhAGi38nbt23QqIXgXOGpYLUoqrwBNv8fQ/4fl57uLl6GyTu3x09/uc3G+262OnBTEz+Gzz3GiANaFdjCKvMFz9xgrgyyPVftIZ7dR8X6H4oirrtxKuKFB2yR1aXwfLGKoUFuB2hFE7Fa068GAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788271060; c=relaxed/relaxed;
	bh=agwo4ogI1pqxdy5iNzHZWMq9fgC/4O+9PRQpyNWft68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLkx672hfhkKCk6nUdlvvbL1IK6VrN73HuuC/K6mE3ME9pNzxZsctw7aZjmRldzB1lwL1BRcRV8Ce+0RnGPRbyjLWwwGtZDOqV/+JNvorV7zfHTaa93enI2LjfLcZShCYPVnguRQWlp9CRooyK5jqvM8sq0WkGFLSvc61zOyEvLxwHMZLaQKnZ7wNb5Ad5NyuPx7W6C43QjQW1gqAszn+395MAIvoaSitjCYHTnTYKmUlSczuFpj6DMvkDwkKH/89q7bkPXzUwnA+wmc1/fpUTkgMX3iyRkMSD2kBTQPrw/3FkH6cIZNPj7pC62yYmf9WSB8P1sQJX/lbfwcFUel8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS4rdcUp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS4rdcUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ6r34m9kz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:57:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 990E86020B;
	Tue,  1 Sep 2026 13:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373E11F000E9;
	Tue,  1 Sep 2026 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271056;
	bh=agwo4ogI1pqxdy5iNzHZWMq9fgC/4O+9PRQpyNWft68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dS4rdcUpDtk8Sxb6szCUyHVMgnqIMqyqpcKWrox16EEMjkbKRtQlJfHH3ScwPl9Df
	 8Bpk1Yp158o5ETXiKdRtjpMp00YBbGIKPgAmYa3r3pJQXT5wQA0QFgCem36VeMmzEO
	 DGCNA582vMONWWT3CX2Y115OlRDxIuJYmuoHfBJLB/AqlYVFsvPh1VYiu3Idu0ZOQG
	 DpNt+Ix6vcgc2nH11QOhjJI5P0VdXTWCVr6YpiDkIEc5pET6YRCDLPjZftlraZICRC
	 hpX7PdJTrmQy3/x2Jnc+VcuDMhItR8h8J3kz3Gvw7Q1HJ9EzszfFSy31p4xhOlRCwz
	 NGCGbK5IuImjQ==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id 177151980075;
	Tue,  1 Sep 2026 09:57:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 01 Sep 2026 09:57:31 -0400
X-ME-Sender: <xms:vNmWahMoRfGHJylVp69tkl0ZxHuyu14twTOMSzDVmUdqODOOFCaOUA>
    <xme:vNmWamC04sA7HLbhLFXFetRTQirQ4BCq3h9mf_X9eZoWhHHweJXfeNQnDFEkN-eZU
    TNHprwg5j4bwG2-RtgLS24xR65NPMHQ58PhK4w0lkjNf7M__AtigCJf>
X-ME-Received: <xmr:vNmWaq3HcGhSb341ukDeOtyXnIIR93_LM4ZWQrR0RvGyHQIkedHYy9DG-ho>
X-ME-Proxy-Cause: dmFkZTGhE4xc2F35+/cH9QWJSP+T2sSz31kKWkLnMEla92oo5cnqKuXMLiYgktGt0fz0/P
    1nAHqKz2XC4RLt0sZBuXgNoB+I3Lv5/lZeidGsyd69PUr2tNaXTbLl4Hq1jVnQD2pxKsB5
    RUmimEN9ymjBpSBDK05+FgJk8e63uei569IciHBQw1D9FCH5SBdcJBtIvv01IcUYKhgTIS
    f90WviMk+GkUmSBdkywQGyAi+Kb+Qs4cZvbCzXW86phJx62/9vfGS9f/B1vGm3MjEXgufi
    xD125CxPznssp42WHeX1rGj2+Px0NTxJU25KbS651lVg+nwXVCAiD9QMRn4oxFx34KkMYx
    /ylDM1rHu63l41H8z2zMGbuFg+bbu5OoPfGY964XH8pFkw0h2B5akZ5tb7ZRd15sBoxvJ5
    9ZPlIQHmBss5JGvVitt5oDAdab0/sDuOhYj6IGcWNKZc4l5IguhFNv0eBdiZ2XkP48/xyz
    q6bQQrm1dnGYKm/bGEuYX/jvKq3w6ZA5D0pVnRf58fwOUna5/8IR1fgu8jrX3MTvyrkxwQ
    2WRtxks1DmwJsWM60SDXg8t4yPY+L4AyFb79enpcuanRGGerAd74MDz5L2Upjp9/rU+vza
    OvhtVRTr2CvEdlW0VE/ceLVnrcS0aqrnoB++f7ZsN6y8Joe2E6rYjhbsCAXw
X-ME-Proxy: <xmx:vNmWalhfMApERZzjpc7TJG7GtCgdX_4w67qtsX1G62pSARN2GZWDIw>
    <xmx:vNmWaiXm6FAPUBkUzXVBQI0eO7tHb2vPP-rixD6Ad7WIkQTws5E-Kg>
    <xmx:vNmWagSsKBNh9mcPCUFna8QpbE6wA1vVhKB8VhCwB5se-N496qRphw>
    <xmx:vNmWahXZHR9XIJgivKj91oeRT0NDLSv9qe3xafv6It9647nhJIe3lw>
    <xmx:vNmWajSxgwuhyjaLfEEt6Ejf2oTMeCpXSZHSN-d4vScBLmiRwr-9557Q>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 09:57:14 -0400 (EDT)
Date: Tue, 1 Sep 2026 14:57:13 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, 	John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, 	linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <apbUpMDJglS99_yK@thinkstation>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
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
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>

On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index b91b1a98029c..ff8ff3706485 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>   * be read-only/read-write protected.
>   *
>   * Note that free_pgtables(), used after unmapping detached vmas, or when
> - * exiting the whole mm, does not take page table lock before freeing a page
> - * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
> - * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
> + * exiting the whole mm, does not take the page table lock before freeing a
> + * table.
> + *
> + * However, the PMD entry is cleared first, and the table freed only after
> + * an RCU grace period, so a walker that mapped the table under
> + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> + * pte_offset_map_lock() detects the teardown.
> + *
> + * Therefore it is safe for "outsiders" like khugepaged to use
> + * pte_offset_map() and co. for VMAs that might be undergoing page table
> + * teardown.

Is it strictly true?

free_pte_range() clears the pmd without taking the PTL, so the
pmd_same() recheck in pte_offset_map_lock() can pass and the pmd gets
cleared right after.

Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
pte_unmap(), so the table cannot go away.

khugepaged is an odd example here. collapse_pte_mapped_thp() and
retract_page_tables() don't rely on this recheck -- they take pmd_lock()
plus the ptl and do their own pmd_same() under both.

Can we say walks are safe and leave the write rule where it is?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

