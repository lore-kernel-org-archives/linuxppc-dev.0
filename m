Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18116.52784.132826.595409@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2007 08:22:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
In-Reply-To: <20070816163850.GU4261@austin.ibm.com>
References: <20070816070922.37B5370074@localhost.localdomain>
	<20070816163850.GU4261@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> My gut impression (maybe wrong?) is that the scaled time is,
> in a certain sense, "more accurate" than the unscaled time.

The "unscaled" time is just time, as in "how many seconds did this
task spend on the CPU".  It's what all the tools (except a certain
proprietary workload manager) expect.  Top, ps, etc. get unhappy if
the times reported (user, system, hardirq, softirq, idle, stolen)
don't add up to elapsed wall-clock time.

The "scaled" time is really CPU cycles divided by some arbitrary
factor (the notional CPU frequency).  So yes it does give some
indication of how much progress the task should have made, in some
sense.

Both measures are useful.  Because the current user API is in terms of
real time rather than cycles, we have to continue reporting real time,
not scaled time, which is why the existing interfaces report unscaled
time, and the scaled time values are reported through a new extension
to the taskstats interface.

Paul.
