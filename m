Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE179DDFA9
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 00:02:45 +1000 (EST)
In-Reply-To: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
References: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37E422D0-D937-4C5E-A4A2-EF911B4149E3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] 64 bit csum_partial_copy_generic
Date: Thu, 11 Sep 2008 15:45:05 +0200
To: jschopp@austin.ibm.com
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The current 64 bit csum_partial_copy_generic function is based on  
> the 32 bit version and never was optimized for 64 bit.  This patch  
> takes the 64 bit memcpy and adapts it to also do the sum.  It has  
> been tested on a variety of input sizes and alignments on Power5  
> and Power6 processors.  It gives correct output for all cases  
> tested.  It also runs 20-55% faster than the implemention it  
> replaces depending on size, alignment, and processor.
>
> I think there is still some room for improvement in the unaligned  
> case, but given that it is much faster than what we have now I  
> figured I'd send it out.

Did you consider the other alternative?  If you work on 32-bit chunks
instead of 64-bit chunks (either load them with lwz, or split them
after loading with ld), you can add them up with a regular non-carrying
add, which isn't serialising like adde; this also allows unrolling the
loop (using several accumulators instead of just one).  Since your
registers are 64-bit, you can sum 16GB of data before ever getting a
carry out.

Or maybe the bottleneck here is purely the memory bandwidth?

> Signed-off-by: Joel Schopp<jschopp@austin.ibm.com>

You missed a space there.


Segher
