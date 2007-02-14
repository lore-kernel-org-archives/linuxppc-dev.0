Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A5C8DDF80
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:20:27 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1ECLfw41515622
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:21:46 -0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1E0NhCg165550
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:23:43 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1E0KDAQ009620
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:20:13 +1100
Date: Wed, 14 Feb 2007 11:16:22 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
Message-ID: <20070214001622.GB11491@localhost.localdomain>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171379087.4003.40.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 09:04:47AM -0600, Josh Boyer wrote:
> On Tue, 2007-02-13 at 17:10 +1100, David Gibson wrote:
> > This patch adds support for early serial debugging via the built in
> > port on IBM/AMCC PowerPC 44x CPUs.  It uses a bolted TLB entry in
> > address space 1 for the UART's mapping, allowing robust debugging both
> > before and after the initialization of the MMU.
> 
> When enabling this option, I get the following error:
> 
>  AS      arch/powerpc/kernel/head_44x.o
> arch/powerpc/kernel/head_44x.S: Assembler messages:
> arch/powerpc/kernel/head_44x.S:179: Warning: left operand is a bignum;
> integer 0 assumed
> arch/powerpc/kernel/head_44x.S:183: Error: bignum invalid
> arch/powerpc/kernel/head_44x.S:184: Warning: left operand is a bignum;
> integer 0 assumed
> make[1]: *** [arch/powerpc/kernel/head_44x.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2

Um... works for me?  What version of the assembler are you using?

I'm using a 64-bit constant there, but for me at least the assembler
is able to handle manipulating it in constant expressions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
