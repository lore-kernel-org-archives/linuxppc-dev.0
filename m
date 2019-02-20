Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:25:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B2B206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="J9V97QQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="le1knAt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B2B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444FdV5qtgzDqJH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:25:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="J9V97QQ1"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="le1knAt5"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444FXB4tFYzDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:20:42 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 195F422276;
 Wed, 20 Feb 2019 06:20:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 06:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 zVDWPSh/dfBAOEu/w4f9YXWR0myr1KLwikjIbi6YfUE=; b=J9V97QQ1+aDP+R8l
 CiP9QBOnNmrkxMmBIiWxb1CNnFVqh+jDoxboxmSApMm9TiiR+HmPZL9Hjq3YTKhz
 zj7BVgo0uuqKe3tocedchiMKnFcp3fykfM2qLl8reyX5djGRtOgqoUXfUrfOUPsx
 IiDbO3YTPhIyg6A2FisN84MejPje1DhGQ8SpscT66W2neWWfIiqhZGBFESVHxHJj
 LSvilUF4/Kc4fcmhKclg64ufngBWd+2eLlKCoqQYWusk4DnHlgqDZMqdAAXbjohb
 C/OuMl41/czzHCmc/Q2FB1xQSgY8po3pKS5Sbjley+A4PituqGxrBnEzxqpRc2/A
 KN+87Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=zVDWPSh/dfBAOEu/w4f9YXWR0myr1KLwikjIbi6Yf
 UE=; b=le1knAt5mQUoUXrc4NbOoeQRG0xMcfj6kdzLgEYcEo6CPauYyxh22kWa6
 UdzdcXx7OsANyYNRrqLEzpXVrMLqUj81oUqVi/BiLA+4I4WK4dXfFku8vtgAqjzi
 WCsMpNaPolyYustpSyGigOOXT3WgeJMnef2UUjJqWQYjAe+GyHOsmJsnhwpQ0iFl
 WHpoMzTo1VW7vAzlRJ6B7zSqkbD7D8sj1AyZV2cBA0sExfoOMLz1krsVRFE78Zn3
 fHkhK0AAJXyk47pCHhKe0vxVmPTOHy/jJdAmFQd/zPxIIMgVvCYDTKbQqrQyfAGS
 VqMyy/+E+u/6ylfxCCwk6m2oXmmkg==
X-ME-Sender: <xms:BzhtXN9SBdakmWLqTtY7-c15ixLdO0V9RR0J9q7jkj3bB2t08c0gpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeigddvieculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucffohhmrghinhepsghoohhkfehsrdhssgenucfkphepuddvuddr
 geehrddvudelrdefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhush
 hsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:BzhtXAQFq0auA0-JpqWKITruDj6-i5wi88XqF425cACgMuCp9IRbNQ>
 <xmx:BzhtXFv3KmgSMKKvPg5GlTbk162aF22Dkz_kDSOVQHWEqUJGpzW48Q>
 <xmx:BzhtXOgtLVzKi8FZn2lX3h5-QlOgZRiFT77X5lxfYKyZ-mWG1WYmGg>
 <xmx:CDhtXPoVmU1ZawgOG_IxNQWHElTE3JohLIcLLRSo9Ummx5pFJOKfpw>
Received: from crackle.ozlabs.ibm.com
 (ppp121-45-219-3.bras1.cbr2.internode.on.net [121.45.219.3])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7205EE4385;
 Wed, 20 Feb 2019 06:20:38 -0500 (EST)
Message-ID: <86ab88c86afeb99f8f4c8e1c2c590bf7541e7e40.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
From: Russell Currey <ruscur@russell.cc>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Date: Wed, 20 Feb 2019 22:20:34 +1100
In-Reply-To: <20190220085841.GA11633@aks.ibm>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <20190220085841.GA11633@aks.ibm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-20 at 14:28 +0530, Akshay Adiga wrote:
> On Wed, Feb 06, 2019 at 05:28:37PM +1100, Russell Currey wrote:
> > Without restoring the IAMR after idle, execution prevention on
> > POWER9
> > with Radix MMU is overwritten and the kernel can freely execute
> > userspace without
> > faulting.
> > 
> > This is necessary when returning from any stop state that modifies
> > user
> > state, as well as hypervisor state.
> > 
> > To test how this fails without this patch, load the lkdtm driver
> > and
> > do the following:
> > 
> >    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
> > 
> > which won't fault, then boot the kernel with powersave=off, where
> > it
> > will fault.  Applying this patch will fix this.
> > 
> > Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of
> > user
> > space")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> >  arch/powerpc/include/asm/cpuidle.h |  1 +
> >  arch/powerpc/kernel/asm-offsets.c  |  1 +
> >  arch/powerpc/kernel/idle_book3s.S  | 20 ++++++++++++++++++++
> >  3 files changed, 22 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/cpuidle.h
> > b/arch/powerpc/include/asm/cpuidle.h
> > index 43e5f31fe64d..ad67dbe59498 100644
> > --- a/arch/powerpc/include/asm/cpuidle.h
> > +++ b/arch/powerpc/include/asm/cpuidle.h
> > @@ -77,6 +77,7 @@ struct stop_sprs {
> >  	u64 mmcr1;
> >  	u64 mmcr2;
> >  	u64 mmcra;
> > +	u64 iamr;
> >  };
> > 
> >  #define PNV_IDLE_NAME_LEN    16
> > diff --git a/arch/powerpc/kernel/asm-offsets.c
> > b/arch/powerpc/kernel/asm-offsets.c
> > index 9ffc72ded73a..10e0314c2b0d 100644
> > --- a/arch/powerpc/kernel/asm-offsets.c
> > +++ b/arch/powerpc/kernel/asm-offsets.c
> > @@ -774,6 +774,7 @@ int main(void)
> >  	STOP_SPR(STOP_MMCR1, mmcr1);
> >  	STOP_SPR(STOP_MMCR2, mmcr2);
> >  	STOP_SPR(STOP_MMCRA, mmcra);
> > +	STOP_SPR(STOP_IAMR, iamr);
> >  #endif
> > 
> >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> > diff --git a/arch/powerpc/kernel/idle_book3s.S
> > b/arch/powerpc/kernel/idle_book3s.S
> > index 7f5ac2e8581b..bb4f552f6c7e 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -200,6 +200,12 @@ pnv_powersave_common:
> >  	/* Continue saving state */
> >  	SAVE_GPR(2, r1)
> >  	SAVE_NVGPRS(r1)
> > +
> > +BEGIN_FTR_SECTION
> > +	mfspr	r5, SPRN_IAMR
> > +	std	r5, STOP_IAMR(r13)
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> > +
> >  	mfcr	r5
> >  	std	r5,_CCR(r1)
> >  	std	r1,PACAR1(r13)
> > @@ -924,6 +930,13 @@ BEGIN_FTR_SECTION
> >  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> >  	REST_NVGPRS(r1)
> >  	REST_GPR(2, r1)
> > +
> > +BEGIN_FTR_SECTION
> > +	ld	r4, STOP_IAMR(r13)
> > +	mtspr	SPRN_IAMR, r4
> > +	isync
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> > +
> >  	ld	r4,PACAKMSR(r13)
> >  	ld	r5,_LINK(r1)
> >  	ld	r6,_CCR(r1)
> > @@ -946,6 +959,13 @@ pnv_wakeup_noloss:
> >  BEGIN_FTR_SECTION
> >  	CHECK_HMI_INTERRUPT
> >  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> > +
> > +BEGIN_FTR_SECTION
> > +	ld	r4, STOP_IAMR(r13)
> > +	mtspr	SPRN_IAMR, r4
> > +	isync
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> > +
> 
> pnv_wakeup_noloss gets called from two paths:
> 1) cpu wakes up at 0x100  (ESL=EC=1)
> 2) cpu wakes up at next instruction  (ESL=EC=0)
> 

In v2 I drop it from noloss, is that still correct?

> We know for the fact that its not lost with ESL=EC=0 , so we
> should put it somewhere else.
> 
> I would like to put the restore code in
> pnv_restore_hyp_resource_arch300
> it already has some work arounds we can add another.
> 
> By this time we cr3 has comparison of SRR1[46:47] with 2
> 
>   542 pnv_restore_hyp_resource_arch300:
>   543         /*
>   544          * Workaround for POWER9, if we lost resources, the
> ERAT
>   545          * might have been mixed up and needs flushing. We also
> need
>   546          * to reload MMCR0 (see comment above). We also need to
> set
>   547          * then clear bit 60 in MMCRA to ensure the PMU starts
> running.
>   548          */
>   549         blt     cr3,1f
>   550 BEGIN_FTR_SECTION
>   551         PPC_INVALIDATE_ERAT
>   552         ld      r1,PACAR1(r13)
>   553         ld      r4,_MMCR0(r1)
>   554         mtspr   SPRN_MMCR0,r4
>   555 END_FTR_SECTION_IFCLR(CPU_FTR_POWER9_DD2_1)
>   556         mfspr   r4,SPRN_MMCRA
>   557         ori     r4,r4,(1 << (63-60))
>   558         mtspr   SPRN_MMCRA,r4
>   559         xori    r4,r4,(1 << (63-60))
>   560         mtspr   SPRN_MMCRA,r4
> + 561 BEGIN_FTR_SECTION
> + 562         ld      r4,STOP_IAMR(r13)
> + 563         mtspr   SPRN_IAMR,r4
> + 564 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>   565 1:
>   566         /* 
> 
> I have a patchset to handle both AMOR and IAMR,
> need to test it on power8 before posting.

If you think that's better, go ahead.

> 
> 
> >  	ld	r4,PACAKMSR(r13)
> >  	ld	r5,_NIP(r1)
> >  	ld	r6,_CCR(r1)
> > -- 
> > 2.20.1
> > 

