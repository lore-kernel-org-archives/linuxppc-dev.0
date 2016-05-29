Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHtBW1dslzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 07:27:30 +1000 (AEST)
Message-ID: <1464557231.3078.185.camel@kernel.crashing.org>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for
 book3s 64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Date: Mon, 30 May 2016 07:27:11 +1000
In-Reply-To: <20160529210356.66dd944e@kryten>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-05-29 at 21:03 +1000, Anton Blanchard wrote:
> Hi,
> 
> > 
> > This enables us to share the same page table code for
> > both radix and hash. Radix use a hardware defined big endian
> > page table
> This is measurably worse (a little over 2% on POWER8) on a futex
> microbenchmark:

That is surprising, do we have any idea what specifically increases the
overhead so significantly ? Does gcc know about ldbrx/stdbrx ? I notice
in our io.h for example we still do manual ld/std + swap because old
processors didn't know these, we should fix that for CONFIG_POWER8 (or
is it POWER7 that brought these ?).

Cheers,
Ben.

> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <linux/futex.h>
> 
> #define ITERATIONS 10000000
> 
> #define futex(A, B, C, D, E, F)		syscall(__NR_futex, A,
> B, C, D, E, F)
> 
> int main(void)
> {
> 	unsigned long i = ITERATIONS;
> 
> 	while (i--) {
> 		unsigned int addr = 0;
> 
> 		futex(&addr, FUTEX_WAKE, 1, NULL, NULL, 0);
> 	}
> 
> 	return 0;
> }
> 
> Is there any way to avoid the radix tax here?
> 
> Anton
