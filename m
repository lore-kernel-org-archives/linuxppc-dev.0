Return-Path: <jschopp@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F659679F3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 05:56:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4FJuFuu014706
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 15:56:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4FJuErI175186
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 13:56:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4FJuEbI010494
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 13:56:14 -0600
Message-ID: <4468DCDD.5090609@austin.ibm.com>
Date: Mon, 15 May 2006 14:56:13 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] remove powerpc bitops infavor of existing generic bitops
References: <20060515180108.GB17646@us.ibm.com>
In-Reply-To: <20060515180108.GB17646@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There already exists a big endian safe bitops implementation in
> lib/find_next_bit.c.  The code in it is 90%+ common with the powerpc
> specific version, so the powerpc version is redundant.  This patch
> makes the necessary changes to use the generic bitops in powerpc, and
> removes the powerpc specific version.

I like generic as much as the next guy, but I'm also a big fan of fast bitops.  And the 
function below is fast.  You'll have to explain to me how the generic code is going to 
find the first zero as fast without explicit calls to ppc assembly.

> -static inline unsigned int ext2_ilog2(unsigned int x)
> -{
> -	int lz;
> -
> -	asm("cntlzw %0,%1": "=r"(lz):"r"(x));
> -	return 31 - lz;
> -}
