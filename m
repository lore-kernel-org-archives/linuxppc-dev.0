Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F18ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 02:07:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D7B2083A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 02:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wl672WWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D7B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bC9M4XnDzF3T9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:07:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wl672WWF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Wl672WWF"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bC4s6N0pzF3V3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 13:03:25 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 6AA1D93A;
 Wed, 17 Oct 2018 22:03:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 22:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=UgoQ5PLHrjFwmt6s0P4s+yJpIdBde79IadwsASg81
 44=; b=Wl672WWF/KQjBHXdUjtSvxyO4HCjPkuSK4odBHRrPPp2VeZ9XVFzjzH8N
 Yv1jSsw/H3CivjDX15ymDWrTdZ9EEA2uGGLDzxMyW8HouNScLfKsKdvrKPsH7KQd
 q7iEfFH5NiTBsmYewAsFRzNWNN4FLcAClLQygD2F75dVKUn5A5BfYzEyWsH8PeQp
 cWHdNbHbs8FrmcPwQWS7ywUWhmkIOUoBT11npRRtpuQrPMOBeIJMs5+8A7tE1/RA
 UeWaHYY7Kn6b+bZR0B9ogcjdY+CqJ5qswJEvIo4UKcNjVnrL4OVsKpnz49O93BJt
 dtSWBodtk95DmpnhBdnfBieB88QKA==
X-ME-Sender: <xms:6unHW2vxvSqEBfTxwgiVsmXjMtWks-XIPQChWZ4uPBAglfoWIgYvvg>
X-ME-Proxy: <xmx:6unHW6uojuKpssUm3WnTFmGjO_Sk9ccnCyS2Wf39slL0cbAUVAG6Bg>
 <xmx:6unHW0cQEbCg0tLzvUZhPCsVh4Z6NA-eWLCWlHkrCLnq6ra1S8DgCw>
 <xmx:6unHW2p_xPrb-kICx0mXh7N2S25zAC4F4tq0oEhmBGFlCziAP4ptkw>
 <xmx:6unHW6-_mYbRWwvB4AwYuWkdct42kW7t4WTmCPRrxaFT_f37I03cbQ>
 <xmx:6unHW34uOv8A6Lw7ugEZhiSXCZtQX4n2J54eVWK-ZiFpRR7ss5rtJQ>
 <xmx:6-nHWyUhtVCw3Svc3JRdWXvCBUr-j6K7qPHLWWoQhMOs3Evye5PtTA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 903B9102E9;
 Wed, 17 Oct 2018 22:03:20 -0400 (EDT)
Message-ID: <50aa928e893a75cfaaa87f8a3b4591a28a2b6dce.camel@russell.cc>
Subject: Re: [PATCH 1/5] powerpc/64s: Kernel Hypervisor Restricted Access
 Prevention
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 18 Oct 2018 13:03:19 +1100
In-Reply-To: <87bm7sero1.fsf@concordia.ellerman.id.au>
References: <20181017064422.26119-1-ruscur@russell.cc>
 <87bm7sero1.fsf@concordia.ellerman.id.au>
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
Cc: mikey@neuling.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-17 at 22:30 +1100, Michael Ellerman wrote:
> Russell Currey <ruscur@russell.cc> writes:
> > diff --git a/arch/powerpc/kernel/entry_64.S
> > b/arch/powerpc/kernel/entry_64.S
> > index 7b1693adff2a..090f72cbb02d 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -286,6 +286,9 @@ BEGIN_FTR_SECTION
> >  	HMT_MEDIUM_LOW
> >  END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> >  
> > +	/* headed back to userspace, so unlock the AMR */
> > +	UNLOCK_AMR(r2)
> > +
> 
> This one needs an ifdef, or preferable an empty version in a header
> for
> non-book3s 64, otherwise we get:
> 
>   arch/powerpc/kernel/entry_64.S: Assembler messages:
>   arch/powerpc/kernel/entry_64.S:290: Error: unrecognized opcode:
> `unlock_amr(%r2)'
>   scripts/Makefile.build:405: recipe for target
> 'arch/powerpc/kernel/entry_64.o' failed
> 
> That's a corenet64-ish defconfig.

Yep, sorry.  I knew it wouldn't build on non-64s but I just wanted to
get the main part out there so people could start looking at it.  Will
fix.

- Russell

> 
> cheers

