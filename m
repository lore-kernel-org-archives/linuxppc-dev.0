Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 5B166679E1
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 00:18:30 +1000 (EST)
Date: Mon, 3 Apr 2006 09:18:05 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403141805.GC25663@localdomain>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<200604031349.03036.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200604031349.03036.ak@suse.de>
Cc: akpm@osdl.org, ak@suse.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Jackson <pj@sgi.com>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andi Kleen wrote:
> On Monday 03 April 2006 07:15, Paul Jackson wrote:
> > -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> > +		for_each_online_cpu(cpu) {
> > 
> > Idle curiosity -- what keeps a cpu from going offline during
> > this scan, and leaving us with the same crash as before?
> 
> 
> CPU hotdown uses RCU like techniques to avoid this. Only potential
> problem could be on a preemptive kernel, but I hope nobody tries
> cpu unplug on such a beast.

I always turn on preempt when testing cpu hotplug (usually on ppc64).
There were several preempt vs cpu hotplug issues until around 2.6.10
or so, iirc, but I think the situation has been stable for a while
now.
