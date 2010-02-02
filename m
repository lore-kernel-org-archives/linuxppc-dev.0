Return-Path: <jschopp@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50546B7D41
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 05:37:28 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o12IONhh021413
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 13:24:23 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o12IbLVL1359880
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 13:37:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o12IbLUH007984
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 16:37:21 -0200
Message-ID: <4B6870DF.9030408@austin.ibm.com>
Date: Tue, 02 Feb 2010 12:37:19 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCHv2 2/2] Update ibm,client-architecture call field based
	on device tree
References: <1263501508.4869.133.camel@jschopp-laptop>
	<1263501674.4869.142.camel@jschopp-laptop>
	<1265064662.5391.19.camel@jschopp-laptop>
	<20100202034832.GD12389@ozlabs.org>
In-Reply-To: <20100202034832.GD12389@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> +		if(*cores != NR_CPUS)
>> +			prom_printf("client-architecture structure corrupted\n");
>> +		*cores = (NR_CPUS / prom_smt_way());
>> +		prom_printf("setting client-architecture cores to %x\n", *cores);
>>     
>
> I don't know if I'm painting a bike shed of if this is a real concern, but if
> *cores isn't NR_CPUS shouldn't we do nothing rather then clobbering it?
>
> Yours Tony
>   
If it isn't NR_CPUS we're pretty broken if we set it or if we don't.  My 
previous version did a BUILD_BUG_ON() but Ben didn't like that and said 
he preferred just a warning message. 
