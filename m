Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4669BDDEDB
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 04:12:31 +1000 (EST)
In-Reply-To: <47EA6E88.5050109@ru.mvista.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>	<200803251823.32039.laurentp@cse-semaphore.com>	<DCEAAC0833DD314AB0B58112AD99B93B0427706A@ismail.innsys.innovsys.com>	<200803251914.24021.laurentp@cse-semaphore.com>
	<b06db7bb4932d14f8af9547abdfc9d0d@kernel.crashing.org>
	<47EA6E88.5050109@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f7651faf227608c9f9ca8f2737416f9a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Sun, 30 Mar 2008 20:12:00 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> "memory-mapped-memory" perhaps :-)
>
>> Or, just "memory".  Although that one might play havoc with some
>
>    I'd suggest "ram" and "rom" then. Luckily the device trees don't 
> contain binding for the real RAM chips yet. :-)
>
>> not-quite-correct main memory probing code.
>
>    You mean the there's parsers that search the "compatible" prop for 
> "memory" as well as "device_type" prop?

There are parsers that make all kinds of mistakes, sure.

The code that figures out what region of ram to use should look at the
node pointed to by /chosen/memory, it's shouldn't look for anything
with a certain "compatible", and it shouldn't look at "device_type"
_at all_.


Segher
