Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 Aug 2010 16:41:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Feature nop out reservation clear when stcx
	checks address
Message-ID: <20100811064152.GC15252@drongo>
References: <20100811052005.GV29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100811052005.GV29316@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 11, 2010 at 03:20:05PM +1000, Anton Blanchard wrote:

> All recent POWER CPUs check the address before letting the stcx succeed
> so we can create a CPU feature and nop it out. As Ben suggested, we can
> only do this in our syscall path because there is a remote possibility
> some kernel code gets interrupted by an exception that ends up operating
> on the same cacheline.

Nice...  Just one nit, and that is that I think we now need a dummy
stcx in the context switch code so there is no possibility of getting
from one user context to another with a reservation still pending from
the first context.  I guess our chances of getting through schedule()
without doing any atomics, bitops or spinlocks are pretty remote, but
nevertheless it might be as well to make sure.

Paul.
