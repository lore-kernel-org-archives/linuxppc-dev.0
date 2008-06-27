Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5734EDDF45
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 13:48:12 +1000 (EST)
Message-ID: <486462F1.9080602@firmworks.com>
Date: Thu, 26 Jun 2008 17:48:01 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Support NAND partitions >4GiB with Open Firmware
References: <48642B50.9060607@firmworks.com>
	<20080627032046.GH17621@yookeroo.seuss>
	<48645E6A.6020202@firmworks.com>
	<20080627033817.GJ17621@yookeroo.seuss>
In-Reply-To: <20080627033817.GJ17621@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Gibson wrote:
> On Thu, Jun 26, 2008 at 05:28:42PM -1000, Mitch Bradley wrote:
>   
>> David Gibson wrote:
>>     
>>> On Thu, Jun 26, 2008 at 01:50:40PM -1000, Mitch Bradley wrote:
>>>       
> [snip]
>   
>>>> +               const u_int32_t *propval;
>>>> +               u_int32_t addrcells = 0, sizecells = 0;
>>>>                int len;
>>>>
>>>> -               reg = of_get_property(pp, "reg", &len);
>>>> -               if (!reg || (len != 2 * sizeof(u32))) {
>>>> +               /*
>>>> +                * Determine the layout of a "reg" entry based on the parent
>>>> +                * node's properties, if it hasn't been done already.
>>>> +                */
>>>> +
>>>> +               if (addrcells == 0)
>>>>     
>>>>         
>>> Redundant 'if'; you've just initialized this variable to zero.
>>>       
>> The intention is that the body of the "if" should only be executed
>> once during the loop, since the parent node is the same for all
>> children.
>>     
>
> But the initialization is within the loop body as well, so this won't
> do it.  Just factor the code getting addr and size cells right out of
> the loop, instead.
>
>   

Hmmm.  Perhaps it's better to move the declaration of the variables out of
the loop instead.

Moving the of_n_*_cells() calls outside the loop requires redundant calls
to of_get_child() and of_node_put(), because of_n_*_cells() implicitly
reach up to the parent node.  That is almost certainly more expensive 
than the "if".
