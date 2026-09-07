Return-Path: <linuxppc-dev+bounces-26692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C8BC79FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 16:54:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdtSn2d8xz2yCr;
	Tue, 08 Sep 2026 02:54:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:34::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788800041;
	cv=pass; b=EJWrPTpZpIYI1niFPFWjQpS2LikQdtMZuw4KAVrcGGem8nPMGesWKf/JKbciyqCflv+LKJJ1kwv5/buUk4f2KW52fe0ZT3Hns+NQTrkJ8fWYRRlkoeUyHvxuo78k8rJBkL8lTJa8hpKTCXpTcLGv1Iszbs7YkRQW+IZdF/ZL4tVqSxJs12qteoldNLCT4zQn+HfeGXRYSfTDqPgS3FU1MFHBDSxzwe731UiDrBFUod6PNtivdzIqSiZkHSgIJeRAtxkHfzjTnhV6NxpDGnYVp452PSt4ZF6GYGJKGHhqoRfCDNuPlozpRe4cN1MS0I5T+OYQXh/EPaIidKxMG2A3wA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788800041; c=relaxed/relaxed;
	bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nas1YBvNUybL+fQCoAn2Ue8dWxMIWe0XwxWmf007O87FlfOy92rMrlYdSSIgYdjPPLcJbMgtrStU+swWbhQI/uOmRsFQcE/KqP535kgGLsmsPYaqXRF2Crvc2lMG+GXveKkTkjX0AMNyh+ERLucnayHVbVt+gdq6QtyOtpOXD7aZvy/WsvLVPkjVSJLesfyBDCpH6I6Aq5Rl36dICITxR9hIC1FNHI2iiPHJKTEHR4qEyqM5TzAq6j+U4o7Yts6/qombqIbwuReP4snFpWHu/vWJn8yIlQAj9EBo3Burdy4FS4mpenUf4HbIALOjOsRbGiIkHj+MIN1j9qhOxY8S+g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uVdTUTCX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uVdTUTCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdtSl4Mcmz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 02:53:59 +1000 (AEST)
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-530411c7ee1so368621cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 09:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788800036; cv=none;
        d=google.com; s=arc-20260327;
        b=QsNL9LaBnh9DJ4qv53AVQsj6xTf2e/ic00J08NldhWqWMIdtVzKS+zZd+2/1jgid6K
         IoNe5jbk1fE0H1/9L7ARmEjXMamOCBxn2qD0em6c+FaQ0+B9si53dsnuKSKhLdviXk61
         UXKn9lD7+UaIrXNM6lnydcIAQ0d1j10Wm/uE5aJVOGhqX6rVnM6MAz2nX+IzeulidbA9
         TuCMN5mtVQ49rR1dVsaRr9APDrdy/bw2RAJXdSiqpEPbU+pwiOTCsi5lJS5oyPtZemMK
         bFPUEnJcLflkLhsg6wU+qQGqZAO9gBZFDLh0DmHN65oyE4WeEEG1mk4NEjYzYtOo8go4
         D9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        fh=w8FdLFoi+CqdpERLhwJ0wfRtbGmag0bq/4PjsfTCueA=;
        b=DuVvxuF5tAtUfml451hBQ7dJWUk+s2T15fsQtq023RrenJBY8JWT9h8IZHiY25hJ8Z
         KWrgCAtUIcmzW4G1wfOvYRW4wxr/cOfOp//zFpACyOZo86o9m1Hj3yN+KdcX7BjMjris
         1jxB1F+fnF5o4Jomrh/0Dlkp1eFPKVhF/KMgdd+f4ogwzyuxyq0QAHpcBGyYeXP2BuAj
         D1hwvbUEWN+ok08iZl49bHwD+xt94dSidQG16ef1c0frONWSrwU5tXqQiGOOQ1fBlyyG
         9n1wxZunoPbXM9j7a1RJUXsNYuGw8uvlWtx0kVwi7R5Yt/4xS51wv9WxgYyfvIVEzmS2
         CatQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788800036; x=1789404836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=uVdTUTCXPqeZa4jtN9qPPAhqSLQ73q5Y4GRFp4J8R/thuKHtJU+GrLH+IG9LxIi8RL
         6ZF6ltFQjzxT4iJ8N1fml6qRtC4UtFS8T72aIhisY+2/+L94rRP1wgO89AxGnnx92pOZ
         wMkOiEG+Ef+EorwsbBLAEOLfKXS+CUu75Jv0yFWDTTsADkdYWQPX/vcIIPBdvrWg6R1T
         BkMfORP5QGDTZEMnSf3BXDj7G1FPuy+yv+eH60WHxauU+qk2JsLboIm2yu+sTN3niSht
         xNpeDLLFVb5/beMNiToB6D0tQpfLBdwCWagvnGsVQcphYYUd8FizzZBAgeUtwn/wLRWi
         P6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800036; x=1789404836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=NYcKqgMjOF/F0HpM9VwJsxM1Mdt/ApVMIodoF+tGqpVxg+eSsCzaeGa118j6O9Eu+t
         /dNKLU9ArR9Pg1eaxetemietz/FErFGvIWHCUQd1rDoLI27surYhpZgimncn12v/RanN
         uUycROnMJ1/2R1B0vIg3Qticsnq+yTSeh97kqQ6k+gbTbfx2eKD/xuxcHKmYjWlOf5Ez
         qdt4GYFLe4lFCQFj1rFKmz5r+KsedYWoABfGrIVdI+SpW7JsVp4UDFrly2pNIGE1zlso
         TaHXC/uNAki6LZWI3hVupK5h4pKuBZbxu5NDvNNBbOu0fBQtGHK6S1zdDjM7Jy8iUSiW
         Pu3A==
X-Forwarded-Encrypted: i=1; AKwUvBy9YMg9fAhKo+cqk2OusXLi6gZAYdCTp1AZIWdea5ZTZc511iXbcRDDIVC+2Eb726e34XrHIOWvMWlRAIg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nCCMdtKV1V22tV9L23mZYsGhk5z0cbpKgzYl8S9HuGJs1pD8tE
	OZtFwaNrH/ZiF3+BkIexnJdTYApNdndRY/8qA4c2oHCO+TYQNS0WObUifnVAVWHlXojlo4KqRXk
	v3d1ajefJR1IvY3bHriBWcj8rtUkvsHS890K3i0C8
X-Gm-Gg: AYBFou131JapMfFZZPUWtSafUUL8fZ7xcDV5yGCTL1NJflh+pWJMu9ObdGgUjQ4sgCL
	kShFXaadz/pDrc3ZmnmD0ktw8lASedC6VT+O02tcFb7PNn2bChRE++deHT87hiTgcy7ssdcY8JU
	2XAVFvwLELNBjRF8KUW1SBWFHydTJQQbdwcflNdvE1nmA4be3EhEqpQ48iwd+xGHIVCtWcdEeGo
	+r7VkRDaTW7W7714sDXpiFZUaMC/UI+wlBKrhLs3He0P1sxX4B7fS+1SYctNLLYVixPQFKRPJp3
	t+VG6Y1qRFs1GvvBvnfSUyOKICIRK6+UIBPN9yndoIg=
X-Received: by 2002:a05:622a:28e:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-530920caba6mr3560401cf.0.1788800035234; Mon, 07 Sep 2026
 09:53:55 -0700 (PDT)
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
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation> <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation> <apcJhtvnd45EkjJI@gremlin>
In-Reply-To: <apcJhtvnd45EkjJI@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Sep 2026 09:53:43 -0700
X-Gm-Features: AcwNN1WRGdFWOzxEbOcmfkztqDuQQAGpor7Xm60pdWlD2DjKNo1Y7S4S7DNXdgs
Message-ID: <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(), update docs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
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
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Sep 01, 2026 at 06:15:17PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > > > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wro=
te:
> > > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > > index b91b1a98029c..ff8ff3706485 100644
> > > > > --- a/mm/pgtable-generic.c
> > > > > +++ b/mm/pgtable-generic.c
> > > > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_st=
ruct *mm, pmd_t *pmd,
> > > > >   * be read-only/read-write protected.
> > > > >   *
> > > > >   * Note that free_pgtables(), used after unmapping detached vmas=
, or when
> > > > > - * exiting the whole mm, does not take page table lock before fr=
eeing a page
> > > > > - * table, and may not use RCU at all: "outsiders" like khugepage=
d should avoid
> > > > > - * pte_offset_map() and co once the vma is detached from mm or m=
m_users is zero.
> > > > > + * exiting the whole mm, does not take the page table lock befor=
e freeing a
> > > > > + * table.
> > > > > + *
> > > > > + * However, the PMD entry is cleared first, and the table freed =
only after
> > > > > + * an RCU grace period, so a walker that mapped the table under
> > > > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > > > + * pte_offset_map_lock() detects the teardown.
> > > > > + *
> > > > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > > > + * pte_offset_map() and co. for VMAs that might be undergoing pa=
ge table
> > > > > + * teardown.
> > > >
> > > > Is it strictly true?
> > > >
> > > > free_pte_range() clears the pmd without taking the PTL, so the
> > > > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd ge=
ts
> > > > cleared right after.
> > > >
> > > > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > > > pte_unmap(), so the table cannot go away.
> > > >
> > > > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > > > retract_page_tables() don't rely on this recheck -- they take pmd_l=
ock()
> > > > plus the ptl and do their own pmd_same() under both.
> > > >
> > > > Can we say walks are safe and leave the write rule where it is?
> > >
> > > Hmm yeah, ah page tables, what a rabbit hole of horror :)
> > >
> > > I guess this is effectively a reflection of the 'write lock on write,=
 RCU load
> > > on read' pattern in RCU itself generally.
> > >
> > > So, maybe something like:
> > >
> > >  * Note that free_pgtables(), used after unampping detached vmas, or =
when
> > >  * exiting the whoel mm, does not take a page table lock before freei=
ng a page
> > >  * table.
> > >  *
> > >  * As page table freeing itself is RCU-safe, page table readers can s=
afely run
> > >  * concurrently with page table teardown. However, writers cannot, as=
 without
> > >  * a lock nothing prevents concurrent teardown.
> > >  */
> > >
> > > Instead? What do you think?
> >
> > s/whoel/whole/
>
> Haha yup the inevitable typo...

Also s/unampping/unmapping please.
>
> >
> > Otherwise, LGTM.
>
> Thanks! :)
>
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
>
> --
> Cheers, Lorenzo

