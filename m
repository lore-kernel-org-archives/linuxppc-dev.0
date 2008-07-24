Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 029C0DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 17:45:22 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6O7iP5D184944
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 07:44:25 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6O7iPZF3084336
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 09:44:25 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6O7iOYs025267
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 09:44:25 +0200
Message-ID: <488832D3.8060305@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2008 09:44:19 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 1/6] kvmppc: read device tree hypervisor node
	infrastructure
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-2-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<20080724014133.GH20457@bakeyournoodle.com>
In-Reply-To: <20080724014133.GH20457@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Wed, Jul 23, 2008 at 10:36:42AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
>
> Hi Christian,
> 	A few comments inlined ...
>
>   
[...]
>> +
>>  static inline int kvm_para_available(void)
>>  {
>> -	return 0;
>> +	struct device_node *dn;
>> +
>> +	dn = of_find_node_by_path("/hypervisor");
>>     
>
> You need an of_node_put(dn);
>
>   
I just looked at the linux/of.h and did not see that I have to free it 
again.
Thanks for the hint, I inserted both calls.
>> +
>> +	return !!dn;
>>  }
>>  
>>  static inline unsigned int kvm_arch_para_features(void)
>>  {
>> -	return 0;
>> +	struct device_node *dn;
>> +	const int *dtval;
>> +	unsigned int features = 0;
>> +	int i;
>> +
>> +	dn = of_find_node_by_path("/hypervisor");
>> +	if (!dn)
>> +		return 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(para_features)-1; i++) {
>>     
>
> Why -1?  Isn't ARRAY_SIZE(para_features) adequate?
>   

yeah I already had this, bit the change was folded into the wrong patch, 
fixed now

[...]
> Yours Tony
>
>   linux.conf.au    http://www.marchsouth.org/
>   Jan 19 - 24 2009 The Australian Linux Technical Conference!
>
>   


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
