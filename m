Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 04:02:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DE42086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 04:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="mGjXfdsg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGY1LK8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DE42086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444glr3y6DzDqLp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 15:02:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="mGjXfdsg"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="BGY1LK8q"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444gjk3CThzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 15:00:26 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id A41DA23071;
 Wed, 20 Feb 2019 23:00:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 23:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 yf+TapOBW/wEReZxUrVlwahFsMtZzwjlAIuJyYNSqpc=; b=mGjXfdsgvxASqUO4
 oKTZj/zF7W6yNpF06upFGfM5BbHXk9cYpUa7zrcSLVSomiqKIHip6yzlAYk09sS0
 xt8zAmEdU/HrpHa3Tdbowg0C12TNYkoOdfdBJTKhoP3sq0zMmTL7jKiyba3qSlQC
 Vk6jvfcUncbTJ6UXGHN+USp4R9nIhR6ba6r/PvQ/DfOtkI/XEF8Bv3EErkd0xnfj
 iro8pMub4NupHgZ/Av0jTxMg+hGiE+WOwA/iGNqM7sHv+tOT50PrpxZjSt8lifAV
 5TYO3hQ8fh3Ldrwgn2RyKUJwCmVA0WnEKtzQWAOpKzr5DVgHoJFBYUbE0PPQk1JJ
 Zmi/mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=yf+TapOBW/wEReZxUrVlwahFsMtZzwjlAIuJyYNSq
 pc=; b=BGY1LK8qeegt//V6rbpuRM8ag0g33yjLsVIcKE93hWPjtM+PQn5jRs4Bd
 G5FVcNMtKrUFIhjLk8anPVM5iSlXZBthgw7zedYEHyI0Rw76vT3H+Y9Wgfbuyr8P
 Z4/tOluCWQiiqYl5cZwy9+ME89sWKE2uW3bdm78RuEyYFmfbCveJhrrunkwo4Qzq
 4O8RGl0/K9I72RDoPfaBU6FKLiFnUxShOkzeaREmjA1BOFM2hqGYnhRR9/s+P9HC
 R6DfCff63jcD1OB/1q4EgJBZuGDwymFMCZ1SlAhadtTMLDbNiKlveirCxz9yUOKa
 JF3NkyQWH8rCPziayL9Or/VMXe8tw==
X-ME-Sender: <xms:VSJuXLs594-XE79Ye-Dkm8sowwmPPKBbPXyWWesH4Swz_-ipTZqvSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdeiheculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefkuf
 fhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
 rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucffohhmrghinheprhhmhh
 grnhgulhgvrhhsrdhssgdpohiilhgrsghsrdhorhhgnecukfhppeduvddvrdelledrkedv
 rddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrd
 gttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VSJuXOSBLtIFesmM0V9hNpEtuwuzIGfVtZepxWClxqV8zFGhNKXL9A>
 <xmx:VSJuXAhQFVs9aDoj5ybAs-5fuWxIGBLGraD2TL-p122yjz9NTfJYFg>
 <xmx:VSJuXLYNfG2RB6EDLNi_FeoUYnrqgq2FIdN9WBKquoY4IQVrVohppQ>
 <xmx:VyJuXEKkl235Ng1Htg4XFUa3-UzuApMSdEf00LLxcgHMwFIXchbWJA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id B042510318;
 Wed, 20 Feb 2019 23:00:19 -0500 (EST)
Message-ID: <74c173f14fefc68afa188120cb1a2dc0e04274a3.camel@russell.cc>
Subject: Re: [PATCH] powerpc/kvm: Save and restore AMR instead of zeroing
From: Russell Currey <ruscur@russell.cc>
To: Paul Mackerras <paulus@ozlabs.org>
Date: Thu, 21 Feb 2019 15:00:16 +1100
In-Reply-To: <20190220235530.pl36pd56hs5rfcup@oak.ozlabs.ibm.com>
References: <20190220045958.14966-1-ruscur@russell.cc>
 <20190220235530.pl36pd56hs5rfcup@oak.ozlabs.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-21 at 10:55 +1100, Paul Mackerras wrote:
> On Wed, Feb 20, 2019 at 03:59:58PM +1100, Russell Currey wrote:
> > Using the hash MMU on P7+, the AMR is used for pkeys.  It's
> > important
> 
> This needs a bit of rewording.  The "Using" ... "used" construct is a
> bit confusing on the first read.  Also, there was a processor called
> P7+, but I think you're trying to say P7 and subsequent processors.

Okay, will do.

> 
> > that the host and guest never end up with each other's AMR value,
> > since
> > this could disrupt operations and break things.
> 
> What sort of breakage?  Guest kernel crash?  Host kernel crash?

Well you'll have incorrect pkeys.  It wouldn't cause a kernel crash,
but it could mean a userspace program could no longer access data it
had protected, or that its protected data is now unprotected.

> 
> > The AMR gets correctly restored on context switch, however before
> > this
> > happens (i.e. in a program like qemu) having the host value of the
> > AMR
> > be zero would interfere with that program using pkeys.
> > 
> > In addition, the AMR on Radix can control kernel access to
> > userspace
> > data, which you wouldn't want to be zeroed.
> > 
> > So, just save and restore it like the other registers that get
> > saved and
> > restored.
> > 
> > Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> > Cc: <stable@vger.kernel.org> # v4.16+
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> > I'm not entirely sure the stack frame numbers are correct, I've
> > tested it
> > and it works but it'd be good if someone could double check this.
> > 
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index 9b8d50a7cbaf..6291751c4ad9 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -47,7 +47,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
> >  #define NAPPING_NOVCPU	2
> >  
> >  /* Stack frame offsets for kvmppc_hv_entry */
> > -#define SFS			208
> > +#define SFS			224		/* must be
> > divisible by 16 */
> 
> I don't think this needs to be increased.  What's happening here is
> that we have a "short path" where most SPRs are saved/loaded/restored
> etc. in C code in book3s_hv.c, and that path uses 144 bytes on the
> stack to save/restore 18 GPR values (r14 - r31).  Your patch needs to
> add code to context-switch AMR in kvmhv_p9_guest_entry() to fix that
> path.

Michael has already sent a separate patch to do this - separate because
that path is only used with radix guests on a radix host, right?  And
since radix doesn't make use of the AMR (yet) it's not a bug.

http://patchwork.ozlabs.org/patch/1045215/

(with an incorrect title)

> 
> Alternatively there is the slow path where we go to real mode and do
> most of the SPR loading in assembler code.  That path uses the stack
> to store host SPR values in STACK_SLOT_TID, PSSCR, PID, etc.
> 
> >  #define STACK_SLOT_TRAP		(SFS-4)
> >  #define STACK_SLOT_SHORT_PATH	(SFS-8)
> >  #define STACK_SLOT_TID		(SFS-16)
> > @@ -58,8 +58,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
> >  #define STACK_SLOT_DAWR		(SFS-56)
> >  #define STACK_SLOT_DAWRX	(SFS-64)
> >  #define STACK_SLOT_HFSCR	(SFS-72)
> > +#define STACK_SLOT_AMR		(SFS-80)
> >  /* the following is used by the P9 short path */
> > -#define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
> > +#define STACK_SLOT_NVGPRS	(SFS-160)	/* 18 gprs */
> 
> I don't see why you need to change this either.

So I can just add the AMR at -80 and leave everything else?

> 
> >  
> >  /*
> >   * Call kvmppc_hv_entry in real mode.
> > @@ -743,6 +744,9 @@ BEGIN_FTR_SECTION
> >  	std	r7, STACK_SLOT_DAWRX(r1)
> >  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> >  
> > +	mfspr	r5, SPRN_AMR
> > +	std	r5, STACK_SLOT_AMR(r1)
> > +
> >  BEGIN_FTR_SECTION
> >  	/* Set partition DABR */
> >  	/* Do this before re-enabling PMU to avoid P7 DABR corruption
> > bug */
> > @@ -1640,13 +1644,14 @@ BEGIN_FTR_SECTION
> >  END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
> >  8:
> >  
> > -	/* Save and reset AMR and UAMOR before turning on the MMU */
> > +	/* Save and restore/reset AMR and UAMOR before turning on the
> > MMU */
> >  	mfspr	r5,SPRN_AMR
> >  	mfspr	r6,SPRN_UAMOR
> >  	std	r5,VCPU_AMR(r9)
> >  	std	r6,VCPU_UAMOR(r9)
> > +	ld	r5,STACK_SLOT_AMR(r1)
> >  	li	r6,0
> > -	mtspr	SPRN_AMR,r6
> > +	mtspr	SPRN_AMR, r5
> >  	mtspr	SPRN_UAMOR, r6
> >  
> >  	/* Switch DSCR back to host value */
> > -- 
> > 2.20.1
> 
> Rest looks fine, but as I said, the patch needs to hit
> kvmhv_p9_guest_entry() also.
> 
> Paul.

