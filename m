Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17505.39199.355967.509714@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 17:41:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060509.233958.73723993.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
	<17505.34919.750295.170941@cargo.ozlabs.ibm.com>
	<20060509.233958.73723993.davem@davemloft.net>
Cc: olof@lixom.net, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David S. Miller writes:

> That first cache line of current_thread_info() should be so hot that
> it's probably just fine to use current_thread_info()->task since
> you're just doing a mask on a fixed register (r1) to implement that.

I tried that, but I found that adding 1 instruction to the sequence
for getting current adds about 8k to the kernel text.  Currently we do
it in one instruction, that would be two - the mask and the load.  It
probably doesn't make a measurable difference to performance, but it
doesn't look good.  The number of instructions we lose by using
__thread is much less than the 8k we gain from using
current_thread_info()->task for current.  So I'd prefer to use a
per-cpu variable for current, since we can get to that in 1
instruction.

Paul.
