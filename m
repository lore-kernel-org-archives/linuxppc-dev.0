Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C238BDE296
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:27:51 +1100 (EST)
In-Reply-To: <1231296172.8292.20.camel@localhost>
References: <kexec-29-1-1r.miltonm@bga.com>
	<1231296172.8292.20.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2078205b8668529382796ad92bc66ab3@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH kexec-tools 1/5] ppc64: always check number of ranges when
	adding
Date: Wed, 7 Jan 2009 08:34:09 -0600
To: michael@ellerman.id.au
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 6, 2009, at 8:42 PM, Michael Ellerman wrote:
> On Fri, 2009-01-02 at 15:04 -0600, Milton Miller wrote:
>> make the idom "always call realloc_memory_ranges when filling a range 
>> entry"

>> @@ -666,6 +674,8 @@ int setup_memory_ranges(unsigned long ke
>>  		memory_range[j].end = exclude_range[i+1].start - 1;
>>  		memory_range[j].type = RANGE_RAM;
>>  		j++;
>> +		if (i >= max_memory_ranges)
>> +			realloc_memory_ranges();
>
> Should this be checking against i or j?
>

It does look like it should be against j.  I'll build test and respin 
later.

milton
