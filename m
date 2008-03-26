Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6B91DE27D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 02:09:25 +1100 (EST)
In-Reply-To: <200803251914.24021.laurentp@cse-semaphore.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251823.32039.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0427706A@ismail.innsys.innovsys.com>
	<200803251914.24021.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b06db7bb4932d14f8af9547abdfc9d0d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Wed, 26 Mar 2008 16:06:45 +0100
To: Laurent Pinchart <laurentp@cse-semaphore.com>
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

> So we're left with two main options.
>
> - Reusing the nvram device type from the Device Support Extensions.

This wouldn't bring you anything.  A device_type is only used internally
by OF, to decide what device nodes support which OF programming model.
If you only have a flat device tree, "device_type" should be used only
as a workaround for older kernels that require it.

> - Using another device node with a compatible value set to 
> "linear-ram" (or
> something similar). This would support both volatile and non-volatile
> devices, and a property could be added to specify if the device is 
> volatile
> or not.

"memory-mapped-memory" perhaps :-)

Or, just "memory".  Although that one might play havoc with some
not-quite-correct main memory probing code.


Segher
