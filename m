Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99574C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC33206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="PaLZkic3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bdBa2ffw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC33206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Fhp1VNgzDqBh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:28:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="PaLZkic3"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="bdBa2ffw"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444FdZ3QPXzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:25:22 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id EB1CA231AA;
 Wed, 20 Feb 2019 06:25:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 06:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 zr1Nbcv3N1dVQLIYLDMo3+Mm2c3CT03ume6E3cK2OnQ=; b=PaLZkic3+ZJS/uf9
 +TIiSqKj4SgkaWrUMMrNs7lqExKdeiv8ZAkcBmLIpCCBxGfy+BLerz7x4TwyUb1I
 yE+XthGCWCkDi+KfEByxG2W+EICwt2k4bfRsUsBecdP6m30R7PLfW2aSa1qIEQsO
 y46iZGV7000KebghxLuHWSjt9G3vTDPw6NIzYIqLdohafNt2EL6HUbSYaKPamy5o
 E/NRxJYVGfEuJFo/bAGed1tlJ5D5i4+CEMrklZl7P7Yt3Tvam6G9UmOpO4g11IY+
 Md5Pp8kC16/1vBrM1SSpGciiTeccaHASnoLznvqmmHH0ZIzns2xlfuk0FICL4sTk
 /+5TCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=zr1Nbcv3N1dVQLIYLDMo3+Mm2c3CT03ume6E3cK2O
 nQ=; b=bdBa2ffwZBcPIf1LOa6LJHMoeDyuXQJcmeVYbqEyCCzRJ2TWf+3dK3gHG
 STFQpFopZD2t1IBLSzZQplmF9+FdFUqy1jJoY2KbSWK0n2dnbh1rWQwukaIujogx
 L/ZJBzhmXIzLJUzm4gCEeXvzmLfSp9JMPECu9iJrq1mxiOQ6Z4jucwU7Aj66G1Sx
 ISGleLUwBlCQ6KNqvHuI1c+A7ZF8hSt6ATsilLdEgcoaTavIeVRNwzK3BvXiZUNe
 mGCunbrTRNr7CWLJFkVe2N6OxGhPBZlQgv2PZJfZfaMIoZkfZgWaVGeJKZ3H6yyd
 Ih0JgLBxKXaYlhcmYaHu59rdgw2+w==
X-ME-Sender: <xms:HjltXC9gw2YvT1D09xDd52Vok9CepbZdQIjp0TdhqJYbctleF5F9Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeigddvkeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucffohhmrghinhepsghoohhkfehsrdhssgenucfkphepuddvuddr
 geehrddvudelrdefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhush
 hsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:HjltXNYGlNmm_w519hhyUPeI0SdGlZvTNL9g045DWVFhW45mgkJMTg>
 <xmx:HjltXOrfMpBOI68l5J1z8NrtKYn8yC9Abedw0JW_MLYe6E2FMy3_9w>
 <xmx:HjltXFYutg9TieUcWuzGlcPqu3HvML54cLz4hpJqqVpKn8dy0Ts5Qw>
 <xmx:HzltXOoQHYVLDxPRA2KC3V3hkkee9p4B0-QFCqCcYj8MsM7TKB4afw>
Received: from crackle.ozlabs.ibm.com
 (ppp121-45-219-3.bras1.cbr2.internode.on.net [121.45.219.3])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5C3BFE44DF;
 Wed, 20 Feb 2019 06:25:17 -0500 (EST)
Message-ID: <c9e2c03da5f2ccf351f5417b5a6deaf321699707.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
From: Russell Currey <ruscur@russell.cc>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Wed, 20 Feb 2019 22:25:15 +1100
In-Reply-To: <20190220071503.GA4708@aks.ibm>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <20190220071503.GA4708@aks.ibm>
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

On Wed, 2019-02-20 at 12:45 +0530, Akshay Adiga wrote:
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
> 
> Are we trying to add for both power8 and power9 ?
> power9 would be CPU_FTR_ARCH_300.
> 

If I recall correctly I had this at P9 only but for some reason I
changed it - the reason is probably just that I had it confused for
something else.  Michael can you confirm this should be P9 only?

