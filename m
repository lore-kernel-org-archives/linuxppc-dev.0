Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1B18DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 00:30:54 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4RES1Ln024475
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 08:28:01 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4REUopg238876
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 08:30:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4REUoTu007887
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 08:30:50 -0600
Message-ID: <4A1D4E96.60007@austin.ibm.com>
Date: Wed, 27 May 2009 09:30:46 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Display processor virtualization resource allocations
	in lparcfg
References: <4A1C2E10.9020109@austin.ibm.com>
	<1243386862.18971.41.camel@concordia>
In-Reply-To: <1243386862.18971.41.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>> +	root = of_find_node_by_path("/");
>> +	if (root) {
>> +		perf_level = of_get_property(root,
>> +				"ibm,partition-performance-parameters-level",
>> +					     NULL);
> 
> What if there is no such property?

Yes, that would cause this code to do some bad things.  Updated patch on its way.

> 
>> +		if (*perf_level >= 1) {
>> +			seq_printf(m,
>> +			    "physical_procs_allocated_to_virtualization=%d\n",
>> +				   ppp_data.phys_platform_procs);
>> +			seq_printf(m, "max_proc_capacity_available=%d\n",
>> +				   ppp_data.max_proc_cap_avail);
>> +			seq_printf(m, "entitled_proc_capacity_available=%d\n",
>> +				   ppp_data.entitled_proc_cap_avail);
>> +		}
>> +
>> +		of_node_put(root);
>> +	}
> 
> cheers

-Nathan
