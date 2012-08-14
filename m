Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D3BC2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 12:18:42 +1000 (EST)
Message-ID: <5029B576.7070900@freescale.com>
Date: Mon, 13 Aug 2012 21:18:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <50257116.3030207@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB14CA@039-SN2MPN1-022.039d.mgd.msft.net>
 <50293B36.1000408@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB1984@039-SN2MPN1-022.039d.mgd.msft.net>
 <5029B25E.4010708@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB19CF@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259DB19CF@039-SN2MPN1-022.039d.mgd.msft.net>
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

On 08/13/2012 09:15 PM, Wang Dongsheng-B40534 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, August 14, 2012 10:05 AM
>> To: Wang Dongsheng-B40534
>> Cc: Wood Scott-B07421; benh@kernel.crashing.org; paulus@samba.org;
>> linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; Li Yang-R58472
>> Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
>>
>> On 08/13/2012 09:00 PM, Wang Dongsheng-B40534 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Wood Scott-B07421
>>>> Sent: Tuesday, August 14, 2012 1:37 AM
>>>> To: Wang Dongsheng-B40534
>>>> Cc: Wood Scott-B07421; benh@kernel.crashing.org; paulus@samba.org;
>>>> linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; Li Yang-R58472
>>>> Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
>>>>
>>>> On 08/13/2012 01:18 AM, Wang Dongsheng-B40534 wrote:
>>>>>>> +	p = of_get_property(np, "available-ranges", &len);
>>>>>>> +	if (p && len % (2 * sizeof(u32)) != 0) {
>>>>>>> +		pr_err("%s: malformed fsl,available-ranges property.\n",
>>>>>>> +				np->full_name);
>>>>>>> +		return -EINVAL;
>>>>>>> +	}
>>>>>>
>>>>>> You need to support fsl,available-ranges since that's in an
>>>>>> accepted binding and people could have partitioned setups already
>> using it.
>>>>>>
>>>>> [Wang Dongsheng] FSL chip or OPEN-PIC specification(Only a group) in
>>>>> each group only four timer. This is unified. So i use a generic name.
>>>>> I think there is not compatible with existing mpic timer nodes.
>>>>
>>>> We need to be compatible with existing trees, so you'd need to check
>>>> for both -- but I think any further discussion of the details is
>>>> premature until we decide whether this is worthwhile to begin with
>>>> (both the support of non-FSL timers, and the creation of a new device
>>>> tree binding which will not be implemented by many of the machines
>>>> that have non-FSL openpic because they run real Open Firmware).
>>>>
>>> [Wang Dongsheng]
>>> 	p = of_get_property(np, "available-ranges", &len);
>>> 	if (!p)
>>> 		p = of_get_property(np, "fsl,available-ranges", &len);
>>>
>>> 	this code be compatible with existing trees.
>>
>> Yes, that's what I meant by checking both.
>>
>> I still think we need to discuss why we're doing this first.  What
>> specific machines are going to have these new openpic timer nodes?
>>
> [Wang Dongsheng] It's support to power management awakening. At present, 
> the power management more and more important. This way is important to wake
> up machine. At least need support power management of machine still needs
> such a driver.

I mean specifically for the non-Freescale openpic nodes.

-Scott
