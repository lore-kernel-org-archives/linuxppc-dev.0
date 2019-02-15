Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC27C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 15:07:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F74721A4C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4zcylc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F74721A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441GpD720zzDq5x
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 02:07:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="l4zcylc3"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441Gly2jwczDqd2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 02:05:34 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id y1so4920045pgk.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 07:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pdlq/dEtI363+RqrBnNPZ7uHe1H/unQpX6+JLG3TUso=;
 b=l4zcylc3JZXCQ5dgtx8+3QDOppft9OqAq2m82EUh2nCHYAFX7hShjjFF8JFVHzGJMU
 hDiNoQiA83mgT5zit13fJerL3eNlO8QK0+YJdgH1hgxjc4nMTuTYtTxbkMP44HSfzyC1
 o9oEY99aJsWTakOSwV2WB8m5VTbJRd5qH22G3VA9WavtTAjRArJ/9Bm3YlEG7iolxA9I
 SCYMG3G+yQ9hchXv9kQOT+DKP1hON8ZP35cDUJXFTVYYragi/KhQ1rkV60PemXeFaYjA
 cmLNbLuwyNbKX2Xgppa4lWNGt3Ckvd2kHMHjWbo3JmLRMOiJC4w3YlEJhYzJnj+58FjL
 v1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pdlq/dEtI363+RqrBnNPZ7uHe1H/unQpX6+JLG3TUso=;
 b=oyuQnaJVvt0aX1eh1s+lEbcOayGqMm9xdYl78ifPXXHMwGg3JaXFbcNLKm30Vy+LLj
 oEG28Ywa4tlY/3BXMysosPd2GAtkgIMDdNuBoH8gw7vG0agjuFnrK4jqjm94FJdtW2VU
 eaBtVjFU19mJUwhxQEsDQH2nvqeJPVF3RxqG3M6S+Nc3sMDY9sftenwyb8FS2g2INsnz
 +BByJU0C7eCNNjbE0JlUa/hqeCyJFEt9eRHFffFzvXknQG9bJEIGlabGeorZ8kB2xjrj
 VYxCJjrFtzAaMqOMtNSXmf1U5v2Yr+FMOayUBEG1EE8B/SAS+oOqJ7Kn0fEIF1MOFiNA
 xatw==
X-Gm-Message-State: AHQUAuZDqK7g/DObRQz3ADubxjj/Cb+rCj96Jf+NkDqyK3ISeh8Etq55
 NctUXqF5775FIteSJVfJujHxvmRWdm9rVgmS0Js=
X-Google-Smtp-Source: AHgI3IZGOB0YXIwlivSAxLHT4URYYb3+UhrAB9EIaQZQ4W7zt8lv9iT8EbVfih6aM7/Q0WiZpsDnUp+4G9hZ8+OTfjo=
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr5915867pgc.25.1550243132454; 
 Fri, 15 Feb 2019 07:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
 <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
 <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
In-Reply-To: <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Fri, 15 Feb 2019 23:05:21 +0800
Message-ID: <CAOLK0pzXnvk=FsfjH07jUyRJGpeiNG7-9vR9Vo0mLJtdPnt_7Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct
 mmu_spte_page
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, the arch/x86 maintainers <x86@kernel.org>,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 12:32 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/02/19 02:38, lantianyu1986@gmail.com wrote:
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index ce770b446238..70cafd3f95ab 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -2918,6 +2918,9 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> >
> >       if (level > PT_PAGE_TABLE_LEVEL)
> >               spte |= PT_PAGE_SIZE_MASK;
> > +
> > +     sp->last_level = is_last_spte(spte, level);
>
> Wait, I wasn't thinking straight.  If a struct kvm_mmu_page exists, it
> is never the last level.  Page table entries for the last level do not
> have a struct kvm_mmu_page.
>
> Therefore you don't need the flag after all.  I suspect your
> calculations in patch 2 are off by one, and you actually need
>
>         hlist_for_each_entry(sp, range->flush_list, flush_link) {
>                 int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
>                 ...
>         }
>
> For example, if sp->role.level is 1 then the struct kvm_mmu_page is for
> a page containing PTEs and covers an area of 2 MiB.

Yes, you are right. Thanks to point out and will fix. The last_level
flag is to avoid adding middle page node(e.g, PGD, PMD)
into flush list. The address range will be duplicated if adding both
leaf, node and middle node into flush list.

>
> Thanks,
>
> Paolo
>
> >       if (tdp_enabled)
> >               spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
> >                       kvm_is_mmio_pfn(pfn));
>


-- 
Best regards
Tianyu Lan
