Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18483.41361.745089.794208@cargo.ozlabs.ibm.com>
Date: Wed, 21 May 2008 14:14:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Liu <shengping.liu@windriver.com>
Subject: Re: [PATCH] [POWERPC] Uniformly use memstart_addr variable as the
	start address of physical memory in powerpc branch
In-Reply-To: <4833875A.9090006@windriver.com>
References: <48337D1C.2070108@windriver.com>
	<BEDAF2CE-73A5-4FE4-848B-936B7D675131@kernel.crashing.org>
	<4833875A.9090006@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Liu writes:

> You know we can't make sure in future the start address of all incoming 
> boards' RAM is 0, especially, in AMP system, different cpu uses the different RAM area, 
> definitely, the start address of some is not 0.

Any processor that uses ppc_mmu_32.c will have interrupt vectors in
the 0 - 0x3000 region of memory and hence *must* have RAM starting at
zero.  In other words, that file is only used for "classic" 32-bit
PowerPC processors, not for anything based on Book E or Power
architecture v2.04 or later.

Paul.
