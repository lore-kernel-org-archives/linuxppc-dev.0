Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC6C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 13:24:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C415220659
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 13:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4QK1ccb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C415220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Y2My3nxQzDsGh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:23:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M4QK1ccb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M4QK1ccb"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Y2KF07GnzF39c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 00:21:36 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id c8-v6so7986975plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3p7rOh3EHCcs5xJhBdJ9os0FBYpeHAf7F1aAnqF/f30=;
 b=M4QK1ccb/idnXeaKqj+Ewbkhcgm7CdlXT/yTIpkXgaATox26SQJltMaTvHPGPG79xb
 8FdicVlinm6TH9QQZywahbCsqU2Qo2cEeNF/BnNBRbcLzSuKYDeFaDlRsj9PNMtQl5/u
 ZX4AYSOkwd0qBIZSPiNXtPkByaFmv+vy/1D1182c0mcu5ApITPdk/hdFU1kMcAg5ZMkg
 VsR+cVaH4ChJ8jYBsBoXC7i04fwmIuiOlMYd8Hl4YZnQbq7dclEzhNcqcApiQBoSECiM
 GrKvFRQUSNqIOucytr38BPo65LejZNhIRfZwDzWlLHOw8Mlxuq6P6JkUPEi+BT/bzRTj
 FQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3p7rOh3EHCcs5xJhBdJ9os0FBYpeHAf7F1aAnqF/f30=;
 b=EUEsVjNaqD9mTRMk8ozEJe3isZhbS7GrNi8ZbNAymVVLyKY6gZmNoN58L0gAE74Op6
 WMl2Py3mcGxhiiTuRSPPcFRhX+6HDCjFbyCOZUhXh+QeH/hsi5WBIENkhQ/ZgYMWc5cx
 jbWqTfrHFUNpXfK78joPRhnkOi2qPoVmsc475Y1yE2wtE5CuwB77cNT0xNOLzVFatCGx
 wCEIC6nMY810ZGY5MBhnJox5bu3TP8kBOq5eZoLSuQ6B0+ileeE28+RgfxXryxMUpCZd
 QyjSEruYT6YZOZos6JubjKjyEPihWjlJ4Fzv9IBSNf6yHmGsGxZnP7hXypEUqWNqecs9
 v06g==
X-Gm-Message-State: ABuFfojBTKkWpQH/ErCwmv2mOymjLdI5Kw/GEmKXWFvqWWGmjOAUnPAP
 xlLD1s+hR5FSor3PAi37SUrw0vQyi++sIaTi/DE=
X-Google-Smtp-Source: ACcGV60Bsdv+2lbefbGLxTexZhfM8a9SDOpaKx+exqAsk4LqnWktEAF8KcHNub/RKj7H2PyE8ha/L2lfpnhhtHYxQ0w=
X-Received: by 2002:a17:902:da4:: with SMTP id
 33-v6mr12916512plv.172.1539523294880; 
 Sun, 14 Oct 2018 06:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <20181014092734.GV30658@n2100.armlinux.org.uk>
 <20181014093541.GW30658@n2100.armlinux.org.uk>
In-Reply-To: <20181014093541.GW30658@n2100.armlinux.org.uk>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Sun, 14 Oct 2018 21:21:23 +0800
Message-ID: <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
To: linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-mips@linux-mips.org, linux@armlinux.org, kvm <kvm@vger.kernel.org>,
 Radim Krcmar <rkrcmar@redhat.com>, will.deacon@arm.com,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
 the arch/x86 maintainers <x86@kernel.org>, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com, jhogan@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, liran.alon@oracle.com,
 devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Russell:
              Thanks for your review.

On Sun, Oct 14, 2018 at 5:36 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Sun, Oct 14, 2018 at 10:27:34AM +0100, Russell King - ARM Linux wrote:
> > On Sun, Oct 14, 2018 at 10:16:56AM +0200, Thomas Gleixner wrote:
> > > On Sun, 14 Oct 2018, Liran Alon wrote:
> > > > > On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> > > > >
> > > > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > > >
> > > > > This patch is to add wrapper functions for tlb_remote_flush_with_=
range
> > > > > callback.
> > > > >
> > > > > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > > > ---
> > > > > Change sicne V3:
> > > > >       Remove code of updating "tlbs_dirty"
> > > > > Change since V2:
> > > > >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > > > > ---
> > > > > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > > > > 1 file changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > > > > index c73d9f650de7..ff656d85903a 100644
> > > > > --- a/arch/x86/kvm/mmu.c
> > > > > +++ b/arch/x86/kvm/mmu.c
> > > > > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spt=
e);
> > > > > static union kvm_mmu_page_role
> > > > > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > > > >
> > > > > +
> > > > > +static inline bool kvm_available_flush_tlb_with_range(void)
> > > > > +{
> > > > > +       return kvm_x86_ops->tlb_remote_flush_with_range;
> > > > > +}
> > > >
> > > > Seems that kvm_available_flush_tlb_with_range() is not used in this=
 patch=E2=80=A6
> > >
> > > What's wrong with that?
> > >
> > > It provides the implementation and later patches make use of it. It's=
 a
> > > sensible way to split patches into small, self contained entities.
> >
> > From what I can see of the patches that follow _this_ patch in the
> > series, this function remains unused.  So, not only is it not used
> > in this patch, it's not used in this series.
>
> Note - I seem to have only received patches 1 through 4, so this is
> based on the patches I've received.
>

Sorry to confuse your. I get from CCers from get_maintainer.pl script.
The next patch "[PATCH V4 3/15]KVM: Replace old tlb flush function with
new one to flush a specified range" calls new function.
https://lkml.org/lkml/2018/10/13/254

The patch "[PATCH V4 4/15] KVM: Make kvm_set_spte_hva() return int"
changes under ARM directory. Please have a look. Thanks.
--=20
Best regards
Tianyu Lan
