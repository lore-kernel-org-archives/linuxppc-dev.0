Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 07:05:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510.124003.04457042.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David S. Miller writes:

> From: Richard Henderson <rth@twiddle.net>
> Date: Wed, 10 May 2006 08:47:13 -0700
> 
> > How do you plan to address the compiler optimizing
>  ...
> > Across the schedule, we may have changed cpus, making the cached
> > address invalid.
> 
> Per-cpu variables need to be accessed only with preemption
> disabled.  And the preemption enable/disable operations
> provide a compiler memory barrier.

No, Richard has a point, it's not the value that is the concern, it's
the address, which gcc could assume is still valid after a barrier.
Drat.

Paul.
