Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 07FDE67A2E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 04:01:56 +1000 (EST)
Date: Mon, 3 Apr 2006 13:01:31 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403180131.GD25663@localdomain>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
	<20060403141027.GB25663@localdomain>
	<Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Paul Jackson <pj@sgi.com>,
	ak@suse.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Lameter wrote:
> 
> On Mon, 3 Apr 2006, Nathan Lynch wrote:
> 
> > In this case, disabling preempt around the for_each_online_cpu loop
> > would prevent any cpu from going down in the meantime.  But since this
> > function doesn't look like it's a hot path, and we're potentially
> > traversing lots of zones and cpus, lock_cpu_hotplug might be preferable.
> > 
> > As Paul noted, the fix as it stands isn't adequate.
> 
> There are many other for_each_*_cpu loops in the kernel that do not have 
> any of the instrumentation you suggest. I suggest you come up with a 
> general solution and then go through all of them and fix this. Please be 
> aware that many of these loops are performance critical.

But this one isn't, right?

And I'm afraid there's a misunderstanding here -- only
for_each_online_cpu (or accessing the cpu online map in general) has
such restrictions -- for_each_possible_cpu doesn't require any locking
or preempt tricks since cpu_possible_map must not change after boot.
