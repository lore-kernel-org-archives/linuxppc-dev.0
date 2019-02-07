Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF7C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:30:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DBF2147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="ONBJH0DQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjTapw3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DBF2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w7hk4tgtzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 17:29:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="ONBJH0DQ"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="AjTapw3S"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w7fq6SXGzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 17:28:19 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 3FDC721DE0;
 Thu,  7 Feb 2019 01:28:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 07 Feb 2019 01:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 8cUrXro0xLWjpwCcBuG7x/ozaMXERlCJ55hO5JXAM6g=; b=ONBJH0DQQrN9wwBM
 woz4+wnSDDgoKTyUgnCnjQj5zt7Dn78SBo31kUbm5cibQuj6Lcu9EXnF5S5vaMhO
 MSoZE36nE71ge+cf4PlwwnzD8qwGCSluuZwnSI8Yxy60RvGKkB8DC4cJvltTvgWt
 pVdll3GCCr6TxrvPESvXb5m35dPlJBcH9bjHGKdq4t2mF2s/KSkSYS6qpEBjmHuz
 yY0qFDWmd45axhhcjycqEwCrIVPJwGSIVheyBZ10yXMYg85YyeBYa2wdHAy+UqLf
 aF4jheBbkNFUQUA2EJtAq+yh7s0zobQ9rFe2ON5n4/chnRQapni+t/JFx8lGdBOU
 WB4kCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=8cUrXro0xLWjpwCcBuG7x/ozaMXERlCJ55hO5JXAM
 6g=; b=AjTapw3S5m31Aiw5pBUkyGntzeriA20IgPr3++qBzunCx5fxq6LB+zr46
 fa1BIXxuz/mRkI+nwwOzHQQstvJpE90TPxGD2/S0BejqY3gMIlH1iQb/8Rddz+EG
 tMBGMrhV0iv266xgmyyCWY0G3r452m3G1s4s3xIbCL+VWYeLKTy3iuLCqsgYwH5M
 oKsh0jB8D33Ztim0pW9dEkpDHs7eO5W70bIBvkQXiC2ErRy0dkid8bAo4tI6nORu
 26Exq2JlaBws97Q+kodfpbMMlgoFqSx4Mx6EkbRl0cyPz59EnI8HGuHsqtaw80Hm
 UiFGAGmirUMB/R77Qjzzj7yhY9K2w==
X-ME-Sender: <xms:ANBbXJxhHFj5PwGlRTEY1F9c-IG7hC09vnPaBQz9nOvXYlcIjc751g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeelgdelfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtje
 ertddtreejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhes
 rhhushhsvghllhdrtggtqeenucffohhmrghinhepsghoohhkfehsrdhssgenucfkphepud
 dvvddrleelrdekvddruddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhes
 rhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ANBbXHEUBEzz-QcDMfqVjTOWrsU6PeL5vqF1l4iSfynrsMEhcC2HTw>
 <xmx:ANBbXEO5KP9rC7VSS9vMnpRCt6dJF3pG7Zl0YCoW5Ja67Mdb8a8Jyg>
 <xmx:ANBbXGcaZXVLSVJtNbs25cq5blxqqgrP98_qykOv_seYFIvBn9H91w>
 <xmx:AdBbXJnBaYWjnCa-xL3rmpneadKuiBjCAFqDdo18O0PvkzJoect2Kg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5BD041030F;
 Thu,  7 Feb 2019 01:28:15 -0500 (EST)
Message-ID: <a4afd7f789c9f20f41f06e62b485036602aa6d85.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 07 Feb 2019 17:28:11 +1100
In-Reply-To: <875ztwkyqu.fsf@concordia.ellerman.id.au>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <875ztwkyqu.fsf@concordia.ellerman.id.au>
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

On Thu, 2019-02-07 at 15:29 +1100, Michael Ellerman wrote:
> Russell Currey <ruscur@russell.cc> writes:
> > 
> > Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of
> > user
> > space")
> 
> Don't word wrap the fixes line please.

My bad, will teach my editor :)

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
> 
> We don't actually need to put this in the paca anymore.
> 
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
> 
> We have space for a full pt_regs on the stack, and we're not using it
> all.
> 
> We don't have a specific slot for the IAMR (we may want to in
> future),
> but for now you could follow the time-honoured tradition of (ab)using
> the _DAR slot, with an appropriate comment.

I read this, then did it, and when writing the comment I thought I was
clever using "(ab)use".  I then reread this and realised I just
subconsciously stole it.

Thanks for the review.

> cheers

