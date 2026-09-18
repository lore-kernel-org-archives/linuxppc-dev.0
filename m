Return-Path: <linuxppc-dev+bounces-27686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA26C88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:44:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmR4t03lJz2y2W;
	Fri, 18 Sep 2026 18:44:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789721069;
	cv=none; b=oRK9wqfYVVfwLSWYj1OGDgK+s8Sna4zRRNTnPhSEwrRrymUs9rUJsOlpFfvBoS2vVkBmCOGfPwe/Yh0mtmxzBr7Nu/zoq+O30tsurlcccbDFZBtu/B3djprLSn3GW2pRD2mRpTWcxIY4Qi0G3eCmzOLP83mQynsUhQ9TeSTz7jZgIfZS8nRy5SRLHDK1YxFcuSZP79axwHV7jHrRLNPF/d6nZ20Lw9XzkT3EcCvUO8QbLLZePlOnNzlcCCOrCWGk7IeUV84/3C0B6JSyXQvNqNQZDV+H+9376STMlGNID6dxOiPPC4Iep4sJIknDjmSy3JUXs19XR4wAmHYzDNFgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789721069; c=relaxed/relaxed;
	bh=yfptLJpLwa1HkLn6r+lnBSBB9zhrI022aUyQ/n+iqZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru0RIElcY9YwzQbl04FQ8T9p1eIwfQGUyySrm4EejNEOhcBjyI/7u3PEzIfy2yLC1pAN7Jt2qwNCnskgmf779DESTvYN8Z+zlQmNyUufpNW0zf3TJATo65eJdFc3b/kblrwHYU2gstJTVjte2ZW2BS3cT4ldlNMCGVsmP3bjBMTXJXakwMI+/FiWX8tYbNrnUlz69+t1HqqP4XSMfgGObKEj6x17KjhTXOfrkNmWeNNjT1wWYdAX4VOnJMDMx/29Ic7xwQWAW1YGxIze5HeRpX9Vve2/gAxBNSGNPOBDaK57e5RhbJ3sfnNS/Cf+SNMpuXId4KjK9nLl5CtFUV98Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKQpoPYK; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKQpoPYK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmR4r71FRz2xQ7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 18:44:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B056960A65
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 08:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6767D1F008A5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721065;
	bh=yfptLJpLwa1HkLn6r+lnBSBB9zhrI022aUyQ/n+iqZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WKQpoPYKtLvvrsANllnpazyBLjRD4QmuKuAgFZJ+R23L2z9t4yAN+ACJErx1PPLcp
	 YtolKadJaCrAtitOs8awaYY/VMbJ8Q6/L36/H0qNStZMmY1edyfG1bkb+dO8M0daCj
	 25bn53UilLvQYI1zKM5frfrxRWf45TEef5EH/K6kUxnvY0h3OG0YNQ241FqO+AVgh5
	 /1vNxD6Ah+KlqPlGnrXYjy62/4wfCjSsu3CmlZ2awkanq/i4MdIQk5y6nr/N5thZul
	 tzkhmvRWaSDcQUfWZGzo2paV/vNvrN2/R03Ja6OCm+ttH82QbijLXDvQ6H9U3Cp01O
	 nYQuqkIXgMEBw==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso53924385a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 01:44:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwmcdY6NJABnVeJKl4O/3Wasl8R0gRnz/uXGJ4q7OvDWIq9Xkf0ro8738cKIytZxbKd0Knqma+ibmz6pMY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k3i+nPL9Mm4SZTm0g95LOS1KDo9AE/RTR7V6vj8mpuH9sqZ8cL
	2dlumOSPhDrXMmSKdHO76MhmVh2cqnaQo+eEtgz8WQm6qrA60oOcnEBmOiWlRK13hBtO9c80QL7
	5q6saPtJWpA+vzkUwsiIxyw/F+5IRexM=
X-Received: by 2002:a05:620a:280a:b0:936:dbd7:fcb3 with SMTP id
 af79cd13be357-93bdc6de89amr218538285a.21.1789721064703; Fri, 18 Sep 2026
 01:44:24 -0700 (PDT)
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
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <20260917052933.188679-3-jiangwenxiaomi@gmail.com> <58e3b456-7389-4752-8de5-1cc82964c3c7@kernel.org>
In-Reply-To: <58e3b456-7389-4752-8de5-1cc82964c3c7@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 18 Sep 2026 16:44:13 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wKG91hd1Y3W4mbdh6B8Kq09JyDjyvXeeCmQj+L6bHm2A@mail.gmail.com>
X-Gm-Features: AcwNN1U1UKmWK4_bdU3CXRYgsAbkO0CRi4o48diyrNchNw7WdNKVQp3kHhkJ8xY
Message-ID: <CAGsJ_4wKG91hd1Y3W4mbdh6B8Kq09JyDjyvXeeCmQj+L6bHm2A@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] powerpc/8xx: add pte_set_huge()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, david@kernel.org, dev.jain@arm.com, 
	jiangwen6@xiaomi.com, leo.yan@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org, 
	ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:14=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 17/09/2026 =C3=A0 07:29, Wen Jiang a =C3=A9crit :
> > From: Wen Jiang <jiangwen6@xiaomi.com>
> >
> > vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
> > by reusing set_huge_pte_at(), a HugeTLB helper gated by
> > CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
> > CONFIG_HUGETLB_PAGE=3Dn kernels and couples mm/vmalloc.c to HugeTLB
> > internals it does not otherwise need.
> >
> > Add pte_set_huge() to powerpc/8xx, next to the existing
> > pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the hug=
e
> > PTE and writes it into the backing cells directly, without going throug=
h
> > set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.
> >
> > No pte_clear_huge() is needed: 8xx does not implement
> > arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes th=
e
> > block-mapping branch.
> >
> > In practice PPC_8xx selects HUGETLBFS unconditionally, so
> > CONFIG_HUGETLB_PAGE=3Dn does not occur there today; this is a decouplin=
g
> > cleanup rather than a new configuration.
>
> 8xx selects CONFIG_HUGETLB_PAGE because it uses set_huge_pte_at() to map
> kernel text with large pages. That was added by commit 34536d780683
> ("powerpc/8xx: Add a function to early map kernel via huge pages")
>
> But now pte_set_huge() could be used instead in
> __early_map_kernel_hugepage() and then CONFIG_HUGETLB_PAGE could be remov=
ed.

Hi Christophe,

Do you mean the code below? If so, it sounds like a good place to
clean this up for powerpc as a separate cleanup patch.

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 2518d2a6bdb4..830cdb391161 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -87,9 +87,7 @@ static int __ref
__early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
        if (WARN_ON(!ptep))
                return -ENOMEM;

-       set_huge_pte_at(&init_mm, va, ptep,
-                       arch_make_huge_pte(pfn_pte(pa >> PAGE_SHIFT,
prot), shift, 0),
-                       1UL << shift);
+       pte_set_huge(ptep, va, pa, prot, 1UL << shift);

        return 0;
 }
diff --git a/arch/powerpc/platforms/Kconfig.cputype
b/arch/powerpc/platforms/Kconfig.cputype
index f0adbf7ecb7f..efba4d960083 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -41,7 +41,6 @@ config PPC_8xx
        select FSL_SOC
        select PPC_KUEP
        select HAVE_ARCH_VMAP_STACK
-       select HUGETLBFS

 config 44x
        bool "AMCC 44x, 46x or 47x"

>
> >
> > There is no caller yet: mm/vmalloc.c is converted later in this series,
> > once the generic fallbacks are in place.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Best Regards
Barry

