Return-Path: <ahuja@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CF2BDDF61
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 09:56:50 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m08Mul1r018554
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 17:56:47 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m08MulLB387836
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 17:56:47 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m08MulTu024477
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 17:56:47 -0500
Message-ID: <4783FFAD.2090105@austin.ibm.com>
Date: Tue, 08 Jan 2008 16:56:45 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 7/8] pseries: phyp dump: Unregister and print dump areas.
References: <4782B985.2090508@austin.ibm.com>	<4782C5CB.4080802@austin.ibm.com>
	<20080108152554.eb06f84a.sfr@canb.auug.org.au>
In-Reply-To: <20080108152554.eb06f84a.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen,

>> +	/* Add addr value if not initialized before */
>> +	if (ph->cpu_data.destination_address == 0) {
>> +		ph->cpu_data.destination_address += addr;
> 
> Could be just '=' like further down, right?

Actually the one below should be += as well. Thanks for catching it.

>> +	/* total reserved size - start of scratch area */
>> +	second_addr_range = phdr.cpu_data.destination_address -
>> +				phyp_dump_info->init_reserve_size;
>> +	return sprintf(buf, "CPU:0x%lx-0x%lx: HPTE:0x%lx-0x%lx:"
>> +			    " DUMP:0x%lx-0x%lx, 0x%lx-0x%lx:\n",
>> +	  phdr.cpu_data.destination_address, phdr.cpu_data.length_copied,
>> +	  phdr.hpte_data.destination_address, phdr.hpte_data.length_copied,
>> +	  phdr.kernel_data.destination_address, phdr.kernel_data.length_copied,
>> +	  phyp_dump_info->init_reserve_start, second_addr_range);
> 
> This indentation should be (probably) two tabs.

I kept it one with a few spaces as otherwise it was exceeding 80, I guess, I can just have one per line
and that should take care of that.

> 
>> +	/* re-register the dump area, if old dump was invalid */
>> +	if ((dump_header) && (dump_header->status & DUMP_ERROR_FLAG)) {
>             ^           ^
> Extra parentheses.

Just for clarity.. I would prefer that, if thats okay.

> 
>> +		invalidate_last_dump (&phdr, dump_area_start);
>> +		register_dump_area (&phdr, dump_area_start);
> 
> No spaces after function names.
> 


Yeah, will take that out from here and other files as well.

Thanks,
Manish
