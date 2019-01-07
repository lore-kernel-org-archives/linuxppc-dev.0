Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFEFC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 05:15:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE202087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 05:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjNCFmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE202087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Y3WJ3LTMzDqKJ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 16:15:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDjNCFmo"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Y3Tc3KKFzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 16:14:12 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id w73so21236153pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Jan 2019 21:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jkcm1HTbMQBDwve8/v16eQj6g2NpqtytScttFvde1sI=;
 b=TDjNCFmoJrm+GqQkTwUJs2zJ9JR4ndHopbHKyvuC3qFVRSV8H9d+pteoP53xeDgVJ/
 BVDSUiAmcgwcS4PiJmoJTK8R8C/E/d+OefgCTl88z0jEXs9ltiHJJqGN5Du15ClEX9vp
 qniTw3SKWriemK3Rddiv8yfbFJI8SvUZBezNiE08BtP6ikrGN+gzn0Ui3YF59Q7xIA2H
 eif0b60ulE18GWwu9mUPlliP4IRdxhzpqSjvPkHg62BzYeXG+7K5z+VoW9fHB4QMgy6U
 /a4qTeYgWZpk6WRCyKEmzlOTVqpf0ZlfS4KjQpV0SiOrUDaDWzrI0lXMzk6o5sZ7p6uI
 s/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jkcm1HTbMQBDwve8/v16eQj6g2NpqtytScttFvde1sI=;
 b=Q9X+lptitTiRgV671lUeppl24jYeDon06aG5Uw4BzWdo3/rK3xoqaf+nNdYaHjO9TA
 INFWZzoNHD3AFplwqwSC7o1nObf74JRsnYtc9bbYz0AZszp2QznrMUIL+0B4V0QCJ1PP
 qXWFLc62fQtw0NP060UYJOTv8FXca0QTWcOcUyfaz7fTDUAzVxbeROWqccd09bdrAWhm
 OXhAFIQXb8njG4L17FZmMQ8dQyeu1g2mRTVB11H+hn9nOLsh6UevlHMxKpg9xsWIDIYT
 UiFusH16mxfGtsqdYBXfytO3Q9a3k7K1glP6ASHrMx7neNtUavNSqHkPafvMFV/TEHQT
 8JYw==
X-Gm-Message-State: AJcUukcmpHAyCcvCd2tul3WlQ9ezpzD/O5lF9UKFzJ98+PqYAbaI9Uf2
 5NxWPDVcWY1q5pyx7U/gEdQ5x2WoP7mhCMqIRb4=
X-Google-Smtp-Source: ALg8bN6ETe1B9Q5up9Hz9+4Q4Khc8bwT2716MN0eJrPgrbPk5aEqN1u7xxt9RAxMs1TCeO7x9mqiJ4rAUgtKjunlSgk=
X-Received: by 2002:a63:da14:: with SMTP id c20mr9334574pgh.233.1546838050378; 
 Sun, 06 Jan 2019 21:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
 <20190104163035.GC11288@linux.intel.com>
In-Reply-To: <20190104163035.GC11288@linux.intel.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Mon, 7 Jan 2019 13:13:59 +0800
Message-ID: <CAOLK0pyMbKuxA0KnsRz_92jr5j15YXb2yUP0GH-xE06BqO_zTA@mail.gmail.com>
Subject: Re: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
To: Sean Christopherson <sean.j.christopherson@intel.com>
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
 ralf@linux-mips.org, paul.burton@mips.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 5, 2019 at 12:30 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Jan 04, 2019 at 04:54:00PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patch is to flush tlb via flush list function.
>
> More explanation of why this is beneficial would be nice.  Without the
> context of the overall series it's not immediately obvious what
> kvm_flush_remote_tlbs_with_list() does without a bit of digging.
>
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> > index 833e8855bbc9..866ccdea762e 100644
> > --- a/arch/x86/kvm/paging_tmpl.h
> > +++ b/arch/x86/kvm/paging_tmpl.h
> > @@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >       bool host_writable;
> >       gpa_t first_pte_gpa;
> >       int set_spte_ret = 0;
> > +     LIST_HEAD(flush_list);
> >
> >       /* direct kvm_mmu_page can not be unsync. */
> >       BUG_ON(sp->role.direct);
> > @@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >       first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
> >
> >       for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
> > +             int tmp_spte_ret = 0;
> >               unsigned pte_access;
> >               pt_element_t gpte;
> >               gpa_t pte_gpa;
> > @@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >
> >               host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
> >
> > -             set_spte_ret |= set_spte(vcpu, &sp->spt[i],
> > +             tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
> >                                        pte_access, PT_PAGE_TABLE_LEVEL,
> >                                        gfn, spte_to_pfn(sp->spt[i]),
> >                                        true, false, host_writable);
> > +
> > +             if (kvm_available_flush_tlb_with_range()
> > +                 && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
> > +                     struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
> > +                                     & PT64_BASE_ADDR_MASK);
> > +                     list_add(&leaf_sp->flush_link, &flush_list);
> > +             }
> > +
> > +             set_spte_ret |= tmp_spte_ret;
> > +
> >       }
> >
> >       if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
> > -             kvm_flush_remote_tlbs(vcpu->kvm);
> > +             kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
>
> This is a bit confusing and potentially fragile.  It's not obvious that
> kvm_flush_remote_tlbs_with_list() is guaranteed to call
> kvm_flush_remote_tlbs() when kvm_available_flush_tlb_with_range() is
> false, and you're relying on the kvm_flush_remote_tlbs_with_list() call
> chain to never optimize away the empty list case.  Rechecking
> kvm_available_flush_tlb_with_range() isn't expensive.

That makes sense. Will update. Thanks.

>
> >
> >       return nr_present;
> >  }
> > --
> > 2.14.4
> >



-- 
Best regards
Tianyu Lan
