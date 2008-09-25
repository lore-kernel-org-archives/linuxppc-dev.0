Return-Path: <bigeasy@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96367DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 20:22:07 +1000 (EST)
Message-ID: <48DB6635.6090009@linutronix.de>
Date: Thu, 25 Sep 2008 12:21:41 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
References: <200809240146.m8O1kIpZ077447@sullivan.realtime.net>
In-Reply-To: <200809240146.m8O1kIpZ077447@sullivan.realtime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
>> My current (working) solution is to move cuImage from 4 MiB to 8 MiB.
>> Something similar has been done for pSeries in 9b09c6d "powerpc: Change
>> the default link address for pSeries zImage kernels". Would it be
>> appropriate to move initial address to 64 MiB as the default loading
>> address or do we have here some boards which have only 64 MiB of memory?
> 
> I think there are some boards that have even less (8xx?).  Is the
> link address a wrapper option yet?

Nope. The wrapper script distinguishes between platforms. Default is 4MiB, 
pSeries has 64MiB, coff does 5MiB and the PS3 has other magic.

>> --- a/arch/powerpc/boot/main.c
>> +++ b/arch/powerpc/boot/main.c
>> @@ -56,7 +56,7 @@ static struct addr_range prep_kernel(void)
>>  	if (platform_ops.vmlinux_alloc) {
>>  		addr = platform_ops.vmlinux_alloc(ei.memsize);
>>  	} else {
>> -		if ((unsigned long)_start < ei.memsize)
>> +		if ((unsigned long)_start < ei.loadsize)
> 
> 
> I think this needs to be a two part test (add approprate casts):  
> 	_start < ei.loadsize || _end < ei.memsize
> 
> .. and a comment explaining why.

okay.

> We could do better if we kept allocating more memory until we got
> above it, but the current code has no such provision.  (prpmc2800, or
> one of those, actually decompresses the header to peek at memsize
> before starting the simple_alloc code).

I don't thing I can follow. Do you want to move the bootwrapper code above 
the limit and recall it?

Sebastian
