Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 724EBDE2E3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 03:10:54 +1000 (EST)
Message-ID: <48988599.5020008@ovro.caltech.edu>
Date: Tue, 05 Aug 2008 09:53:45 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: floating point support in the driver.
References: <18772109.post@talk.nabble.com>	<200808011332.25368.laurentp@cse-semaphore.com>	<18772952.post@talk.nabble.com>	<20080801.095429.-1827411968.imp@bsdimp.com>	<18805820.post@talk.nabble.com>	<20080803.233352.915266361.imp@bsdimp.com>	<48969805.40904@ovro.caltech.edu>
	<18827857.post@talk.nabble.com>
In-Reply-To: <18827857.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Misbah,

> I am running the algorithm on OMAP processor (arm-core)
> and i did tried the same on iMX processor which
> takes 1.7 times more than OMAP.

Ok, thats a 10,000ft benchmark. The observation being
that it fails your requirement.

How does that time compare to the operations
required, and their expected times?

> It is true that the algorithm is performing the vector
> operation which is blowing the cache.

Determined how? Obviously if your cache is 16K and your
data is 64K, there's no way it'll fit in there at once,
but the algorithm could be crafted such that 1K at a time
was processed, while another data packet was moved onto
the cache ... but this is very processor specific.

> But the question is How to lock the cache ? In driver
> how should we implement the same ?
> 
> An example code or a document could be helpful in this regard.

Indeed :)

I have no idea how the OMAP works, so the following are
just random, and possibly incorrect ramblings ...

The MPC8349EA startup code uses a trick where it zeros
out sections of the cache while providing an address.
Once the addresses and zeros are in the cache, its locked.
 From that point on, memory accesses to those addresses
result in cache 'hits'. This is the startup stack used
by the U-Boot bootloader.

If something similar was done under Linux, then *I guess*
you could implement mmap() and ioremap() the section of
addresses associated with the locked cache lines.
You could then DMA data to and from the cache area,
and run your algorithm there. That would provide you
'fast SRAM'.

However, you might be able to get the same effect by
setting up your processing algorithm such that it handled
smaller chunks of data.

Feel free to explain your data processing :)

Cheers,
Dave
