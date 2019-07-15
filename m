Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD680C7618A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 04:12:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329AF2067C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 04:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329AF2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45n98j4c5pzDqVT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 14:12:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45n96T548QzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 14:10:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45n96S5d7nz9sPM; Mon, 15 Jul 2019 14:10:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45n96S4xBdz9s7T;
 Mon, 15 Jul 2019 14:10:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Claudio Carvalho <cclaudio@linux.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4 2/8] powerpc: Introduce FW_FEATURE_ULTRAVISOR
In-Reply-To: <4da093e5-14ea-963b-9e8d-a6ba2aa4678f@linux.ibm.com>
References: <20190628200825.31049-1-cclaudio@linux.ibm.com>
 <20190628200825.31049-3-cclaudio@linux.ibm.com>
 <87k1cog250.fsf@concordia.ellerman.id.au>
 <4da093e5-14ea-963b-9e8d-a6ba2aa4678f@linux.ibm.com>
Date: Mon, 15 Jul 2019 14:10:08 +1000
Message-ID: <878st09bvj.fsf@concordia.ellerman.id.au>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 Ryan Grimm <grimm@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Claudio Carvalho <cclaudio@linux.ibm.com> writes:
> On 7/11/19 9:57 AM, Michael Ellerman wrote:
>> Claudio Carvalho <cclaudio@linux.ibm.com> writes:
>>> diff --git a/arch/powerpc/include/asm/ultravisor.h b/arch/powerpc/include/asm/ultravisor.h
>>> new file mode 100644
>>> index 000000000000..e5009b0d84ea
>>> --- /dev/null
>>> +++ b/arch/powerpc/include/asm/ultravisor.h
>>> @@ -0,0 +1,15 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Ultravisor definitions
>>> + *
>>> + * Copyright 2019, IBM Corporation.
>>> + *
>>> + */
>>> +#ifndef _ASM_POWERPC_ULTRAVISOR_H
>>> +#define _ASM_POWERPC_ULTRAVISOR_H
>>> +
>>> +/* Internal functions */
>>> +extern int early_init_dt_scan_ultravisor(unsigned long node, const char *uname,
>>> +					 int depth, void *data);
>> Please don't use extern in new headers.
>>
>>> diff --git a/arch/powerpc/kernel/ultravisor.c b/arch/powerpc/kernel/ultravisor.c
>>> new file mode 100644
>>> index 000000000000..dc6021f63c97
>>> --- /dev/null
>>> +++ b/arch/powerpc/kernel/ultravisor.c
>> Is there a reason this (and other later files) aren't in platforms/powernv ?
>
> Yes, there is.
> https://www.spinics.net/lists/kvm-ppc/msg14998.html
>
> We also need to do ucalls from a secure guest and its kernel may not
> have CONFIG_PPC_POWERNV=y. I can make it clear in the commit message.

OK, sorry I missed Paul's comment. Yeah that is obviously a valid reason :)

>>> @@ -0,0 +1,24 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Ultravisor high level interfaces
>>> + *
>>> + * Copyright 2019, IBM Corporation.
>>> + *
>>> + */
>>> +#include <linux/init.h>
>>> +#include <linux/printk.h>
>>> +#include <linux/string.h>
>>> +
>>> +#include <asm/ultravisor.h>
>>> +#include <asm/firmware.h>
>>> +
>>> +int __init early_init_dt_scan_ultravisor(unsigned long node, const char *uname,
>>> +					 int depth, void *data)
>>> +{
>>> +	if (depth != 1 || strcmp(uname, "ibm,ultravisor") != 0)
>>> +		return 0;
>> I know you're following the example of OPAL, but this is not the best
>> way to search for the ultravisor node.
>>
>> It makes the location and name of the node part of the ABI, when there's
>> no need for it to be.
>>
>> If instead you just scan the tree for a node that is *compatible* with
>> "ibm,ultravisor" (or whatever compatible string) then the node can be
>> placed any where in the tree and have any name, which gives us the most
>> flexibility in future to change the location of the device tree node.
>
> I will do that in the next version.

Excellent, thanks.

cheers
