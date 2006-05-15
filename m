Return-Path: <jschopp@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B54E679F6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 07:58:40 +1000 (EST)
Received: from e36.co.us.ibm.com (e36.boulder.ibm.com [9.17.249.46])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4FKgXpK027141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 16:42:34 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4FKgDGo021509
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 16:42:13 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4FKgCrI174440
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 14:42:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4FKgCS5003071
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 14:42:12 -0600
Message-ID: <4468E7A2.4050002@austin.ibm.com>
Date: Mon, 15 May 2006 15:42:10 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] remove powerpc bitops infavor of existing generic bitops
References: <20060515180108.GB17646@us.ibm.com>
	<4468DCDD.5090609@austin.ibm.com>
	<20060515203815.GC17646@us.ibm.com>
In-Reply-To: <20060515203815.GC17646@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Ah but here's the trick, there is the same explicit call to ppc
> assembly.  The only function in the file removed is this one you pointed
> out, and the only caller of this function is ext2_ffz.  And the only
> user of ext2_ffz is find_next_zero_le_bit.  
> 
> Now the generic code is very similar to the file removed (`diff -Narup
> arch/powerpc/lib/bitops.c lib/find_next_bit.c` to see for yourself).  In
> the same place where ext2_ffz is called, ffz is called in the generic
> code.  Now if we look at the definition of ffz in
> include/asm-powerpc/bitops.h, we see it calls __ilog2 of that same file.
> __ilog2 is defined as: 
> 
> static __inline__ int __ilog2(unsigned long x)
> {
>         int lz;
> 
>         asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (x));
>         return BITS_PER_LONG - 1 - lz;
> }
> 
> So, its really the same code :)

Good explination.  I'm convinced, so for what it's worth:

Acked-by: Joel Schopp <jschopp@austin.ibm.com>
