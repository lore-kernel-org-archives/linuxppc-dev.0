Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C74ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 02:05:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7ED2083A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 02:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzR0ksYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7ED2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bC6f0vs1zF3T5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:04:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzR0ksYG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="BzR0ksYG"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bC3w2JlkzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 13:02:33 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 084F38E0;
 Wed, 17 Oct 2018 22:02:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 22:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=8yLHTo39d+7MIom8JxKSqWwKlmstFb2sLhPsAguBC
 Y4=; b=BzR0ksYGK4anjXrHYePYfuGwx5skqkaN6mH/vHy1t9aagw6RcZX4rbXm6
 HqeF3hDHx9y+mjkLn73t5lcpF/ioS8AmPeMKLxyRMbET+Xq16GxG7H3EUV3i+P98
 pH/meGxTgPJNQaYo706RYXbpvStIYwkDHwVzggx+KAAauHnYXCFBdAgFFFkR9roN
 ySlFNmPENFTNFS6x9wpbQiuNFBzMGSvWU3l6YB39iO0ePQ97fy5YCAZZKdRV3Hji
 UmvBDsy9v+kU/Fm4sFJgO85jXK3ELvkBWVGHmY06BZXRbINFyN+j6PKMwrUINhku
 vEpXx7CvdzhV/BsripoIYkWRzuIkg==
X-ME-Sender: <xms:tenHWwLLiJaWeQj2BzqB2VpEDuDIwHRbyVuqItya3Qh3YM_Xe0BxFg>
X-ME-Proxy: <xmx:tenHW3pBM0LBPEtdd6yx8p1s5eyGSeXI5cPgzzSQrtwHM_Qm3H--5A>
 <xmx:tenHW_Bznru-jShvmEPhCh1Uo1Qe2vgSsPuXua5xtst6p4I6b2lf4g>
 <xmx:tenHWwPywhTtCWynX5gFK5x_3A2itv6gqIpyyrswlPXXbU1tRN7SLA>
 <xmx:tenHW-k__lI-WCgjcfgEVQDJmWgnw4zLFmoqeT_ciBoUBjTr59l5pg>
 <xmx:tenHWyfYFPno27blDbB9H26dKXfTWmpmxHBiF_f5t31UIrCK6oUE8Q>
 <xmx:tunHW0lAV3HyfiQ6_FoT327YPvorBg8dxKqPd2aHi7tF4C9o-bVxvg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 28120E4430;
 Wed, 17 Oct 2018 22:02:27 -0400 (EDT)
Message-ID: <fb7bc2f990d19f357d97a8d609875368e44152a0.camel@russell.cc>
Subject: Re: [PATCH 1/5] powerpc/64s: Kernel Hypervisor Restricted Access
 Prevention
From: Russell Currey <ruscur@russell.cc>
To: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 18 Oct 2018 13:02:21 +1100
In-Reply-To: <20181017225913.6026e6f4@roar.ozlabs.ibm.com>
References: <20181017064422.26119-1-ruscur@russell.cc>
 <20181017225913.6026e6f4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-17 at 22:59 +1000, Nicholas Piggin wrote:
> On Wed, 17 Oct 2018 17:44:19 +1100
> Russell Currey <ruscur@russell.cc> wrote:
> 
> > Kernel Hypervisor Restricted Access Prevention (KHRAP) utilises a
> > feature
> > of the Radix MMU which disallows read and write access to userspace
> > addresses.  By utilising this, the kernel is prevented from
> > accessing
> > user data from outside of trusted paths that perform proper safety
> > checks,
> > such as copy_{to/from}_user() and friends.
> > 
> > Userspace access is disabled from early boot and is only enabled
> > when:
> > 
> > 	- exiting the kernel and entering userspace
> > 	- performing an operation like copy_{to/from}_user()
> > 	- context switching to a process that has access enabled
> > 
> > and similarly, access is disabled again when exiting userspace and
> > entering
> > the kernel.
> > 
> > This feature has a slight performance impact which I roughly
> > measured to be
> > 4% slower (performing 1GB of 1 byte read()/write() syscalls), and
> > is gated
> > behind the CONFIG_PPC_RADIX_KHRAP option for performance-critical
> > builds.
> > 
> > This feature can be tested by using the lkdtm driver
> > (CONFIG_LKDTM=y) and
> > performing the following:
> > 
> > 	echo ACCESS_USERSPACE > [debugfs]/provoke-crash/DIRECT
> > 
> > if enabled, this should send SIGSEGV to the thread.
> > 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> > More detailed benchmarks soon, there's more optimisations here as
> > well.
> 
> Nice, this turned out to be a lot neater than I feared! Good stuff.
> 
> > @@ -240,6 +240,22 @@ BEGIN_FTR_SECTION_NESTED(941)			
> > 			\
> >  	mtspr	SPRN_PPR,ra;						
> > \
> >  END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
> >  
> > +#define LOCK_AMR(reg)						
> > 	\
> > +BEGIN_MMU_FTR_SECTION_NESTED(69)					
> > 	\
> > +	LOAD_REG_IMMEDIATE(reg,AMR_LOCKED);				\
> > +	isync;				    				
> > \
> > +	mtspr	SPRN_AMR,reg;						
> > \
> > +	isync;								
> > \
> > +END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KHRAP,MMU_FTR_RADIX_KHRAP
> > ,69)
> > +
> > +#define UNLOCK_AMR(reg)						
> > 	\
> > +BEGIN_MMU_FTR_SECTION_NESTED(420)					
> > 	\
> > +	li	reg,0;							\
> > +	isync;				    				
> > \
> > +	mtspr	SPRN_AMR,reg;						
> > \
> > +	isync;								
> > \
> > +END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KHRAP,MMU_FTR_RADIX_KHRAP
> > ,420)
> 
> I wonder if you can skip the first isync on the way in and the second
> isync on the way out because the interrupt and return should be
> context
> synchronizing. Might not make a difference though.

Ben thought we wouldn't need at least one of them, but it's
implementation dependent, so there might be some concern with future
chips actually needing both isyncs or something.  There weren't any
consequences to leaving out isyncs, I'll do some quick benchmarking to
see if it's any meaningful speedup to leave one out.

> 
> What do you think about making the name match the C code a bit more.
> Like AMR_LOCK_USER_ACCESS()?

That is a good idea.

> 
> Thanks,
> Nick

