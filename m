Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC21C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:35:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E727C2147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="Qbtl/85x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMv1MuB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E727C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w7pn70pZzDqQc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 17:35:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="Qbtl/85x"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="pMv1MuB4"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w7n81NV5zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 17:33:48 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 8C67421F6E;
 Thu,  7 Feb 2019 01:33:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 07 Feb 2019 01:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 /alPz5zbuimdrNKT2qU+1G6gbIf8THGxgM7uGAr4Ca8=; b=Qbtl/85xWvFXw2HO
 CrJHEYZ/kObaKk0xaVxUj5gShW1GrPsOpGGV+Yqs7KSLFDwkN5cdCRaRUcqHYi8B
 pn55s+RiLqAQR/8lAJT4phOuf8TD1GVn+0+5W4N2dYhZvrad+ouO7/eILfmhOsuy
 mIctvSsUWXqAK2zQDQ79K0GYo5MOlPv0MHdCUJfqKHcHtysLrx6dIuYPIaHLUw7Z
 R9ycIv/EXazI4eALlqDLfK1S20VjaNGtzKUSfOJiXnnPPSLFYx4aqeY+iw+b4BUe
 6uWrqBJ7yE06DqthPP7/qhOUaqOIEYJhsvHxa/YGwzMZErhaSzPUJ4YDnc0bakUB
 gchxQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=/alPz5zbuimdrNKT2qU+1G6gbIf8THGxgM7uGAr4C
 a8=; b=pMv1MuB4wl5N3tcVsU0zOFqeWj82wPPL0+mC0Yw/EecmyyTWujxuGL7qT
 2p6K+FVovs5LUKMnTrThdrtcbOj4sPrSN5pd0nSmNbJkSOLMuc5R/Zyz7V3x05Qs
 2WMnwYGD9eTvtRrtTij/h8hZ98PkLQtUBGEY6aYPlHB5HMJLqnvYwoI91C8PQwoK
 Cpyn7ix3cEHaiQuP/81oTubPmuvmjI/wm4FYOzfYfImU2HJAnuUUY2bZplXmjD2X
 IcVhJWDcJiAXSbnp+K5WfUdSDhBnJnRkE/SUPgApa0MQD7brn36KnqJKn6stJtjn
 cC5Vk2EMdy6jfajnyz7arwwaGXgdA==
X-ME-Sender: <xms:RtFbXK6qCxgx5s_HUmquEWbqZB4G2__8yuGJEO0lUjrpoHU3KMYVNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeelgdelfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
 enucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftuhhs
 shgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucffoh
 hmrghinhepsghoohhkfehsrdhssgenucfkphepuddvvddrleelrdekvddruddtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluh
 hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:RtFbXE1-8DAkzYEGUfK-Jd30OEPeykXeMKA-CxxQhs_hBmaZbViXFA>
 <xmx:RtFbXJz6h_uGPWDokn2vdK4xAKsquRnxg2H7v-_TKdM03XSc6lWBGQ>
 <xmx:RtFbXFmmX0EAN9ThQs3iiIzZKZYLrSf1wIcUfXNUj-aaXdxWUyr2-w>
 <xmx:R9FbXIUfOTKNXvtAM38cba_U72lHtNU-ev5trFceRcyLmSWAVdlSSg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2C8581030F;
 Thu,  7 Feb 2019 01:33:40 -0500 (EST)
Message-ID: <d7e1bb36080c83353525c39c7bcff7bb7046bae0.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
From: Russell Currey <ruscur@russell.cc>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 07 Feb 2019 17:33:38 +1100
In-Reply-To: <1549515373.con208q1rq.astroid@bobo.none>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-07 at 15:08 +1000, Nicholas Piggin wrote:
> Russell Currey's on February 6, 2019 4:28 pm:
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
> 
> Good catch and debugging. This really should be a quirk, we don't
> want 
> to have to restore this thing on a thread switch.
> 
> Can we put it under a CONFIG option if we're not using IAMR?

I don't exactly know when we do or don't use the IAMR (since the only
thing I've used it for is radix).  When wouldn't we care about
restoring it on hash?

> 
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
> 
> Sigh, good old isync. Suspect you'll get away without it, mtmsrd L=0 
> just below is architecturally guaranteeing a CSI, so just add a
> comment 
> there, might save a flush.

Makes sense, I wanted to be super safe with this, will drop the isync
and try to execute userspace nonstop and see if there are any (non)
failures.

> 
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
> 
> For the noloss part, it should mean really nothing lost including
> GPRs, 
> so I think IAMR *should* be okay here.

Sweet, will drop.

Thanks for the review!

> 
> Thanks,
> Nick

