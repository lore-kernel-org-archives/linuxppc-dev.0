Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F5C64EB0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 03:45:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B020858
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 03:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tjn24mfpzF3HC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:45:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tjkz2twxzF3FZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 14:43:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Tjky33VDz9s7W;
 Tue,  9 Oct 2018 14:43:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/xmon/ppc-opc: Use ARRAY_SIZE macro
In-Reply-To: <8e2f906a85c3cfe0715982370a6d96f08a37987c.camel@perches.com>
References: <20181004171036.GA1907@embeddedor.com>
 <8e2f906a85c3cfe0715982370a6d96f08a37987c.camel@perches.com>
Date: Tue, 09 Oct 2018 14:43:53 +1100
Message-ID: <874ldv3hty.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joe Perches <joe@perches.com> writes:

> On Thu, 2018-10-04 at 19:10 +0200, Gustavo A. R. Silva wrote:
>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> []
>> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> []
>> @@ -966,8 +966,7 @@ const struct powerpc_operand powerpc_operands[] =
>>    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>>  };
>>  
>> -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
>> -					   / sizeof (powerpc_operands[0]));
>> +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
>
> It seems this is unused and could be deleted.

The code in this file is copied from binutils.

We don't want to needlessly diverge it.

I've said this before:

  https://lore.kernel.org/linuxppc-dev/874lfxjnzl.fsf@concordia.ellerman.id.au/

Is there some way we can blacklist this file from checkpatch, Coccinelle
etc?

cheers
