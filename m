Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B66B5DE057
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 15:12:11 +1000 (EST)
Subject: Re: [PATCH]  bug fix in arch/powerpc/mm/tlb_nohash_low.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Torez Smith <lnxtorez@linux.vnet.ibm.com>
In-Reply-To: <1242622146.31702.26.camel@torez.austin.ibm.com>
References: <1242622146.31702.26.camel@torez.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 15:12:03 +1000
Message-Id: <1242623523.18075.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-05-17 at 23:49 -0500, Torez Smith wrote:
> File arch/powerpc/mm/tlb_nohash_low.S defines various processor specific low level TLB invalidation. Most all family of validations are grouped via pre-processor defines with the intent we error out if we reach the end and our platform is not represented. Given this, the last few lines of the file should look similar to the following....
> <<  SNIP  >>
> 1:      wrtee   r10
>         blr
> #else
> #error Unsupported processor type !
> #endif
> 
> However, the #else is incorrectly written as #elif.  On some of the newer compilers/assemblers, this will not successfully assemble and will cause an error.

Thanks, but it's been fixed already :-)

See commit b62c31ae401c6df25c61b206681a6e904ef97169.

Cheers,
Ben.
