Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40CC433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 07:31:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD938613D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 07:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD938613D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQC0B1lX9z30C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 17:31:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=qpHc+zb1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=qpHc+zb1; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQBzj6PZDz2xZN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 17:30:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FQBzh4Fdbz9tk7;
 Wed, 21 Apr 2021 17:30:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618990241;
 bh=05qa/uEa3kDOY1QiKL8tjTnj6osJUyJBCp7Q+LVFsDc=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=qpHc+zb14AouVo2DVlFwdusnpL88sugen5A8ikgraqCx/WaXo3jvUlu/9dGZUzZ3Z
 0nNdGutaEVx8fCSLrdzej3iTpIAU34py3mrErTmTAdXidx+/KAMHGVROwgrISS5Oht
 XUcw2ADJ3n40nkKXAQcoUH8598UNYE4y28L0vaD62XO77Dl9xbqnxcpsL0OjYH8zH2
 GBB7AyCR5B50blPAhRz8n2xadE/4wfDcz8w6cfJ0V9GaIliQBa/5Q0xLDg35cviQIB
 Qq0hz5Phscw5aaxr3QzNucCRhRawMl2WFEhF0Fzpdki6upxsBajo4x3bog20rb6mh9
 ct/zL5En1aXMg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Daniel Axtens
 <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org, Sathvika Vasireddy
 <sathvika@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/sstep: Add emulation support for
 =?utf-8?B?4oCYc2V0YuKAmQ==?= instruction
In-Reply-To: <1618899164.u2uju6vw3c.naveen@linux.ibm.com>
References: <cover.1618469454.git.sathvika@linux.vnet.ibm.com>
 <767e53c4c27da024ca277e21ffcd0cff131f5c73.1618469454.git.sathvika@linux.vnet.ibm.com>
 <875z0mfzbf.fsf@linkitivity.dja.id.au>
 <1618899164.u2uju6vw3c.naveen@linux.ibm.com>
Date: Wed, 21 Apr 2021 17:30:39 +1000
Message-ID: <87lf9caycg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> writes:
> Daniel Axtens wrote:
>> Sathvika Vasireddy <sathvika@linux.vnet.ibm.com> writes:
>> 
>>> This adds emulation support for the following instruction:
>>>    * Set Boolean (setb)
>>>
>>> Signed-off-by: Sathvika Vasireddy <sathvika@linux.vnet.ibm.com>
...
>> 
>> If you do end up respinning the patch, I think it would be good to make
>> the maths a bit clearer. I think it works because a left shift of 2 is
>> the same as multiplying by 4, but it would be easier to follow if you
>> used a temporary variable for btf.
>
> Indeed. I wonder if it is better to follow the ISA itself. Per the ISA, 
> the bit we are interested in is:
> 	4 x BFA + 32
>
> So, if we use that along with the PPC_BIT() macro, we get:
> 	if (regs->ccr & PPC_BIT(ra + 32))

Use of PPC_BIT risks annoying your maintainer :)

cheers
