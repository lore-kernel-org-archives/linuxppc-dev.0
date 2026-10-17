Return-Path: <linuxppc-dev+bounces-29624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705DECCF2C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 12:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6LTP42gTz2yKp;
	Sat, 17 Oct 2026 23:19:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::830" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792239561;
	cv=pass; b=hZCUSgyd4i4wlhZ11G0TPsf+v3696N7URaFOJVDGzbQK+C70NyRwYafzDUXoMCXCqT2Usz0XiDoI7kApmhOkG4haVfjeK6GSm2+85YSS1xGxoE+YdIZC2qNJWcJrrh7wlsBRQWEzroSEX/OJ+7DghGPJpjsY1HgSeek5mMVpbxDYwFDSZ1nNdDkMM8G0z+lo/Ihb4AVCmijFs2ieB34/ehzHgubPkAPfxInjpZtMxJHDrU+4o0XUfcyXqytiRs0Qea/EDLIyJoSn1yCGxjvS6URH8WiX+n0ATYSGJNHETkO6s5picu4fw1ahTIYc20PB1ARR4WpEOkKS0H8Bhx3Irw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792239561; c=relaxed/relaxed;
	bh=wzjdQ8KeLOKPpUHygxBJ7WOEjFu6Ph8LRE3nzk8raOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhDyRwarQoWUfSQqBonsMPCA9nq8fgYRnT4Y5cVv4CHOFTEcLq9YWbtOQQMJoftzrrO6pqL/a6g9w7FmWTO46YU2S5Z8R6+zQ18D122VbIlhfdEoPgGsiVfgJNdCvGX8O/euoSGx/i5fWBjaaDif67J8A64M7njMcEBM5JZmA/coBk+s0El4xn8lRo86O4ur2FqcdQRNe2zFiQpf7GjRcOq5vNJ7ArsmfDpIkDDd2aGbF3ugZ9DhhgEMXrV312hOvAHQZh9ut4YBY1woWJH9Wc7CM7dxu++rf/n3Zyf7wAoL2OyMRS0NtzjV9qKt2abhRip7jOM0ZbrT0f+u/BB7iA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FZZXzxMS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FZZXzxMS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6LTM6NTyz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 23:19:19 +1100 (AEDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-535f598d126so102291cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 05:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792239556; cv=none;
        d=google.com; s=arc-20260327;
        b=Wjv9eswO+eHkdYXpkglEBk/RVYD0MhcEmgFnbc832fePaoAjD7KfKYa3MxLGCmovwa
         1knyYu6wnzE00v9+28uZQNwBe1XA3itnugpXox8kA4vzVLR3PYrwLTq0ELoQgAJq7Ewf
         7KK7wU9qZeHtjNnPiAxFVt2hGTVJCcuLqIHS9JxDitovpM95mjsa8GhASw+aIdqQjUTE
         KDdImAE9I97CWw6y7w8pvdBa8Y8wcadF+/v2/jmEjx/p7D47spw9sgaHHGB8omftZZDk
         riQNPaE6huB4IY5LJ/xxDt8eDV8BAlFLt5LapwQQ0GN1cezIDocwMv6rLXfGGuXS7Pa8
         2qKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wzjdQ8KeLOKPpUHygxBJ7WOEjFu6Ph8LRE3nzk8raOA=;
        fh=X+lHUKzElRbqWdtHeWqJmgE3WQBcLJUF53PCBzrHeX0=;
        b=YTiPay7DCLwJuMsD/kyiTskcPwPHwRhiUjfiyCdHFjbX6YiAEdDENdPNvVEdbG5XqA
         +MgteBjMhdTUSkSNvtVnUgAskpcSnniDjezKC9sgbErzfh19KQ3/fgICm7TRe/caWYsn
         i/tGNb43sOP1l11dcUJtVzAaiCrBNPWpUbBkzlmS0wOWbaagu23XKXQI+Y+T8+3hoXbT
         14/9V9+rsNGkzZ3o8tdHjOMy3/atQbVuAgqhJm4lA1D3Wt6OTC08ngdvXntKLy+dvYx1
         QYVYC/3WBxqKxEbF2PLAkGZz5s72SXeOtWvB+U21c0z6yaGWyNFStQJUVRUgjtWIRFB8
         CzKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792239556; x=1792844356; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wzjdQ8KeLOKPpUHygxBJ7WOEjFu6Ph8LRE3nzk8raOA=;
        b=FZZXzxMSTOoXCgTKAfPZdqT6nNYg8lCWUzpd8ARsnAdWOSanWeEhkFHBE3hnKfm1Zs
         lV0OD5DVDeLOoNmUDpZs/UIryE/T888VfShSmVvWmBeFgCLx9dDHvQtpBaK5uxVz9A7q
         a7tMGgY0DCmKCr1eFBDOFT2y0hzlffiH49iMPJOX03nxhWRnHqmd8elxvUrYUSrHsJWi
         0X8IeaOO07N9pEWn7Ve5QxNPMoKhetNRxw7+B6twJf8nNgV96oZeHYD7tK/ipKc7LDJD
         FVIOA5HtBKZjsLieGRan4T1o/6tXdLwn89QQrP+T1Hjhh5wwoEeeXB/ZW87pV3qFwskZ
         Xrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792239556; x=1792844356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wzjdQ8KeLOKPpUHygxBJ7WOEjFu6Ph8LRE3nzk8raOA=;
        b=jyF9oG8ZqupTKHMO8+a3+XOR6lD6+SmRFu6euUS96cPxSJJev7m/n3Ue7/lJB6yMsZ
         P5JU6vMsPRKofxCuYE1azhM/nVnT1Gkz9UxbV1Qbmq99ZjPd3Cr79212JMif754BXild
         kcHlDB6n13pyOe1BNfQxOa5I8DzWXl14ENBH6Lzv/9bCPjiXuknq695vOKcIc+4bsCHO
         gjr8MkoV3RUr9VOPilUCm9oNuuO+J/l5JayJRCGgsyKsKJEWZty9ohaWDB/ZZ6YfrcJA
         4fgoJqj3r5tsoaX1+sZhOjesUZw76L4/PRKclXUewtOER997+tlYT1nFlMGDc/RFtaae
         bCnw==
X-Forwarded-Encrypted: i=1; AKwUvBw/3LAZO8OzaLevqrWuF3iPsW8oQo4cv92A7i6v1pwgjfL72Dr2C1jW3E7ZVTxj76UOMZSpsiTIgegGBsU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKCHwtpdGpMGyoVSWcrKsCUZtLu6xYRWiPNzmrE3vyPJA6lnKTB
	fJETq2CIwK1JwKXFGppZ/vPr7MpIrsAH0nWp7c2WxeRLd3305wtmcx7IQFCPvlB5aa+C1qxh9us
	kxngc4dWXYXFOrNbBqTIaFdWquK3t/VRFSyveV2PQ
X-Gm-Gg: AYBFou35BcColFgsSe8TSNp+tVpvJnXxoR7VaeYzg+XdOezuAkLgta17mkMk9rvpA2I
	7S1tHb5emC+CjaYE8ZOQG/rq048kNom6W3mIyyiLnx1L2xFVgJ3NVbwBTZGwwuX07FxvtQUMtUA
	hP8gdwodTL15lqeDlmTJvCzMWBofHqnVYHdsGI4k/Pvcbezsw4rzA+ZgzlDTnWvapn5aPP9FErG
	W81pxZqZmrcnxUawHTsBsNA9Sqni37bc655pCaVNcLEnt7w/V0o2QrQqzX/E9ILyqIgQmiYhrZe
	MXU+tRptwLr0dOhKciRvAEYpvojnw0QEwah6aSLFfYPjm9p4IyCAJ/3z
X-Received: by 2002:a05:622a:aad1:10b0:533:9746:9a86 with SMTP id
 d75a77b69052e-536499e8967mr8164001cf.5.1792239555029; Sat, 17 Oct 2026
 05:19:15 -0700 (PDT)
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
References: <20261009063619.112313-1-hao.ge@linux.dev> <20261009063619.112313-3-hao.ge@linux.dev>
 <CAJuCfpE9VfgTw2ZNMJTEVh41H_R+1RY_MtzeMuZNCD3BFm-Piw@mail.gmail.com>
 <as5epHFQF4iE_VQK@pc636> <bdcf2425-c0cf-48df-96a8-7ee1d23125d7@linux.dev>
In-Reply-To: <bdcf2425-c0cf-48df-96a8-7ee1d23125d7@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 17 Oct 2026 16:19:02 +0400
X-Gm-Features: AclHuK_ldkostR4vqZE29fcaoDnWO3b8rAtih31hbuFNFSoBo5VC0b-tINCA_80
Message-ID: <CAJuCfpFWbtBD5K5S49oCPQYTxv0ZvtBio04nNyV9Sj1KRCbiwg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:28=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Uladzislau and Suren
>
> On 2026/10/14 00:39, Uladzislau Rezki wrote:
> > On Tue, Oct 13, 2026 at 03:23:14PM +0400, Suren Baghdasaryan wrote:
> >> On Fri, Oct 9, 2026 at 10:36=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>>
> >>> __vmap_pages_range_noflush() and friends can install some PTEs before
> >>> failing and leave them mapped, and the kernel callers do not agree on
> >>> who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
> >>> roll back what they mapped before the failure, while
> >>> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> >>> __vmalloc_area_node() rely on the mapping functions cleaning up and
> >>> do not call anything like vunmap_range() themselves. When the same
> >>> range is mapped again, the attempt hits the leftovers and fails, with
> >>> a BUG() in vmap_pte_range() for huge mappings and a warning on the
> >>> small-page path.
> >>>
> >>> After discussing with Suren and Ulad, we decided to put the rollback
> >>> into the entry points of the vmap API rather than into every low-leve=
l
> >>> helper. __vmap_pages_range_noflush() undoes the whole range it was
> >>> asked to map when it fails, and vmap_page_range() undoes its range
> >>> for the ioremap-style mappings.
> >>>
> >>> The rollback is __vunmap_range_noflush(), it only clears the PTEs,
> >>> no TLB flush, nothing has touched these mappings.
> >>> vmap_pages_range_noflush() drops the KMSAN metadata when the data
> >>> mapping fails, and an empty range bails out with -EINVAL now, which
> >>> used to BUG_ON() on the small-page path and map nothing at all on
> >>> the huge-page one.
> >>>
> >>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
> >>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >>> ---
> >>>  mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
> >>>  1 file changed, 32 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >>> index db669103dc66..e1b376f57dd2 100644
> >>> --- a/mm/vmalloc.c
> >>> +++ b/mm/vmalloc.c
> >>> @@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned =
long end,
> >>>         if (!err)
> >>>                 err =3D kmsan_ioremap_page_range(addr, end, phys_addr=
, prot,
> >>>                                                ioremap_max_page_shift=
);
> >>> +       if (err)
> >>> +               __vunmap_range_noflush(addr, end);
> >>> +
> >>>         return err;
> >>>  }
> >>>
> >>> @@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long ad=
dr, unsigned long end,
> >>>                 pgprot_t prot, struct page **pages, unsigned int page=
_shift)
> >>>  {
> >>>         unsigned int i, nr =3D (end - addr) >> PAGE_SHIFT;
> >>> +       unsigned long start =3D addr;
> >>> +       int err =3D 0;
> >>> +
> >>> +       if (WARN_ON_ONCE(addr >=3D end))
> >>> +               return -EINVAL;
> >>>
> >>>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
> >>>                 return -EINVAL;
> >>>
> >>>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> >>> -                       page_shift =3D=3D PAGE_SHIFT)
> >>> -               return vmap_small_pages_range_noflush(addr, end, prot=
, pages);
> >>> -
> >>> -       for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHIFT))=
 {
> >>> -               int err;
> >>> -
> >>> -               err =3D vmap_range_noflush(addr, addr + (1UL << page_=
shift),
> >>> +                       page_shift =3D=3D PAGE_SHIFT) {
> >>> +               err =3D vmap_small_pages_range_noflush(addr, end, pro=
t, pages);
> >>> +       } else {
> >>> +               for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE=
_SHIFT)) {
> >>> +                       err =3D vmap_range_noflush(addr, addr + (1UL =
<< page_shift),
> >>>                                         page_to_phys(pages[i]), prot,
> >>>                                         page_shift);
> >>> -               if (err)
> >>> -                       return err;
> >>> +                       if (err)
> >>> +                               break;
> >>>
> >>> -               addr +=3D 1UL << page_shift;
> >>> +                       addr +=3D 1UL << page_shift;
> >>> +               }
> >>>         }
> >>>
> >>> -       return 0;
> >>> +       /* Undo the PTEs installed before the failure. */
> >>> +       if (err)
> >>> +               __vunmap_range_noflush(start, end);
> >>
> >> Would it be too complicated to track how much was actually mapped and
> >> unmap only that portion?
> >>
> > I think it is possible to vunmap the range which is already unmapped.
> > i.e. in this case it is better to no to track anything as soon as a
> > mapping failure is a corner case. Also it is more reliable without
> > extra track logic.
>
> Thank you both.
> I take note of Suren's concerns. The worst case is a single PMD where onl=
y
> the first page was installed, __vunmap_range_noflush() then loops 512 tim=
es
> to undo one PTE, plus 511 empty ones.
>
> And tracking the exact progress would require vmap_pages_p4d/pud/pmd_rang=
e()
> to report how far they got. That also puts counting instructions on the s=
uccessful
> mapping path, while the saving only pays off on the failure one.
>
> So I agree with Ulad.

Got it. Makes sense.

>
> Thanks
> Best Regards
> Hao
>
> >
> > --
> > Uladzislau Rezki

