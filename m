Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00EF82C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 02:49:32 +1000 (EST)
Message-ID: <5029300F.60600@freescale.com>
Date: Mon, 13 Aug 2012 11:49:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <5025639F.4070203@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>, "paulus@samba.org" <paulus@samba.org>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/13/2012 12:53 AM, Wang Dongsheng-B40534 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Saturday, August 11, 2012 3:40 AM
>> To: Wang Dongsheng-B40534
>> Cc: benh@kernel.crashing.org; paulus@samba.org; linuxppc-
>> dev@lists.ozlabs.org; Gala Kumar-B11780; Li Yang-R58472
>> Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
>>
>> On 08/10/2012 12:54 AM, Dongsheng.wang@freescale.com wrote:
>>> +static const struct of_device_id mpic_timer_ids[] = {
>>> +	{ .compatible = "open-pic,global-timer", },
>>> +	{ .compatible = "fsl,global-timer", },
>>> +	{},
>>> +};
>>> +
>>> +static int __init mpic_timer_init(void) {
>>> +	struct device_node *np = NULL;
>>> +
>>> +	for_each_node_by_type(np, "open-pic")
>>> +		if (of_match_node(mpic_timer_ids, np))
>>> +			group_init(np);
>>> +
>>> +	if (list_empty(&group_list))
>>> +		return -ENODEV;
>>> +
>>> +	return 0;
>>> +}
>>> +arch_initcall(mpic_timer_init);
>>
>> Oh, and don't probe by device_type.
>>
> [Wang Dongsheng] fine. for_each_node_by_name.

No.  Probe by compatible only.

-Scott
