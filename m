Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 159E2DDE2B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 08:35:37 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7LZYtj027724
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 16:35:34 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7LZX0k128220
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 14:35:33 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7LZXV5014163
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 14:35:33 -0700
Message-ID: <4759BCA2.1020809@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 03:05:30 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207212817.GA391@lixom.net>
In-Reply-To: <20071207212817.GA391@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Hi,
> 
> On Sat, Dec 08, 2007 at 02:44:25AM +0530, Balbir Singh wrote:
> 
>> Comments are as always welcome!
> 
> Care to explain what this is useful for? (Not saying it's a stupid idea,
> just wondering what the reason for doing it is).
> 

In my case, I use it to test parts of my memory controller patches on an
emulated NUMA machine. I plan to use it to test out page migration
across nodes.

>> diff -puN arch/powerpc/mm/numa.c~ppc-fake-numa-easy arch/powerpc/mm/numa.c
>> --- linux-2.6.24-rc4-mm1/arch/powerpc/mm/numa.c~ppc-fake-numa-easy	2007-12-07 21:25:55.000000000 +0530
>> +++ linux-2.6.24-rc4-mm1-balbir/arch/powerpc/mm/numa.c	2007-12-08 02:36:02.000000000 +0530
>> @@ -24,6 +24,8 @@
>>  
>>  static int numa_enabled = 1;
>>  
>> +char *cmdline __initdata;
>> +
> 
> Looks like this should be static.
> 

Yes, good catch!

>> @@ -702,6 +744,9 @@ static int __init early_numa(char *p)
>>  	if (strstr(p, "debug"))
>>  		numa_debug = 1;
>>  
>> +	if (strstr(p, "fake="))
>> +		cmdline = p + 5;	/* 5 is faster than strlen("fake=") */
> 
> This doesn't look right.
> 
> You check if it contains fake=, not if it starts with it. So if someone
> did: "numa=foo,fake=bar", or even "numa=debug,fake=", things wouldn't
> work right.
> 

Yes, you are right. I merely followed the strstr convention already
present, which as you righly point out is wrong. I suspect I need to do
something like

p = strstr(p, "fake=")
if (p)
	cmdline = p + 5;

This would still allow us to do things like

numa=foo,fake=bar but the memparse() utility would fail at fake=bar
								^^^

or even

numa=debug,fake=1G

I suspect that this should be good enough for a command line option.

> 
> -Olof


-- 
	Thanks,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
