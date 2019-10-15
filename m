Return-Path: <SRS0=Pmlw=YI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EEFC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 10:02:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312BC2089C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YhiIDr4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312BC2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46srZ12VNnzDqwm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 21:02:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46srWF0x97zDqw1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2019 20:59:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="YhiIDr4g"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 46srWD68tvz9sPJ; Tue, 15 Oct 2019 20:59:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46srWC5sZyz9sPF;
 Tue, 15 Oct 2019 20:59:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1571133576;
 bh=g7FNvEmUMKUBTSEs/cnh7zM1HyCNiU5+T2IblHoqAb0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YhiIDr4gz6XDbMGr15Sc7t/zYDWa3ckmLK2XTtTmSgqqrNXBz3WCh1sI7ugcw7No9
 9z/qYOLr8MUPtAKaVi6QmsvCB+7syHLOtLjJMiLHvuVXrmdhQ4kfc4R/hxhAzoqcWc
 DXrJZVow2QCc1+8qU0s/wthBbQykITP7zxw6ctjJwt4d++rY+SWJGL4nH5dUvX9Ymv
 IlRkxldrLGRye660X7Ik8GGe+BCEWbA2Gw87Q+Xg1ydHXlKtoT1RN/BHCo0LAQcUO9
 0pu9XfAzqas4SdhbSR34cVXh+P3Yl/xhSjCSnzZYeqor9s72u1idfYI6KnZza8CMRy
 b2RE/asCPE4Nw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 2/8] powerpc: add support to initialize ima policy rules
In-Reply-To: <1570799579.5250.72.camel@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
 <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
 <1570799579.5250.72.camel@linux.ibm.com>
Date: Tue, 15 Oct 2019 20:59:34 +1100
Message-ID: <87bluiuy61.fsf@mpe.ellerman.id.au>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Elaine Palmer <erpalmer@us.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver O'Halloran <oohall@gmail.com>, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mimi Zohar <zohar@linux.ibm.com> writes:
> On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
...
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index b4a221886fcf..deb19ec6ba3d 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -938,6 +938,8 @@ config PPC_SECURE_BOOT
>>  	prompt "Enable secure boot support"
>>  	bool
>>  	depends on PPC_POWERNV
>> +	depends on IMA
>> +	depends on IMA_ARCH_POLICY
>
> As IMA_ARCH_POLICY is dependent on IMA, I don't see a need for
> depending on both IMA and IMA_ARCH_POLICY.

I agree. And what we actually depend on is the arch part, so it should
depend on just IMA_ARCH_POLICY.

cheers
