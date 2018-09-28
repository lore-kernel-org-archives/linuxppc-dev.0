Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C5C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 12:48:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC81216FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 12:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC81216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MBLr4TppzDqnK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 22:48:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MBFN3FPmzF3Fq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 22:44:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42MBFM4brmz9s1x;
 Fri, 28 Sep 2018 22:44:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: wire up memtest
In-Reply-To: <9f0055e2-ebd1-649b-272e-cb9b58bd4e15@c-s.fr>
References: <b3f2074b89ef0e3352fb11b69be30caeaa823fa0.1535360497.git.christophe.leroy@c-s.fr>
 <871s9euw4m.fsf@concordia.ellerman.id.au>
 <9f0055e2-ebd1-649b-272e-cb9b58bd4e15@c-s.fr>
Date: Fri, 28 Sep 2018 22:44:07 +1000
Message-ID: <878t3lu6zs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 28/09/2018 =C3=A0 05:41, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Add call to early_memtest() so that kernel compiled with
>>> CONFIG_MEMTEST really perform memtest at startup when requested
>>> via 'memtest' boot parameter.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/kernel/setup-common.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/s=
etup-common.c
>>> index 93fa0c99681e..904b728eb20d 100644
>>> --- a/arch/powerpc/kernel/setup-common.c
>>> +++ b/arch/powerpc/kernel/setup-common.c
>>> @@ -33,6 +33,7 @@
>>>   #include <linux/serial_8250.h>
>>>   #include <linux/percpu.h>
>>>   #include <linux/memblock.h>
>>> +#include <linux/bootmem.h>
>>>   #include <linux/of_platform.h>
>>>   #include <linux/hugetlb.h>
>>>   #include <asm/debugfs.h>
>>> @@ -917,6 +918,8 @@ void __init setup_arch(char **cmdline_p)
>>>   	/* Parse memory topology */
>>>   	mem_topology_setup();
>>>=20=20=20
>>> +	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
>>=20
>> On a ppc64le VM this boils down to early_memtest(0, 0) for me.
>>=20
>> I think it's too early, we don't set up max_low_pfn until
>> initmem_init().
>>=20
>> If I move it after initmem_init() then it does something more useful:
>
> Ok. On my 8xx max_low_pfn is set in mem_topology_setup().
>
> Moving the test afte initmem_init() still works on the 8xx so I'll do tha=
t.

Great, thanks.

cheers
