Return-Path: <hollisb@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A2EDB7BC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:04:43 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9ML3B0I001516
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2009 17:03:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9ML4dlE934080
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2009 17:04:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9ML3wdP026237
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2009 17:03:58 -0400
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200910201415.34361.rusty@rustcorp.com.au>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<200910201142.34006.rusty@rustcorp.com.au>
	<1256002193.6546.2.camel@slab>
	<200910201415.34361.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Thu, 22 Oct 2009 14:04:37 -0700
Message-Id: <1256245477.7495.30.camel@slab.austin.ibm.com>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, Jan Beulich <JBeulich@novell.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-20 at 14:15 +1030, Rusty Russell wrote:
> BUILD_BUG_ON used to use the optimizer to do code elimination or fail
> at link time; it was changed to first the size of a negative array (a
> nicer compile time error), then (in
> 8c87df457cb58fe75b9b893007917cf8095660a0) to a bitfield.
> 
> bitfields: needs a literal constant at parse time, and can't be put under
> 	"if (__builtin_constant_p(x))" for example.
> negative array: can handle anything, but if the compiler can't tell it's
> 	a constant, silently has no effect.
> link time: breaks link if the compiler can't determine the value, but the
> 	linker output is not usually as informative as a compiler error.
> 
> If we use the negative-array-size method *and* the link time trick,
> we get the ability to use BUILD_BUG_ON() under __builtin_constant_p()
> branches, and maximal ability for the compiler to detect errors at
> build time.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks Rusty, this indeed fixes the problem.

Acked-by: Hollis Blanchard <hollisb@us.ibm.com>

-- 
Hollis Blanchard
IBM Linux Technology Center
