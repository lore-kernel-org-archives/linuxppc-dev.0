Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 38034DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 22:14:11 +1000 (EST)
Message-ID: <46D562D4.9060004@ru.mvista.com>
Date: Wed, 29 Aug 2007 16:13:08 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] PowerPC 440EPx: Sequoia bootwrapper
References: <20070828165321.GA1501@ru.mvista.com>
	<20070828165610.GA1552@ru.mvista.com>
	<20070829063323.GG3206@localhost.localdomain>
In-Reply-To: <20070829063323.GG3206@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Aug 28, 2007 at 08:56:10PM +0400, Valentine Barshak wrote:
>> Bootwrapper code for AMCC PPC440EPx Sequoia.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> [snip]
>> +static void sequoia_fixups(void)
>> +{
>> +	unsigned long sysclk = 33333333;
>> +
>> +	ibm440ep_fixup_clocks(sysclk, 11059200);
>> +	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
>> +	ibm4xx_denali_fixup_memsize();
>> +	dt_fixup_mac_addresses(sequoia_mac0, sequoia_mac1);
>> +}
>> +
>> +static void sequoia_init(void *mac0, void *mac1)
> 
> No need to separate this function out, just drop it into
> platform_init().  Also no need for the seqouia_mac* variables - they
> were in ebony to handle the cuboot vs. openbios variants.  For
> sequoia, you can just pull the values straight from the bd_t in
> sequoia_fixups()
> 

OK,
Thanks,
Valentine.
