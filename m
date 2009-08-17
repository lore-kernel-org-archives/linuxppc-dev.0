Return-Path: <dipankar@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A2D7CB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 17:58:30 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7H7rM8r021227
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 13:23:22 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7H7wLfk2826384
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 13:28:21 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7H7wKGH015317
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 17:58:21 +1000
Date: Mon, 17 Aug 2009 13:28:15 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090817075815.GB11049@in.ibm.com>
References: <20090812115806.GK24339@elf.ucw.cz>
	<20090812195753.GA14649@in.ibm.com>
	<alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
	<20090813045931.GB14649@in.ibm.com>
	<20090814113021.GL32418@elf.ucw.cz>
	<20090816182629.GA31027@in.ibm.com>
	<20090816194441.GA22626@balbir.in.ibm.com>
	<1250459602.8648.35.camel@laptop>
	<20090817062418.GB31027@in.ibm.com>
	<1250493357.5241.1656.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250493357.5241.1656.camel@twins>
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

On Mon, Aug 17, 2009 at 09:15:57AM +0200, Peter Zijlstra wrote:
> On Mon, 2009-08-17 at 11:54 +0530, Dipankar Sarma wrote:
> > For most parts, we do. The guest kernel doesn't manage the offline
> > CPU state. That is typically done by the hypervisor. However, offline
> > operation as defined now always result in a VM resize in some hypervisor
> > systems (like pseries) - it would be convenient to have a non-resize
> > offline operation which lets the guest cede the cpu to hypervisor
> > with the hint that the VM shouldn't be resized and the guest needs the guarantee
> > to get the cpu back any time. The hypervisor can do whatever it wants
> > with the ceded CPU including putting it in a low power state, but
> > not change the physical cpu shares of the VM. The pseries hypervisor,
> > for example, clearly distinguishes between the two - "rtas-stop-self" call
> > to resize VM vs. H_CEDE hypercall with a hint. What I am suggesting
> > is that we allow this with an extension to existing interfaces because it 
> > makes sense to allow sort of "hibernation" of the cpus without changing any
> > configuration of the VMs.
> 
> >From my POV the thing you call cede is the only sane thing to do for a
> guest. Let the hypervisor management interface deal with resizing guests
> if and when that's needed.

That is more or less how it currently works - atleast for pseries hypervisor. 
The current "offline" operation with "rtas-stop-self" call I mentioned
earlier is initiated by the hypervisor management interfaces/tool in
pseries system. This wakes up a guest system tool that echoes "1"
to the offline file resulting in the configuration change.
The OS involvement is necessary to evacuate tasks/interrupts
from the released CPU. We don't really want to initiate this from guests.

> Thing is, you don't want a guest to be able to influence the amount of
> cpu shares attributed to it. You want that in explicit control of
> whomever manages the hypervisor.

Agreed. But given a fixed cpu share by the hypervisor management tools,
we would like to be able to cede cpus to hypervisor leaving the hypervisor
configuration intact. This, we don't have at the moment and want to just
extend the current interface for this.

Thanks
Dipankar
