Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17517.2088.150094.338667@cargo.ozlabs.ibm.com>
Date: Fri, 19 May 2006 09:50:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510.171127.42619262.davem@davemloft.net>
References: <20060510154702.GA28938@twiddle.net>
	<17506.29128.591758.502430@cargo.ozlabs.ibm.com>
	<17506.31456.68099.57515@cargo.ozlabs.ibm.com>
	<20060510.171127.42619262.davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, amodra@bigpond.net, rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David S. Miller writes:

> If you have to hide the operation so deeply like this, maybe you can
> do something similar to sparc64, by explicitly doing the per-cpu fixed
> register and offsets, and still get the single instruction relocs that
> powerpc can do for up to 64K by doing something like:
> 
> 	&per_cpu_blah - &per_cpu_base
> 
> to calculate the offset.

I don't know how to tell gcc that (&per_cpu_blah - &per_cpu_base) is a
quantity that the linker can compute and that will fit into a 16-bit
offset.  If I use an inline asm, then I have to generate the address
and let gcc dereference it, because __get_cpu_var is used both as an
lvalue and an rvalue.  That means two instructions where one would
suffice.  So there doesn't seem to be a way to get the optimal code,
unless the gcc folks are willing to add a -fkernel or something for
us. :)

Paul.
