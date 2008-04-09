Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92934DDF9B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 03:32:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m39HWPQR026057
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 13:32:25 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m39HWOt1237332
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 13:32:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m39HWO1a020886
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 13:32:24 -0400
Message-ID: <47FCFDA4.10709@austin.ibm.com>
Date: Wed, 09 Apr 2008 12:32:20 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
References: <47FAB221.7050406@austin.ibm.com>
	<20080408024352.GA32761@lixom.net>
In-Reply-To: <20080408024352.GA32761@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> These make for some really long variable names and lines. I know from
> experience, since I've picked unneccessary long driver names in the past
> myself. :)
> 
> How about just naming the new variables reserve_bootvar, etc? The name
> of the struct they're in makes it obvious what they're for.
> 

Yeah, I guess thats a good suggestion. Will truncate it.

> 
>> +static inline unsigned long phyp_dump_calculate_reserve_size(void)
>> +{
>> +	unsigned long tmp;
>> +
>> +	if (phyp_dump_info->phyp_dump_reserve_bootvar)
>> +		return phyp_dump_info->phyp_dump_reserve_bootvar;
>> +
>> +	/* divide by 20 to get 5% of value */
>> +	tmp = lmb_end_of_DRAM();
>> +	do_div(tmp, 20);
>> +
>> +	/* round it down in multiples of 256 */
>> +	tmp = tmp & ~0x000000001FFFFFFF;
> 
> That's 512MB, isn't it?
> 

No, its 5 % of memory and then rounded down to 256 MB multiples.
so if you 4GB its 256MB.
if you have 8 GB its 512 MB etc.

> 
> -Olof
