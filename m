Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2CAE3DE190
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:31:58 +1100 (EST)
Date: Sun, 28 Jan 2007 15:31:56 -0800 (PST)
Message-Id: <20070128.153156.63125702.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
References: <m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
	<1170019048.26655.27.camel@localhost.localdomain>
	<m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, brice@myri.com,
	greg@kroah.com, shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 15:36:20 -0700

> That might be the right solution.  I don't know.  But that is one
> among several that your HV interface is wrong and probably should be
> fixed at the HV.  I definitely have no intentions of encouraging
> another HV to emulate the brittleness of your solution.
> 
> Nor do I want to ask device drivers to preallocate 4096 interrupts
> just in case they need them.  Even if batch allocation makes sense
> always asking for the maximum possible that you might use is overkill.

Other platforms do this and I think it is totally reasonable
to protect the defined PCI config register writes for MSI
and MSI-X behind the hypervisor calls.

It is one of several legitimate ways to keep a PCI device from
transmitting random junk to other devices which are on behind the same
PCI controller yet belong to another virtual domain.

Another solution is to have a PCI-E bridges define the unit of
splitability between virtual domains, and have those PCI-E bridges
protect each other from inter-domain MSI message writes.

Both solutions are valid, and each platform and hypervisor may make
either decision and it is reasonable.

About your argument of a MSI-Y, these platforms simply don't support
such devices and the people who design these systems and hypervisors
absolutely accept that limitation as a design trade off.  It's not a
bad thing.

Look, I have no idea where all this resistence come from to abstract
this stuff behind enough levels to support things like RTAS et al.
properly.  Please stop it now.
