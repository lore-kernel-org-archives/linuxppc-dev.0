Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 104FF67A3B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 00:17:12 +1000 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id 692281EEC0E2
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 10:11:31 -0400 (EDT)
Date: Mon, 3 Apr 2006 09:10:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403141027.GB25663@localdomain>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
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
> On Sun, 2 Apr 2006, Paul Jackson wrote:
> 
> > -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> > +		for_each_online_cpu(cpu) {
> > 
> > Idle curiosity -- what keeps a cpu from going offline during
> > this scan, and leaving us with the same crash as before?
> 
> Nothing keeps a processor from going offline. We could take the hotplug 
> lock for every for_each_online_cpu() in the kernel.

In this case, disabling preempt around the for_each_online_cpu loop
would prevent any cpu from going down in the meantime.  But since this
function doesn't look like it's a hot path, and we're potentially
traversing lots of zones and cpus, lock_cpu_hotplug might be preferable.

As Paul noted, the fix as it stands isn't adequate.
