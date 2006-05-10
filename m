Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5DD1679F3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 17:22:23 +1000 (EST)
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060509.233958.73723993.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
	<17505.34919.750295.170941@cargo.ozlabs.ibm.com>
	<20060509.233958.73723993.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 10 May 2006 17:21:49 +1000
Message-Id: <1147245709.32448.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: olof@lixom.net, linux-arch@vger.kernel.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-09 at 23:39 -0700, David S. Miller wrote:
> From: Paul Mackerras <paulus@samba.org>
> Date: Wed, 10 May 2006 16:29:59 +1000
> 
> > I have moved current, smp_processor_id and a couple of other things to
> > per-cpu variables, and that results in the kernel text being about 8k
> > smaller than without any of these __thread patches.  Performance seems
> > to be very slightly better but it's hard to be sure that the change is
> > statistically significant, from the measurements I've done so far.
> 
> That first cache line of current_thread_info() should be so hot that
> it's probably just fine to use current_thread_info()->task since
> you're just doing a mask on a fixed register (r1) to implement that.

Iirc, he tried that, though it did bloat the kernel size a bit due the
the amount of occurences of current-> in there. We are now thinking
about either dedicating a register to current (that would avoid the
problem of printk() using it in start_kernel before we get the per-cpu
areas setup) in addition to __thread (heh, we have lots of registers on
ppc :) or maybe putting current back in the paca...

It's a bit sad that we can't get rid of the PACA because it has to be in
the RMA (for those who don't know that it is, the RMA is an area of
memory that is accessible in real mode on LPAR machines, that is the
hypervisor guarantees a bunch of physically contiguous memory that is
made accessible to the partition for use in real mode). We could have
put the per-cpu infos in the RMA but I'm a bit freaked out by the idea
of having those not be node-local...

Ben.
