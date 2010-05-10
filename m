Return-Path: <brking@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3F23B7D73
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 06:57:44 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4AKqIaO029732
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 16:52:18 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4AKvegd1073222
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 16:57:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4AKvdwF021841
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 17:57:40 -0300
Message-ID: <4BE8733F.5080905@linux.vnet.ibm.com>
Date: Mon, 10 May 2010 15:57:35 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] powerpc: Partition hibernation support
References: <201005071158.o47Bww77013658@d03av03.boulder.ibm.com>
	<1273474102.6591.258.camel@concordia>
	<4BE81A3E.8030501@linux.vnet.ibm.com>
In-Reply-To: <4BE81A3E.8030501@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2010 09:37 AM, Brian King wrote:
> 
>>>  }
>>>  #else /* CONFIG_PPC_PSERIES */
>>>  static int rtas_ibm_suspend_me(struct rtas_args *args)
>>>  {
>>>  	return -ENOSYS;
>>>  }
>>> +
>>> +int rtas_suspend_cpu(struct rtas_suspend_me_data *data)
>>> +{
>>> +	return -ENOSYS;
>>> +}
>>> +
>>> +int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data)
>>> +{
>>> +	return -ENOSYS;
>>> +}
>>
>> Don't see why you need these empty versions, they're only ever called
>> from pseries code aren't they?
> 
> True, but we still need to be able to link the code in a cross platform
> kernel.

I was able to fix this up as well with a makefile change to ensure
suspend.c only gets built when CONFIG_PPC_PSERIES=y


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
