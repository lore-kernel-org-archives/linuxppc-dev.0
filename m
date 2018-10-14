Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36087C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 08:19:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6A820835
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6A820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Xvcj6C30zF3DQ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 19:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linutronix.de
 (client-ip=2a01:7a0:2:106d:700::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XvZV0RR2zDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 19:17:38 +1100 (AEDT)
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gBba5-0000FJ-No; Sun, 14 Oct 2018 10:16:57 +0200
Date: Sun, 14 Oct 2018 10:16:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
In-Reply-To: <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
Message-ID: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-68457485-1539505017=:1438"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: linux-mips@linux-mips.org, linux@armlinux.org, kvm@vger.kernel.org,
 rkrcmar@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, lantianyu1986@gmail.com, sthemmin@microsoft.com,
 x86@kernel.org, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, devel@linuxdriverproject.org,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-68457485-1539505017=:1438
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 14 Oct 2018, Liran Alon wrote:
> > On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> > 
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > 
> > This patch is to add wrapper functions for tlb_remote_flush_with_range
> > callback.
> > 
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> > Change sicne V3:
> >       Remove code of updating "tlbs_dirty"
> > Change since V2:
> >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > ---
> > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index c73d9f650de7..ff656d85903a 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
> > static union kvm_mmu_page_role
> > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > 
> > +
> > +static inline bool kvm_available_flush_tlb_with_range(void)
> > +{
> > +	return kvm_x86_ops->tlb_remote_flush_with_range;
> > +}
> 
> Seems that kvm_available_flush_tlb_with_range() is not used in this patch…

What's wrong with that? 

It provides the implementation and later patches make use of it. It's a
sensible way to split patches into small, self contained entities.

Thanks,

	tglx
	
--8323329-68457485-1539505017=:1438--
