Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 8EBEADDF20
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 06:15:27 +1100 (EST)
Date: Fri, 29 Feb 2008 13:15:18 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 0/3] hotplug memory remove updates
Message-ID: <20080229191518.GV16241@localdomain>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<20080229013957.GQ16241@localdomain> <47C76BBA.5000503@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47C76BBA.5000503@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Badari Pulavarty <pbadari@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> 
> I'm wondering how the memory hot un-plug is initiated on the pseries.
> Could you tell me about this HMC?  Is it an application running in
> the lpar, or is it an external entity?

The HMC (Hardware Management Console) is a system separate from the
pseries box.  It's used to provision and, um, manage, one or more
systems and their partitions.  It communicates with both the POWER
hypervisor and some optional userspace daemons and utilities running
on the lpars.

> Is there a 'standard' interface from userspace that can be used to
> trigger the hot-unplug sequence?  I'm asking because PS3's lv1
> hypervisor supports hot un-plug of memory, but it would need to be
> triggered from some kind of management application running in in
> userspace.

I think sysfs is the conventional interface for "offlining" a
resource, that is, getting Linux to stop using it.  That's what is
used for cpu online/offline (and memory as well, I think).  Releasing
a resource to the hypervisor's control is necessarily a
platform-specific operation; on pseries a userspace utility calls a
set of RTAS methods to accomplish this.
