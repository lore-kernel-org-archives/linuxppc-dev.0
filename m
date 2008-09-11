Return-Path: <jschopp@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3222FDDF9B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 03:45:08 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8BHiux6002031
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 13:44:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8BHikNn165636
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 13:44:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8BHijhG029592
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 13:44:45 -0400
Message-ID: <48C9590C.2020508@austin.ibm.com>
Date: Thu, 11 Sep 2008 12:44:44 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] 64 bit csum_partial_copy_generic
References: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
	<37E422D0-D937-4C5E-A4A2-EF911B4149E3@kernel.crashing.org>
In-Reply-To: <37E422D0-D937-4C5E-A4A2-EF911B4149E3@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Did you consider the other alternative?  If you work on 32-bit chunks
> instead of 64-bit chunks (either load them with lwz, or split them
> after loading with ld), you can add them up with a regular non-carrying
> add, which isn't serialising like adde; this also allows unrolling the
> loop (using several accumulators instead of just one).  Since your
> registers are 64-bit, you can sum 16GB of data before ever getting a
> carry out.
>
> Or maybe the bottleneck here is purely the memory bandwidth?
I think the main bottleneck is the bandwidth/latency of memory.

When I sent the patch out I hadn't thought about eliminating the e from 
the add with 32 bit chunks.  So I went off and tried it today and 
converting the existing function to use just add instead of adde (since 
it was only doing 32 bits already) and got 1.5% - 15.7% faster on 
Power5, which is nice, but was still way behind the new function in 
every testcase.  I then added 1 level of unrolling to that (using 2 
accumulators) and got 59% slower to 10% faster on Power5 depending on 
input. It seems quite a bit slower than I would have expected (I would 
have expected basically even), but thats what got measured. The comment 
in the existing function indicates unrolling the loop doesn't help 
because the bdnz has zero overhead, so I guess the unrolling hurt more 
than I expected.

In any case I have now thought about it and don't think it will work out.

>
>> Signed-off-by: Joel Schopp<jschopp@austin.ibm.com>
>
> You missed a space there.
If at first you don't succeed...

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
