Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290BBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 10:14:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F73D2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 10:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F73D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447Hq51wqczDqDY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.53; helo=5.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo178.mail-out.ovh.net (5.mo178.mail-out.ovh.net
 [46.105.51.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447Hmz4lyqzDqLY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 21:12:16 +1100 (AEDT)
Received: from player738.ha.ovh.net (unknown [10.109.159.157])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6737C52B14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 11:12:11 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id BFE2C329D896;
 Mon, 25 Feb 2019 10:11:58 +0000 (UTC)
Subject: Re: [PATCH v2 01/16] powerpc/xive: add OPAL extensions for the XIVE
 native exploitation support
To: Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 Stewart Smith <stewart@linux.ibm.com>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-2-clg@kaod.org>
 <87y364jzlz.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <543ff6a2-b892-6710-d218-6aed1414840f@kaod.org>
Date: Mon, 25 Feb 2019 11:11:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87y364jzlz.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13797621886030678919
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrudejgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/25/19 4:50 AM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> The support for XIVE native exploitation mode in Linux/KVM needs a
>> couple more OPAL calls to configure the sPAPR guest and to get/set the
>> state of the XIVE internal structures.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/opal-api.h           | 11 ++-
>>  arch/powerpc/include/asm/opal.h               |  7 ++
>>  arch/powerpc/include/asm/xive.h               | 14 +++
>>  arch/powerpc/sysdev/xive/native.c             | 99 +++++++++++++++++++
>>  .../powerpc/platforms/powernv/opal-wrappers.S |  3 +
>>  5 files changed, 130 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index 870fb7b239ea..cdfc54f78101 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -186,8 +186,8 @@
>>  #define OPAL_XIVE_FREE_IRQ			140
>>  #define OPAL_XIVE_SYNC				141
>>  #define OPAL_XIVE_DUMP				142
>> -#define OPAL_XIVE_RESERVED3			143
>> -#define OPAL_XIVE_RESERVED4			144
>> +#define OPAL_XIVE_GET_QUEUE_STATE		143
>> +#define OPAL_XIVE_SET_QUEUE_STATE		144
>>  #define OPAL_SIGNAL_SYSTEM_RESET		145
>>  #define OPAL_NPU_INIT_CONTEXT			146
>>  #define OPAL_NPU_DESTROY_CONTEXT		147
>> @@ -209,8 +209,11 @@
>>  #define OPAL_SENSOR_GROUP_ENABLE		163
>>  #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
>>  #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
>> -#define	OPAL_NX_COPROC_INIT			167
>> -#define OPAL_LAST				167
>> +#define OPAL_HANDLE_HMI2			166
>> +#define OPAL_NX_COPROC_INIT			167
>> +#define OPAL_NPU_SET_RELAXED_ORDER		168
>> +#define OPAL_NPU_GET_RELAXED_ORDER		169
>> +#define OPAL_XIVE_GET_VP_STATE			170
> 
> You should only be defining the calls you need, leaving gaps for other
> things, and you need to retain OPAL_LAST. So it should look more like:
> 
>  -#define OPAL_LAST				167
>  +#define OPAL_XIVE_GET_VP_STATE		170
>  +#define OPAL_LAST				170
> 
> 
> Also I can't merge this until it's merged into skiboot.

OK. Let's start with skiboot.

C. 
