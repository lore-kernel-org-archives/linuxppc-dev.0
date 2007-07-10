Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70005DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 06:11:46 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AKBhP8019233
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 16:11:43 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AKBeWZ244912
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:11:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AKBUj6019849
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:11:30 -0600
Message-ID: <4693E7EF.4020708@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2007 15:11:27 -0500
From: Mike Wolf <mjw@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Resend: [PATCH] oprofile support for Power 5++
References: <4693CC5B.4020207@linux.vnet.ibm.com>
	<14287.1184096639@neuling.org>
In-Reply-To: <14287.1184096639@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
>> The patch has not been included and there have been no comments so
>> I'm resending.
>>
>> This patch adds a new oprofile cpu type for Power 5 revision 3 chips.
>> The new name is ppc64/power5++ and is used so that the performance
>> counters can be set up correctly.
>>     
>
> Does it make more sense to call this "ppc64/power5+rev3"?  
>   
This is a change to support new counter setup for oprofile.  It may be the
same if there is a revision 4 or 5 etc.  So since the internal name was ++
I followed that convention. 
> Mikey
>
>   
>> Signed-off-by: Mike Wolf <mjw@us.ibm.com>
>>
>> -------- 
>> linux-2.6.18.ppc64.orig/arch/powerpc/kernel/cputable.c	2006-09-19 22:4
>>     
> 2:06.000000000 -0500
>   
>> +++ linux-2.6.18.ppc64/arch/powerpc/kernel/cputable.c	2007-06-11 12:29:47.000
>>     
> 000000 -0500
>   
>> @@ -236,6 +236,21 @@
>>  		.oprofile_mmcra_sipr	= MMCRA_SIPR,
>>  		.platform		= "power5",
>>  	},
>> +	{	/* Power5++ */
>> +		.pvr_mask		= 0xffffff00,
>> +		.pvr_value		= 0x003b0300,
>> +		.cpu_name		= "POWER5+ (gs)",
>> +		.cpu_features		= CPU_FTRS_POWER5,
>> +		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
>> +		.icache_bsize		= 128,
>> +		.dcache_bsize		= 128,
>> +		.num_pmcs		= 6,
>> +		.oprofile_cpu_type	= "ppc64/power5++",
>> +		.oprofile_type		= PPC_OPROFILE_POWER4,
>> +		.oprofile_mmcra_sihv	= MMCRA_SIHV,
>> +		.oprofile_mmcra_sipr	= MMCRA_SIPR,
>> +		.platform		= "power5+",
>> +	},
>>  	{	/* Power5 GS */
>>  		.pvr_mask		= 0xffff0000,
>>  		.pvr_value		= 0x003b0000,
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>     
