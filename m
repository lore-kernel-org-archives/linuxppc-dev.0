Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA9C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 09:08:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54F1214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 09:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTGY9Vaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54F1214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b0XB5JClzDqdf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:08:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTGY9Vaw"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b0VR2JwdzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 20:06:39 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id b85so5029613pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 01:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oq80hyIRxc7kD/9H1MyYY3fFLvm60ShEsiOlrZc3KYA=;
 b=hTGY9VawGhKjAEPgrRt1SPQT4EG5iuZqoIW1KBax7pl8YNTXG4Vfd9yFbNqVTP6CKq
 Lq9gCQr172eU4c6qB+2ZJoksKKEV0IrNS25SJMIWPuxgIbu6deseS3OSzEsbAJy2YeM+
 nA4gDJwymhlOM0pD950PKH7w1M22eiN5i/ObZwBQeq8LJFMBXiVzhVcTAUMlKc5aXzrp
 9vkvrrM9VLbJcerBTbmQuUZK6eUWVSVly6mIouFlvpkaK7mBPZywI4SN2+PEgTyQNXlk
 0civggBqSPQuln3CUOhsBUZ7jfJwDRjbFCyzKA0fficEthHyKNDX96C2SNbZYYLG6FHc
 VpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oq80hyIRxc7kD/9H1MyYY3fFLvm60ShEsiOlrZc3KYA=;
 b=LxWl5aR05gUs0RRPyeI892Q6XGh1kEXovxmpWigS6H8lfpVMNFZKv4m/Q1NgqpDRCe
 V6m7FYI27gk89DcoSCxqcjRedi0lhCrfTgZAx0m6pDCmZukIC6Q9Ii3X2uL+sGA6WEhz
 kptJnp5Ktej4KwuV5XGh5m2jOzs21EbA47CoKWjayaMLdxB1VxMIa6iauv6qk+jXUPfM
 OA75g/cbVCLXcd7QJkw1+d7KjNsfOJgI4zpSyaGzaZtCxcoTuQVOh1ys7zVktpDrOSGN
 Ll4lmHL+n8k2Vxd9569tfUDCTgPo6expv7hlVTt8yrmbRBjcGsCFkJUFqhiWc0lHNeUY
 c6pg==
X-Gm-Message-State: AJcUukcefMaHRX4b6hHll1gJ+1ihf4m/xho2BTk2C+pA+DjjLBoa63ap
 QiT4ySeLWcmmJUjfcgOpASVoudt3PLhJx1HL9co=
X-Google-Smtp-Source: ALg8bN4BE6q8xxDDtq+YuLH5+cixz7d0oBOOvQbl+bRUmSLVR5oY8KTP6B615fpl1R0lgmzzlO6hmmnE0EIbQpvPK5o=
X-Received: by 2002:a63:da14:: with SMTP id c20mr8224322pgh.233.1547111196652; 
 Thu, 10 Jan 2019 01:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-10-Tianyu.Lan@microsoft.com>
 <7eb0cde4-9436-9719-dd13-caf4ab5083a2@redhat.com>
In-Reply-To: <7eb0cde4-9436-9719-dd13-caf4ab5083a2@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Thu, 10 Jan 2019 17:06:25 +0800
Message-ID: <CAOLK0pz6K90+QOMV2Vmhd3vC2t5+15vmUo0E=2rwax7cGDfxjw@mail.gmail.com>
Subject: Re: [PATCH 9/11] KVM/MMU: Flush tlb in the
 kvm_mmu_write_protect_pt_masked()
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
 ralf@linux-mips.org, paul.burton@mips.com, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 8, 2019 at 12:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/01/19 09:54, lantianyu1986@gmail.com wrote:
> >               rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
> >                                         PT_PAGE_TABLE_LEVEL, slot);
> > -             __rmap_write_protect(kvm, rmap_head, false);
> > +             flush |= __rmap_write_protect(kvm, rmap_head, false);
> >
> >               /* clear the first set bit */
> >               mask &= mask - 1;
> >       }
> > +
> > +     if (flush && kvm_available_flush_tlb_with_range()) {
> > +             kvm_flush_remote_tlbs_with_address(kvm,
> > +                             slot->base_gfn + gfn_offset,
> > +                             hweight_long(mask));
>
> Mask is zero here, so this probably won't work.
>
> In addition, I suspect calling the hypercall once for every 64 pages is
> not very efficient.  Passing a flush list into
> kvm_mmu_write_protect_pt_masked, and flushing in
> kvm_arch_mmu_enable_log_dirty_pt_masked, isn't efficient either because
> kvm_arch_mmu_enable_log_dirty_pt_masked is also called once per word.
>
Yes, this is not efficient.

> I don't have any good ideas, except for moving the whole
> kvm_clear_dirty_log_protect loop into architecture-specific code (which
> is not the direction we want---architectures should share more code, not
> less).

kvm_vm_ioctl_clear_dirty_log/get_dirty_log()  is to get/clear dirty log with
memslot as unit. We may just flush tlbs of the affected memslot instead of
entire page table's when range flush is available.

>
> Paolo
>
> > +             flush = false;
> > +     }
> > +
>


--
Best regards
Tianyu Lan
