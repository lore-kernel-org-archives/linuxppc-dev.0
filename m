Return-Path: <sachinp@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4B3B867A5E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 14:22:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8M4MB8D010435
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 00:22:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8M4MAob277474
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 22:22:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8M4MA1V018616
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 22:22:10 -0600
Message-ID: <451364EE.8070004@in.ibm.com>
Date: Fri, 22 Sep 2006 09:52:06 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] kdump: don't call __ioremap() for pfn = 0
References: <451216EE.8010404@in.ibm.com>
	<1158836557.7062.52.camel@localhost.localdomain>
In-Reply-To: <1158836557.7062.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Fastboot mailing list <fastboot@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>> Attached is a patch to fix this problem. During such rare cases don't call
>> __ioremap() to do the address translation, instead use __va() .
>>     
>
> It's not really rare, it's just when we're reading /dev/oldmem directly.
>   
That's true. Since we don't try to copy raw dump from /dev/oldmem very
often, we haven't come across this problem. Hence rare .. but as
michael said always recreatable while using dd command with /dev/oldmem.

> We can actually use the __va() trick for the whole linear mapping rather
> than just pfn 0, which saves the ioremap. We also shouldn't really be
> trying to iounmap(__va(0)).
>   
Yes. Makes sense. Agreed.

> So perhaps something more like this? Although it's a bit ugly because of
> the need to conditionally call iounmap().
>   
< snip > 

Thanks
-Sachin
