Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35BB1DDF9E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 05:29:06 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1BIT3PI015123
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 13:29:03 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1BIT3lY368936
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 13:29:03 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1BIT3uE000353
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 13:29:03 -0500
Message-ID: <47B093EC.1020100@austin.ibm.com>
Date: Mon, 11 Feb 2008 12:29:00 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
References: <4796401D.5010907@austin.ibm.com>	<47964422.7080505@austin.ibm.com>
	<18346.21469.512910.93325@cargo.ozlabs.ibm.com>
In-Reply-To: <18346.21469.512910.93325@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Cc: Manish Ahuja <mahuja@us.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linasvepstas@gmail.com, Larry Kessler <lkessler@us.ibm.com>,
	Michael Strosaker <strosake@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry,

I think i sent the wrong patch file, it shouldn't have my printk statement in there. Let me re-send 
the correct file and let me test it once more to make sure it does the right thing.

-Manish



Paul Mackerras wrote:
> Manish Ahuja writes:
> 
>> Initial patch for reserving memory in early boot, and freeing it later.
>> If the previous boot had ended with a crash, the reserved memory would contain
>> a copy of the crashed kernel data.
> 
> [snip]
> 
>> +static void __init reserve_crashed_mem(void)
>> +{
>> +	unsigned long base, size;
>> +
>> +	if (phyp_dump_info->phyp_dump_is_active) {
>> +		/* Reserve *everything* above RMR. We'll free this real soon.*/
>> +		base = PHYP_DUMP_RMR_END;
>> +		size = lmb_end_of_DRAM() - base;
>> +
>> +		/* XXX crashed_ram_end is wrong, since it may be beyond
>> +	 	* the memory_limit, it will need to be adjusted. */
>> +		lmb_reserve(base, size);
>> +
>> +		phyp_dump_info->init_reserve_start = base;
>> +		phyp_dump_info->init_reserve_size = size;
>> +	}
>> +	else {
>> +		size = phyp_dump_info->cpu_state_size +
>> +			phyp_dump_info->hpte_region_size +
>> +			PHYP_DUMP_RMR_END;
>> +		base = lmb_end_of_DRAM() - size;
>> +	printk(KERN_ERR "Manish reserve regular kernel space is %ld %ld\n", base, size);
>> +		lmb_reserve(base, size);
> 
> This is still reserving memory even on systems that aren't running on
> pHyp at all.  Please rework this so that no memory is reserved if the
> system doesn't support phyp-assisted dump.
> 
> Paul.
