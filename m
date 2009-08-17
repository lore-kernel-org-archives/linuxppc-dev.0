Return-Path: <dipankar@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 02669B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 16:24:39 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7H6M5s7011468
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 16:22:05 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7H6OVRa1130686
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 16:24:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7H6OUUW013353
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 16:24:31 +1000
Date: Mon, 17 Aug 2009 11:54:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090817062418.GB31027@in.ibm.com>
References: <20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
	<20090812195753.GA14649@in.ibm.com>
	<alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
	<20090813045931.GB14649@in.ibm.com>
	<20090814113021.GL32418@elf.ucw.cz>
	<20090816182629.GA31027@in.ibm.com>
	<20090816194441.GA22626@balbir.in.ibm.com>
	<1250459602.8648.35.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250459602.8648.35.camel@laptop>
Cc: "Brown, Len" <len.brown@intel.com>, Gautham R Shenoy <ego@in.ibm.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	balbir@linux.vnet.ibm.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Len Brown <lenb@kernel.org>
Reply-To: dipankar@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 16, 2009 at 11:53:22PM +0200, Peter Zijlstra wrote:
> On Mon, 2009-08-17 at 01:14 +0530, Balbir Singh wrote:
> > Agreed, I've tried to come with a little ASCII art to depict your
> > scenairos graphically
> > 
> > 
> >         +--------+ don't need (offline)
> >         |  OS    +----------->+------------+
> >         +--+-----+            | hypervisor +-----> Reuse CPU
> >            |                  |            |       for something
> >            |                  |            |       else
> >            |                  |            |   (visible to users)
> >            |                  |            |    as resource changed
> >            |                  +----------- +
> >            V (needed, but can cede)
> >        +------------+
> >        | hypervisor | Don't reuse CPU
> >        |            |  (CPU ceded)
> >        |            | give back to OS
> >        +------------+ when needed.
> >                         (Not visible to
> >                         users as so resource
> >                         binding changed)
> 
> I still don't get it... _why_ should this be exposed in the guest
> kernel? Why not let the hypervisor manage a guest's offline cpus in a
> way it sees fit?

For most parts, we do. The guest kernel doesn't manage the offline
CPU state. That is typically done by the hypervisor. However, offline
operation as defined now always result in a VM resize in some hypervisor
systems (like pseries) - it would be convenient to have a non-resize
offline operation which lets the guest cede the cpu to hypervisor
with the hint that the VM shouldn't be resized and the guest needs the guarantee
to get the cpu back any time. The hypervisor can do whatever it wants
with the ceded CPU including putting it in a low power state, but
not change the physical cpu shares of the VM. The pseries hypervisor,
for example, clearly distinguishes between the two - "rtas-stop-self" call
to resize VM vs. H_CEDE hypercall with a hint. What I am suggesting
is that we allow this with an extension to existing interfaces because it 
makes sense to allow sort of "hibernation" of the cpus without changing any
configuration of the VMs.

Thanks
Dipankar
