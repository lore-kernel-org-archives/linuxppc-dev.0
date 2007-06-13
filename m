Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18031.15747.57370.99388@cargo.ozlabs.ibm.com>
Date: Wed, 13 Jun 2007 10:42:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 02/10] powerpc: Move CONFIG_PPC64 into CPU selection
In-Reply-To: <d8ba058b9bc8f9738d2c3d764c568c1e@kernel.crashing.org>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.734704855@arndb.de>
	<18030.15937.699275.958545@cargo.ozlabs.ibm.com>
	<200706121008.01661.arnd@arndb.de>
	<18030.32600.921348.218117@cargo.ozlabs.ibm.com>
	<d8ba058b9bc8f9738d2c3d764c568c1e@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> It would be good to converge the 32- and 64-bit implementations,
> and/or allow a single kernel image to work on both 32-bit and
> 64-bit systems,  The current situation is far removed from that,
> so this patch is a bit premature in that aspect.

There will always be differences in emphasis and focus between 32-bit
and 64-bit.  For example, the vast majority of 32-bit systems are UP,
with a few 2-way SMP systems, an insignificant number of 4-way
systems, and nothing bigger than 4-way.  In contrast, most 64-bit
machines are SMP, with enough large SMP machines (64-way and bigger)
to be worth worrying about.  Hence the 64-bit code focuses on SMP
scalability whereas the 32-bit code focuses on performance for UP and
2-way systems - which is why the hash table invalidations get batched
up on 64-bit machines but not on 32-bit machines, for instance.
Similarly, 64-bit supports large memory (>4GB) and NUMA machines,
whereas 32-bit doesn't.

Paul.
