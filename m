Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 5B6E9679F3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 20:16:33 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1147245709.32448.74.camel@localhost.localdomain> 
References: <1147245709.32448.74.camel@localhost.localdomain>
	<17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
	<17505.34919.750295.170941@cargo.ozlabs.ibm.com>
	<20060509.233958.73723993.davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables 
Date: Wed, 10 May 2006 11:14:53 +0100
Message-ID: <14201.1147256093@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, olof@lixom.net,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > That first cache line of current_thread_info() should be so hot that
> > it's probably just fine to use current_thread_info()->task since
> > you're just doing a mask on a fixed register (r1) to implement that.
> 
> Iirc, he tried that, though it did bloat the kernel size a bit due the
> the amount of occurences of current-> in there. We are now thinking
> about either dedicating a register to current (that would avoid the
> problem of printk() using it in start_kernel before we get the per-cpu
> areas setup) in addition to __thread (heh, we have lots of registers on
> ppc :) or maybe putting current back in the paca...

I dedicated registers to current and current threadinfo in the FRV arch.  As I
recall doing that improved both performance and code size quite a bit.  It also
means that I get sensible bug panic reports when the stack pointer overruns the
stack space.

David
