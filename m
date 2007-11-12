Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 76EF2DDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 09:22:31 +1100 (EST)
Message-ID: <4738D218.9060503@semihalf.com>
Date: Mon, 12 Nov 2007 23:22:16 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>	<20071109171202.16289.2618.stgit@hekate.izotz.org>
	<20071110113133.86aa3de2.sfr@canb.auug.org.au>
In-Reply-To: <20071110113133.86aa3de2.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Fri, 09 Nov 2007 18:12:02 +0100 Marian Balakowicz <m8@semihalf.com> wrote:
>> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
>>
>> +static int __init mpc5200_simple_probe(void)
>> +{
>> +	unsigned long node = of_get_flat_dt_root();
> 
> You need to include asm/prom.h to use the flattened device tree accessors.

Right, but this one is already included in mpc52xx.h.

>> +	/* list of the supported boards */
>> +	const char *board[] = {	
>> +		"tqc,tqm5200",
>> +		"promess,motionpro",
>> +		"schindler,cm5200",
>> +		NULL
>> +	};
> 
> Make that static.

Board table is no longer needed after kernel is initialized, it would
be nice to declare it static and __initdata, but that would be quite
ugly as it's a table of pointers and each string would require
separate statement too. If we don't do it then what's the benefit of
making it static?

Cheers,
m.
