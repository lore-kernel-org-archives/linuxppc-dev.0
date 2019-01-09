Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C093C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 13:45:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D81E206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 13:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D81E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZVk33s7CzDqYn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 00:44:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=188.165.52.147; helo=8.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 153948 seconds by postgrey-1.36 at bilbo;
 Thu, 10 Jan 2019 00:38:19 AEDT
Received: from 8.mo2.mail-out.ovh.net (8.mo2.mail-out.ovh.net [188.165.52.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZVZM3Z7FzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 00:38:17 +1100 (AEDT)
Received: from player763.ha.ovh.net (unknown [10.109.143.208])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 604A2178C5D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 14:38:12 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id AD02317A1276;
 Wed,  9 Jan 2019 13:38:02 +0000 (UTC)
Subject: Re: [PATCH 01/19] powerpc/xive: export flags for the XIVE native
 exploitation mode hcalls
To: Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-2-clg@kaod.org>
 <87pnt6rnar.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fe8f71f7-df1f-72b0-2dd7-3d2a5023d210@kaod.org>
Date: Wed, 9 Jan 2019 14:38:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87pnt6rnar.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17961481217450675079
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrfedugdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/9/19 2:08 PM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> These flags are shared between Linux/KVM implementing the hypervisor
>> calls for the XIVE native exploitation mode and the driver for the
>> sPAPR guests.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/xive.h  | 23 +++++++++++++++++++++++
>>  arch/powerpc/sysdev/xive/spapr.c | 28 ++++++++--------------------
>>  2 files changed, 31 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
>> index 3c704f5dd3ae..32f033bfbf42 100644
>> --- a/arch/powerpc/include/asm/xive.h
>> +++ b/arch/powerpc/include/asm/xive.h
>> @@ -93,6 +93,29 @@ extern void xive_flush_interrupt(void);
>>  /* xmon hook */
>>  extern void xmon_xive_do_dump(int cpu);
>>  
>> +/*
>> + * Hcall flags shared by the sPAPR backend and KVM
>> + */
>> +
>> +/* H_INT_GET_SOURCE_INFO */
>> +#define XIVE_SPAPR_SRC_H_INT_ESB	PPC_BIT(60)
>> +#define XIVE_SPAPR_SRC_LSI		PPC_BIT(61)
>> +#define XIVE_SPAPR_SRC_TRIGGER		PPC_BIT(62)
>> +#define XIVE_SPAPR_SRC_STORE_EOI	PPC_BIT(63)
> 
> I have an (irrational) hatred of PPC_BIT, because it obfuscates what's
> going on and makes PPC seem weirder than it needs to be. It could at
> least be called IBM_BIT().
> 
> I know it helps people compare the code vs the documentation, but
> basically no one has the documentation, and everyone has the code.
> 
> Anyway it's not a show stopper, just a pet-peeve of mine :)

Only the define matters, I can change that back to the non-PPC_BIT
version in v2. Not a problem. 

Cheers,

C. 
