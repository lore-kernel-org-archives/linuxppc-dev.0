Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500DC6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 09:38:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3926C20835
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LpuRJJSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3926C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XxNB5TS3zF3DN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 20:38:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LpuRJJSj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="LpuRJJSj"; dkim-atps=neutral
X-Greylist: delayed 466 seconds by postgrey-1.36 at bilbo;
 Sun, 14 Oct 2018 20:36:38 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XxKf2GqnzF3By
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 20:36:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sJZIa46aaf60l0x/fFfsp1cepPi587RjSDD9LmoUJX8=; b=LpuRJJSjrqCQC07m5ZV8B+fKH
 xdXg5dy//7uBeskmzAGOYw8ANIWnK3mMueFN16gQ4h7fad6cMvrN47BC2hlMRkV0JdPaO08S5Slqi
 s5qDXdmlRpHN4pq2xFxSofWD9PAEi5kzuW8/v8mUcwjwZb+XAMlnndH8XKpsXG2jcv9cQ=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:46319)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gBcoR-00030R-FD; Sun, 14 Oct 2018 10:35:51 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gBcoL-0002ph-Uf; Sun, 14 Oct 2018 10:35:46 +0100
Date: Sun, 14 Oct 2018 10:35:41 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Message-ID: <20181014093541.GW30658@n2100.armlinux.org.uk>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <20181014092734.GV30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181014092734.GV30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
 rkrcmar@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 lantianyu1986@gmail.com, sthemmin@microsoft.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, catalin.marinas@arm.com,
 jhogan@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
 Liran Alon <liran.alon@oracle.com>, devel@linuxdriverproject.org,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 14, 2018 at 10:27:34AM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 14, 2018 at 10:16:56AM +0200, Thomas Gleixner wrote:
> > On Sun, 14 Oct 2018, Liran Alon wrote:
> > > > On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> > > > 
> > > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > > 
> > > > This patch is to add wrapper functions for tlb_remote_flush_with_range
> > > > callback.
> > > > 
> > > > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > > ---
> > > > Change sicne V3:
> > > >       Remove code of updating "tlbs_dirty"
> > > > Change since V2:
> > > >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > > > ---
> > > > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > > > 1 file changed, 40 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > > > index c73d9f650de7..ff656d85903a 100644
> > > > --- a/arch/x86/kvm/mmu.c
> > > > +++ b/arch/x86/kvm/mmu.c
> > > > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
> > > > static union kvm_mmu_page_role
> > > > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > > > 
> > > > +
> > > > +static inline bool kvm_available_flush_tlb_with_range(void)
> > > > +{
> > > > +	return kvm_x86_ops->tlb_remote_flush_with_range;
> > > > +}
> > > 
> > > Seems that kvm_available_flush_tlb_with_range() is not used in this patch…
> > 
> > What's wrong with that? 
> > 
> > It provides the implementation and later patches make use of it. It's a
> > sensible way to split patches into small, self contained entities.
> 
> From what I can see of the patches that follow _this_ patch in the
> series, this function remains unused.  So, not only is it not used
> in this patch, it's not used in this series.

Note - I seem to have only received patches 1 through 4, so this is
based on the patches I've received.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
