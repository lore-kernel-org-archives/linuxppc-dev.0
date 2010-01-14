Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Dynamically allocate pacas
In-reply-to: <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael@ellerman.id.au>
References: <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael@ellerman.id.au>
Date: Thu, 14 Jan 2010 11:26:22 +1100
Message-ID: <23306.1263428782@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 64-bit kernels we currently have a 512 byte struct paca_struct for
> each cpu (usually just called "the paca"). Currently they are statically
> allocated, which means a kernel built for a large number of cpus will
> waste a lot of space if it's booted on a machine with few cpus.
> 
> We can avoid that by only allocating the number of pacas we need at
> boot. However this is complicated by the fact that we need to access
> the paca before we know how many cpus there are in the system.
> 
> The solution is to dynamically allocate enough space for NR_CPUS pacas,
> but then later in boot when we know how many cpus we have, we free any
> unused pacas.
> 
> Lightly booted on Legacy iSeries & pSeries LPAR.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Nice!

<snip>

> +	lmb_free(__pa(paca) + new_size, paca_size - new_size);

You didn't explicitly mention this above but this depends on your
lmb_free patch...

FYI boots bare metal

Mikey
