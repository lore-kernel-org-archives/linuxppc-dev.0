Return-Path: <brking@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E27EDDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 23:35:26 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6JCVFhK029314
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 08:31:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6JDZGgL535874
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 09:35:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6JDZFu6026120
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 09:35:16 -0400
Message-ID: <469F6892.2020908@linux.vnet.ibm.com>
Date: Thu, 19 Jul 2007 08:35:14 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] ibmveth: Enable TCP checksum offload
References: <11846854701127-patch-mail.ibm.com> <469E9510.7060703@garzik.org>
In-Reply-To: <469E9510.7060703@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, santil@linux.vnet.ibm.com,
	rcjenn@linux.vnet.ibm.com
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik wrote:
> Brian King wrote:
>> This patchset enables TCP checksum offload support for IPV4
>> on ibmveth. This completely eliminates the generation and checking of
>> the checksum for packets that are completely virtual and never
>> touch a physical network. A simple TCP_STREAM netperf run on
>> a virtual network with maximum mtu set yielded a ~30% increase
>> in throughput. This feature is enabled by default on systems that
>> support it, but can be disabled with a module option.
>>
>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> 
> this should be controllable purely via ethtool...

I'll remove the module parameter and resend.

>>  struct ibmveth_rx_q_entry {
>>      u16 toggle : 1;
>>      u16 valid : 1;
>> -    u16 reserved : 14;
>> +    u16 reserved : 4;
>> +    u16 no_csum : 1;
>> +    u16 csum_good : 1;
>> +    u16 reserved2 : 8;
>>      u16 offset;
> 
> As a general rule, it would be nice to start moving away from bitfields 
> in this driver

I'll take a look at that for a future cleanup patch.

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
