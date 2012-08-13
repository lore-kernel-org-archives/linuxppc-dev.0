Return-Path: <B07421@freescale.com>
Message-ID: <50293062.7060809@freescale.com>
Date: Mon, 13 Aug 2012 11:50:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <5025639F.4070203@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F093AEC18@039-SN2MPN1-023.039d.mgd.msft
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F093AEC18@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
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

On 08/13/2012 01:17 AM, Li Yang-R58472 wrote:
> 
> 
>> -----Original Message-----
>> From: Wang Dongsheng-B40534
>> Sent: Monday, August 13, 2012 1:54 PM
>> To: Wood Scott-B07421
>> Cc: benh@kernel.crashing.org; paulus@samba.org; linuxppc-
>> dev@lists.ozlabs.org; Gala Kumar-B11780; Li Yang-R58472
>> Subject: RE: [PATCH v2 2/2] powerpc/mpic: add global timer support
>>
>>
>>
>>> -----Original Message-----
>>> From: Wood Scott-B07421
>>> Sent: Saturday, August 11, 2012 3:40 AM
>>> To: Wang Dongsheng-B40534
>>> Cc: benh@kernel.crashing.org; paulus@samba.org; linuxppc-
>>> dev@lists.ozlabs.org; Gala Kumar-B11780; Li Yang-R58472
>>> Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
>>>
>>> On 08/10/2012 12:54 AM, Dongsheng.wang@freescale.com wrote:
>>>> +static const struct of_device_id mpic_timer_ids[] = {
>>>> +	{ .compatible = "open-pic,global-timer", },
>>>> +	{ .compatible = "fsl,global-timer", },
>>>> +	{},
>>>> +};
>>>> +
>>>> +static int __init mpic_timer_init(void) {
>>>> +	struct device_node *np = NULL;
>>>> +
>>>> +	for_each_node_by_type(np, "open-pic")
>>>> +		if (of_match_node(mpic_timer_ids, np))
>>>> +			group_init(np);
>>>> +
>>>> +	if (list_empty(&group_list))
>>>> +		return -ENODEV;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +arch_initcall(mpic_timer_init);
>>>
>>> Oh, and don't probe by device_type.
> 
> Actually it does match the compatible.  The device_type is just to
> speed up the search.  I don't think it's a problem unless the device
> type is not mandatory any more for defined types.

Doesn't matter (and I doubt it provides any significant speed up
compared to a search by compatible, and in any case this is not
performance critical).  device_type is deprecated outside certain
specific legacy uses.  Get rid of it.

-Scott
