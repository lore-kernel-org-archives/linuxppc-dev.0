Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C7BF2679E2
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 07:16:16 +1000 (EST)
Date: Mon, 3 Apr 2006 14:18:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-Id: <20060403141834.31cd9dea.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
	<20060403141027.GB25663@localdomain>
	<Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
	<20060403180131.GD25663@localdomain>
	<Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, pj@sgi.com, ntl@pobox.com, ak@suse.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Mon, 3 Apr 2006, Nathan Lynch wrote:
> 
> > > There are many other for_each_*_cpu loops in the kernel that do not have 
> > > any of the instrumentation you suggest. I suggest you come up with a 
> > > general solution and then go through all of them and fix this. Please be 
> > > aware that many of these loops are performance critical.
> > 
> > But this one isn't, right?
> 
> Right. One could use more expensive processing here.

Hopefully none of the for_each_foo() loops are performance-critical - those
things are expensive.

> > And I'm afraid there's a misunderstanding here -- only
> > for_each_online_cpu (or accessing the cpu online map in general) has
> > such restrictions -- for_each_possible_cpu doesn't require any locking
> > or preempt tricks since cpu_possible_map must not change after boot.

for_each_present_cpu() presumably has the same problems.

> Correct. We may want to audit the kernel and check that each 
> for_each_possible_cpu or for_each_cpu is really correct.

A fair bit of that has been happening in recent weeks.

But yes, we should be protecting these things with rcu_read_lock() if
possible, lock_cpu_hotplug() otherwise.

(rcu_read_lock() might not be the appropriate name for this operation -
maybe it should be an open-coded preempt_disable().  Or some other suitably
named alias; dunno).
