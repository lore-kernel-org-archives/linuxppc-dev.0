Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756DE606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZdscdAq6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ0sX6wfRz308H;
	Thu, 12 Nov 2026 11:01:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::834" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794441664;
	cv=pass; b=fuudLTb5tzra4lOAgBAizuoJSPFK2HyEe4rYZwzeoCtrs64UwIyd2aJf5hPtb4HcYoiJks5iQOLkgbhy0VU5i/rQLpp4D7Z1lUJxUC4N+aQ8HiQW8paSoXd+OMEMW+9O8R4YDcaPkrs+5Zi4cwqryWZeY0+NK9fAMSM+1UyCqO3PpZHt36QH+Rlk2l+gu5acSW7SpuF3FoAum0cWJLnQeiw8mlluEPrGHjSEfLKd9+GDH0vWII4UcfXCdgtcIGk2jb9Xn6YrMgM2ZC2kNAByiMcl88CS/f12qcoimOkQPDuMTjf5275UnLii54DZHJlRH4VgRWyhlgAwv/4r3SFGvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794441664; c=relaxed/relaxed;
	bh=/+sJZZbZo2UcO+Nr8+QxFylA7K/BaXAtaD89aBd6sd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEYxmomUcFfELXUq4GA6lJwvB96GwOEkom95F6aEIP4xUs3rlbFsZth5/kMhdXUaw2z0+JrBiq4D1vs7SoTPwcd1DBA2cosT243QbfEWs7tI+kG6d29wUBzRBf0cRgZs70ccgglkQKnKO6xDvBxjQoSlDk3K/jAzQtRJTlT9mum/Pb5C0U0P6gaG6G64OxPzhEXxn1MNpb0o/f0sqioqFuKmXEJs143ACGc6xEPvYf5/4JxDlvOsM7i/vVaXsoIEXZMKZXzC69XfQOvUr9s5D4jlFriQFkX0Hs5p2sqPxgY2aYKUN3zgjobLWAu+nftDcB40wT1ctjtURXNZmG7xsg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZdscdAq6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZdscdAq6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ0sV6ghvz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:01:02 +1100 (AEDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-54492d8a988so50531cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794441660; cv=none;
        d=google.com; s=arc-20260327;
        b=Al/WAs3BmQE2lRvuOLY7RfQQwOkaWKGFxpSstShQnXlqYO6lr3yK29z5W4OKLBZOcX
         Lh/yT9XDQPpR75Foq64FksveoGGaNNtyXT9QT54YAcvYjuk2FODxn+STekdpttqechLV
         VylmmNEY40/6ATSovrSvViNWHOMMemhVL3mmzpyPHqexb0lbwk+2B8XtSuggsMOkjfAN
         +pY/Hp3x3B1DiUVw5hLaF6M+PZzT393eE9qPJeMO1G40A7WKWS7pePPvwrFGGXSCddiw
         XYXJ9INnXMRNkajipzr+QVd+0HkB6/ppEsV8Pi6973XM4T4G5j78oNKcjVdcolPLdvKD
         DBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/+sJZZbZo2UcO+Nr8+QxFylA7K/BaXAtaD89aBd6sd0=;
        fh=5XTr9XC9TM09DfHdEDdCn+C2Rd7gRbUNq3/n9OiMhxk=;
        b=O81qLTunEzkLpeS+JxNRDttcGvu4Ix0y8JKoZ4y0bmgTs3TEmSLylOqdkQToXP7NOw
         XNQs49Wx2yLwEG0HRnN1OJ0IiGf2Qnjj1Ts5MAiR7aYsRf5PiJO+lxaUGzTBfoE8nYk0
         /SGgulLZw3Bd6wCUKD7otKg+GKuoYktVMlC6P+TM19tSz1AUj/DyRLXkoOmINKdEZW2S
         is372SJDECeRydvrScsBccGYK0YTCXOrLR/fNh2SGIhJZzB02XT4rI/FNCAUtaZtGDly
         lMBLhOayFWRw37hlaBPsMl+puDCj+I0rp46PW45mjZuRU0OrQDAn62UhkExVQGLUxSZD
         UNpw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794441660; x=1795046460; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/+sJZZbZo2UcO+Nr8+QxFylA7K/BaXAtaD89aBd6sd0=;
        b=ZdscdAq6j6NpjERrlwUrsLnZAB8td/PxSLN5W/UwNrAsTBH3CHFAugtlX8irr4SLVq
         QjAX19MehOjbXvHIKyAzJCUj5VdzEqXTY9h43C2aDJDFGL59tdGtlOeWBxf9JUMaKfIZ
         ++PJIIpbptlQItiTGNvDd4Q03CafUgz1shwAqLCueGLx2syqmbBiN5kbu4qF+hj6/PJw
         +bg0opcJK8zGuZQ0Jo80kc25Ftqn2sLMOx6WYvks52fU1J+f6rXbiUvmqqM+gyueLCA/
         6CO1YnzpTVJxJx4jbCXw+YfW/nuJJXbrxIS1bzR0yyt6OzOwUf0G+R1uqdlp1uUFTXm9
         hrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794441660; x=1795046460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+sJZZbZo2UcO+Nr8+QxFylA7K/BaXAtaD89aBd6sd0=;
        b=hUvvd0cWpDO0GPc1Wybf1aiJYte59/mMlbwKYrrJNaABlEnqKOAxx2CaqXxKzw/IqA
         yv0C4W5E5baP6L9K5EEIn9XsMEFbSkOj/Ro24ba6xuDe/pCWWh9vVJFe0SaRayL15L41
         PRkxUeq+zkE/srmAumWlMedFCqE+ibA57O8PX0dPapnfXku1KAG+AccNyRQJErrHDBND
         W1nTmbW3x+71AxCsxOAqyg0X8lLsfNrl6zMQ0HuPDAayajs5OVq1FCFd0AbimWI//bgs
         ZcJZcVWJvC9zTCsLQ+U9o3MFI0LLSRHWoDc1PlKJ/4VpuV93CenowODpcv+AiNZh3EAs
         q+/A==
X-Forwarded-Encrypted: i=1; AL+hErGRUmkdKjmd3HWcWjVY1gpt1DOhEwUR7ErES+xV6S4Zzzvkz+bQY8e2ziQKtDFt1jZ3v/64SWCzhM7Tffk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z93TVWWutMpEBh1mOdnQ/TcG71kHfY0vT19MahIjB9QAUnGYBXV
	s4+viQ/MAXMzpk0RNjxR7KGiXfGMOUCpCruI9xs2Xu/kt1w2vpt81nF+SAu9r6YZYeeF6ZPxpM2
	a0+KHO3QxAUddXmtxDA6fQFtoPcqZbOr8IaoBzs3i
X-Gm-Gg: AYBFou08GfdK7/G5yUFcCo0LwKYW4ONg7JKvgvHwIezdL+S58BwehA5DsKvv8Av8ASd
	jMiA54mHka6Nsoo86a7qMFrCR1OY7+wc2c3O8Dn6P/5vcV9fNZk7V33q7ED314u5xMfNQTXKD4n
	GbfnJwR1NT+8xSiSaMSoEcOgmF8v/IKzy7YTYg4LZoRiqP2lIjm9lM6AbimsdslOKv3KQYwVgfr
	/cu7RbfNlPKTgsCVBpgdgL0klT4/aS5J9OYJjxPsB6YaLIzbzR9qtRcYLkYexZuJ8upDCiC5JZv
	ukgiPyRJQMDR32dMWgD+OkTunA32LYFWIPpUWzkOywQrD6uRtO1zg72OOhZh+Sbtl+zhwbQp3V7
	G+h1ljE8j/ogcWp0bKwJ77xTH4uzgWl2/EVg3U5j9nQvSANL7nkjopArGJJ0/O2o9KGMCmyK0PZ
	/cMi4sLcB6vDLr8h5vasrBOha4JQ==
X-Received: by 2002:a05:622a:514c:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-5596742d03cmr7885161cf.0.1794441657704; Wed, 11 Nov 2026
 16:00:57 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-4-hao.ge@linux.dev>
 <f416f84a-03de-49fd-ab67-d86ed4dec633@linux.dev>
In-Reply-To: <f416f84a-03de-49fd-ab67-d86ed4dec633@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 00:00:45 +0000
X-Gm-Features: AclHuK9BKDPw8mqltXLLAZPx2uW3RHH6cpnOYo4JgG_IF10oXVJ9B3sYkpkOZaI
Message-ID: <CAJuCfpEO6F5g43=uR=PmNmZwRXDzLjT_4CfE7UUZmt7iebgjfg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm/vmalloc: BUG_ON() on an unaligned range in vmap_range_noflush()
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Dmitry Vyukov <dvyukov@google.com>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@gentwo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:26=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
>
>
> On 2026/11/10 19:25, Hao Ge wrote:
> > commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> > PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
> > late, because the upper levels may already have installed page
> > tables for a range that is rejected anyway.
> >
> > The pte loop maps whole pages and stops only when addr lands
> > exactly on end.  An unaligned end lets addr jump over it and the
> > loop keeps mapping past the range.  An unaligned start maps the
> > page below the range and usually misses end too.  Such a range is
> > never a legitimate request, and the corruption it leaves behind is
> > hard to attribute to the caller afterwards, so bug out on addr and
> > end at the entry of vmap_range_noflush() and drop the check from
> > vmap_pte_range().
> >
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  mm/vmalloc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 093b8d5f7b0e..27f2674a5556 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -125,9 +125,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long=
 addr, unsigned long end,
> >       unsigned long size;
> >       unsigned int nr_pages;
> >
> > -     if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> > -             return -EINVAL;
> > -
> >       pfn =3D phys_addr >> PAGE_SHIFT;
> >       pte =3D pte_alloc_kernel_track(pmd, addr, mask);
> >       if (!pte)
> > @@ -347,6 +344,7 @@ static int vmap_range_noflush(unsigned long addr, u=
nsigned long end,
> >        */
> >       might_sleep();
> >       BUG_ON(addr >=3D end);
> > +     BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
>
> I know BUG_ON() is ugly and it was not my first choice either, but I
> have not figured out a better way to handle __vunmap_range_noflush().
>
> If an unaligned range is passed to it, the pte loop may clear PTEs
> adjacent to the range. Say a caller passes [3, 12) while [0, 3)
> belongs to somebody else. The loop operates on whole pages, so it
> starts at the page containing 3 and clears [0, 3) with it. That
> silently corrupts a live mapping, and the corruption is not detected
> until the owner touches the page. Bugs like that are nearly
> impossible to debug afterwards.
>
> It is not feasible for __vunmap_range_noflush() to just return an
> invalid-argument error upfront. Its job is to clear PTEs, and an
> early return leaves the residual PTEs behind.
>
> I also thought about warning and returning -EINVAL on the map side
> and keeping BUG_ON() only in __vunmap_range_noflush(), but the
> rollback kills that idea.
>
> int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>                 pgprot_t prot, struct page **pages, unsigned int page_shi=
ft,
>                 gfp_t gfp_mask)
> {
>         int err;
>
>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>                 return -EINVAL;
>
>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
>                 page_shift =3D PAGE_SHIFT;
>
>         err =3D vmap_pages_range_noflush_walk(addr, end, prot, pages, pag=
e_shift);
>
>         /* Undo the PTEs installed before the failure. */
>         if (err)
>                 __vunmap_range_noflush(addr, end,
>                                        gfpflags_allow_blocking(gfp_mask))=
;
>
>         return err;
> }
>
> If the walk WARNs and returns -EINVAL for a bad range, the undo
> above passes that same range to __vunmap_range_noflush(), and we
> BUG right after the WARN. vmap_page_range() runs into the same
> thing on its error path.
>
> So the map side cannot warn while the unmap side BUGs, the rollback
> drags the rejected range into the unmap anyway. And the unmap side
> cannot warn and skip either, that leaves the stale PTEs.
>
> Also, these checks are the last line of defense. All in-tree callers
> pass page aligned, non-empty ranges, and I am not aware of anyone ever
> hitting this line. So for correct code the BUG_ON never fires at all,
> no user will ever see it. The only one who can trip it is the developer
> who just passed the bad range, and for him a stack trace right at the
> spot is much better than chasing a silent corruption afterwards.
>
> I settled on BUG_ON here. It may not be an ideal solution, but if anyone
> has a better idea or alternative approach, please let me know.
> I would greatly appreciate it.

I don't see a better way to handle this situation but I would add a
WARN_ON_ONCE() alignment check at the beginning of vmap_page_range()
too because it is used in some of the exported functions like
ioremap_page() and pci_remap_iospace(). If someone passes an unaliged
address to these functions your change would turn a warning+function
failure into a panic.

>
> Thanks
> Best Regards
> Hao
>
> >
> >       start =3D addr;
> >       pgd =3D pgd_offset_k(addr);

