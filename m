Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17724.39959.51600.232589@cargo.ozlabs.ibm.com>
Date: Mon, 23 Oct 2006 20:40:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
In-Reply-To: <1161308835.10524.108.camel@localhost.localdomain>
References: <1161308835.10524.108.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> There are currently two versions of the functions for applying the
> feature fixups, one for CPU features and one for firmware features. In
> addition, they are both in assembly and with separate implementations
> for 32 and 64 bits. identify_cpu() is also implemented in assembly and
> separately for 32 and 64 bits.
> 
> This patch replaces them with a pair of C functions. The call sites are
> slightly moved on ppc64 as well to be called from C instead of from
> assembly, though it's a very small change, and thus shouldn't cause any
> problem.

Unfortunately this:

> Index: linux-cell/include/asm-powerpc/cputable.h
> ===================================================================
> --- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-13 16:00:28.000000000 +1000
> +++ linux-cell/include/asm-powerpc/cputable.h	2006-10-13 16:19:51.000000000 +1000
> @@ -89,8 +89,7 @@ struct cpu_spec {
>  
>  extern struct cpu_spec		*cur_cpu_spec;
>  
> -extern void identify_cpu(unsigned long offset, unsigned long cpu);
> -extern void do_cpu_ftr_fixups(unsigned long offset);
> +extern struct cpu_spec *identify_cpu(unsigned long offset);

... breaks the ARCH=ppc build.

Paul.
