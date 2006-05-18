Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F7BE67A3F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 02:43:46 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673062C05CC@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673062C05CC@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <25D61E59-D69E-4C0C-BA98-162822DB02B1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 11:43:59 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2006, at 1:57 AM, Zang Roy-r61911 wrote:

>
>> On Wed, 2006-05-17 at 08:45 -0500, Kumar Gala wrote:
>>
>>>> +#ifdef TSI108_ETH
>>>> +hw_info hw_info_table[TSI108_ETH_MAX_PORTS + 1] = {
>>>> +	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
>>>> +	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
>>>> +	 TSI108_PHY0_ADDR, IRQ_TSI108_GIGE0},
>>>> +
>>>> +	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET + 0x400,
>>>> +	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
>>>> +	 TSI108_PHY1_ADDR, IRQ_TSI108_GIGE1},
>>>> +
>>>> +	{TBL_END, TBL_END, TBL_END, TBL_END}
>>>> +};
>>>> +#endif
>>>
>>> This table looks problematic.  Look at using something like a
>>> platform device.
>>
>> Bzzzt ... wrong answer :) That's a textbook example of stuff
>> that should
>> be provided via the device-tree.
>>
>>
>
> Well , should I register this data to a platform device or the  
> Ethernet
> driver get the information from device-tree directly?

I'd say the later.  Ben mentioned use of of_device which will allow  
you to do that more directly.  I used platform_device to maintain the  
fact that we had existing drivers to support that were using it already.

- k
