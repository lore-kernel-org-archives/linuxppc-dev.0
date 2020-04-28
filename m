Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60035C83000
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 11:56:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B61206D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 11:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B61206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BKqj1C2vzDqjH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.75.45; helo=9.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 9.mo178.mail-out.ovh.net (9.mo178.mail-out.ovh.net
 [46.105.75.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BKnd2T16zDqfr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 21:54:35 +1000 (AEST)
Received: from player788.ha.ovh.net (unknown [10.108.35.223])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8D2669C20F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 13:36:24 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id CB95811DB8A3D;
 Tue, 28 Apr 2020 11:36:22 +0000 (UTC)
Subject: Re: [PATCH] powerpc: Add interrupt mode information in /proc/cpuinfo
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20200427140644.332815-1-clg@kaod.org>
 <87v9ljg9dz.fsf@mpe.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fb54a4f3-21cf-7167-97ec-c1d005d6c343@kaod.org>
Date: Tue, 28 Apr 2020 13:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v9ljg9dz.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1528972073821047741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedugdegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrgh
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/28/20 1:03 PM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
>> PowerNV and pSeries machines can run using the XIVE or XICS interrupt
>> mode. Report this information in /proc/cpuinfo :
>>
>>     timebase    : 512000000
>>     platform    : PowerNV
>>     model       : 9006-22C
>>     machine     : PowerNV 9006-22C
>>     firmware    : OPAL
>>     MMU         : Radix
>>     IRQ         : XIVE
> 
> Hmmmm, I dunno. At what point do we stop putting random non CPU-related
> things in cpuinfo? :)

True. 

> The IRQ mode is (reasonably) easily discovered in sys, eg:
> 
>   $ cat /sys/kernel/irq/*/chip_name | grep -m 1 XIVE
>   XIVE-IRQ
> 
> vs:
> 
>   $ cat /sys/kernel/irq/*/chip_name | grep -m 1 XICS
>   XICS


That's good enough for error reporting

Thanks.

C.

> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
>> index 3bc188da82ba..39ef3394038d 100644
>> --- a/arch/powerpc/platforms/powernv/setup.c
>> +++ b/arch/powerpc/platforms/powernv/setup.c
>> @@ -196,14 +196,18 @@ static void pnv_show_cpuinfo(struct seq_file *m)
>>  		model = of_get_property(root, "model", NULL);
>>  	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
>>  	if (firmware_has_feature(FW_FEATURE_OPAL))
>> -		seq_printf(m, "firmware\t: OPAL\n");
>> +		seq_puts(m, "firmware\t: OPAL\n");
>>  	else
>> -		seq_printf(m, "firmware\t: BML\n");
>> +		seq_puts(m, "firmware\t: BML\n");
>>  	of_node_put(root);
>>  	if (radix_enabled())
>> -		seq_printf(m, "MMU\t\t: Radix\n");
>> +		seq_puts(m, "MMU\t\t: Radix\n");
>>  	else
>> -		seq_printf(m, "MMU\t\t: Hash\n");
>> +		seq_puts(m, "MMU\t\t: Hash\n");
>> +	if (xive_enabled())
>> +		seq_puts(m, "IRQ\t\t: XIVE\n");
>> +	else
>> +		seq_puts(m, "IRQ\t\t: XICS\n");
>>  }
>>  
>>  static void pnv_prepare_going_down(void)
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 0c8421dd01ab..d248fca67797 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -95,9 +95,13 @@ static void pSeries_show_cpuinfo(struct seq_file *m)
>>  	seq_printf(m, "machine\t\t: CHRP %s\n", model);
>>  	of_node_put(root);
>>  	if (radix_enabled())
>> -		seq_printf(m, "MMU\t\t: Radix\n");
>> +		seq_puts(m, "MMU\t\t: Radix\n");
>>  	else
>> -		seq_printf(m, "MMU\t\t: Hash\n");
>> +		seq_puts(m, "MMU\t\t: Hash\n");
>> +	if (xive_enabled())
>> +		seq_puts(m, "IRQ\t\t: XIVE\n");
>> +	else
>> +		seq_puts(m, "IRQ\t\t: XICS\n");
>>  }
>>  
>>  /* Initialize firmware assisted non-maskable interrupts if
>> -- 
>> 2.25.3

