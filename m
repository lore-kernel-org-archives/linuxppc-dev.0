Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17505.34919.750295.170941@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 16:29:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Looks like alot of the text growth is from the added mfsprg3 instructions:

Yes, probably mostly from current.

> ... so, as the PACA gets deprecated, the bloat will go away again.

Yes.  I was hoping to get rid of the paca entirely, but that would
mean it would have to be in the RMA (so that the early exception entry
code can use it) which means that it won't be node-local any more.
I have a patch which allocates the per-cpu areas in the RMA but now
I'm rethinking it, since Ben H (at least) thinks the per-cpu area
really needs to be node-local.

Moving current to a per-cpu variable means that we need to allocate at
least the boot cpu's per-cpu area earlier than we do now, since it
seems that printk references current.  That makes it hard to make sure
the boot cpu's per-cpu area is node-local, unless we do something
tricky like reallocating it once the bootmem allocator is available.

> It would be interesting to see benchmarks of how much it improves
> things. I guess it doesn't really get interesting until after the paca
> gets removed though, due to the added mfsprg's.

I have moved current, smp_processor_id and a couple of other things to
per-cpu variables, and that results in the kernel text being about 8k
smaller than without any of these __thread patches.  Performance seems
to be very slightly better but it's hard to be sure that the change is
statistically significant, from the measurements I've done so far.

Paul.
