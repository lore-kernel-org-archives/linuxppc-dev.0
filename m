Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44104C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 09:55:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF472086D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 09:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF472086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TG2g3gHgzF3Dr
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 20:55:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TG0Z0QnQzF3Bd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 20:54:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42TG0Y6w1Nz8sxN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 20:54:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42TG0Y6fp1z9sD2; Mon,  8 Oct 2018 20:54:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42TG0W4KP3z9s9J
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2018 20:54:03 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w989roop003780;
 Mon, 8 Oct 2018 04:53:52 -0500
Message-ID: <898c4d47e80562b843fcf4c7ba03eb6f4c9c5d5b.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix HMIs on big-endian with CONFIG_RELOCATABLE=y
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 08 Oct 2018 20:53:49 +1100
In-Reply-To: <20181008170435.0ef2d573@roar.ozlabs.ibm.com>
References: <e4bfa53ea8c777105359e1770df906909dde2c57.camel@kernel.crashing.org>
 <20181008170435.0ef2d573@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-08 at 17:04 +1000, Nicholas Piggin wrote:
> On Mon, 08 Oct 2018 15:08:31 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > HMIs will crash the kernel due to
> > 
> > 	BRANCH_LINK_TO_FAR(hmi_exception_realmode)
> > 
> > Calling into the OPD instead of the actual code.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > This hack fixes it for me, but it's not great. Nick, any better idea ?
> 
> Is it a hack because the ifdef gunk, or because there's something
> deeper wrong with using the .sym?

I'd say ifdef gunk, also the KVM use doesn't need it bcs the kvm entry
isn't an OPD.

> I guess all those handlers that load label address by hand could have
> the bug silently creep in. Can we have them use the DOTSYM() macro?

The KVM one doesnt have a dotsym does it ?

Also should we load the TOC from the OPD ?

> Thanks,
> Nick
> 
> > 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index ea04dfb..752709cc8 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1119,7 +1119,11 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
> >  	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
> >  	EXCEPTION_PROLOG_COMMON_3(0xe60)
> >  	addi	r3,r1,STACK_FRAME_OVERHEAD
> > +#ifdef PPC64_ELF_ABI_v1
> > +	BRANCH_LINK_TO_FAR(.hmi_exception_realmode) /* Function call ABI */
> > +#else
> >  	BRANCH_LINK_TO_FAR(hmi_exception_realmode) /* Function call ABI */
> > +#endif
> >  	cmpdi	cr0,r3,0
> >  
> >  	/* Windup the stack. */
> > 
> > 

