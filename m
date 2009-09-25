Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18490B7B93
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Sep 2009 02:34:36 +1000 (EST)
Subject: Re: e300 (MPC5121) dlmzb
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4ABCA454.5030807@mta.it>
Date: Fri, 25 Sep 2009 09:34:17 -0700
Message-Id: <6740A6EE-AAD7-42FA-BC1F-17ECC59E0C1C@kernel.crashing.org>
References: <4ABCA454.5030807@mta.it>
To: Fortini Matteo <matteo.fortini@mta.it>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 25, 2009, at 4:07 AM, Fortini Matteo wrote:

> I was trying to insert an optimized strlen() function using the  
> following code taken from the ibm site on an MPC5121, but it crashes  
> the kernel.
> Is it because it's an unsupported op, or because I'm missing some  
> needed steps?
>
> Thank you,
> Matteo
>
> _GLOBAL(strlen)
>   addi   r4,0,8    // Load byte count of 8
>   mtxer  r4        // Set byte count for load string
>   xor    r4,r4,r4  // r4 = 0, r4 == accumulator
> 1:
>   lswx   r5,r3,r4  // load string into r5 & r6
>   dlmzb. r12,r5,r6 // find NULL byte and record in r7.
>   add    r4,r4,r12 // Update accumulator.
>   beq    1b        // Loop if NULL not found.
>   addi   r3,r4,-1  // Subtract 1 for NULL byte.
>   blr              // Return length

dlmzb. isn't supported on e300.  I believe only 4xx supports it.

- k
