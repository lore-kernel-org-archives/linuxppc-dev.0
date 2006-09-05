Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65B2267BB6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 05:01:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k85J1J4F032121
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 15:01:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k85J1H6s029858
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 13:01:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k85J1GkS019243
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 13:01:16 -0600
Date: Tue, 5 Sep 2006 14:01:15 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060905190115.GE7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<1157360592.22705.46.camel@localhost.localdomain>
	<1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Yanmin Zhang <yanmin.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linuxppc-dev@ozlabs.org,
	linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 05, 2006 at 10:32:08AM +0800, Zhang, Yanmin wrote:
> Is it the exclusive reason to have multi-steps?

I don't understand the question. A previous email explained the reason
to have mutiple steps.

> 1) Here link reset and hard reset are hardware operations, not the
> link_reset and slot_reset callback in pci_error_handlers.

I don't understand the comment.

> 2) Callback error_detected will notify drivers there is PCI errors. Drivers
> shouldn't do any I/O in error_detected.

It shouldn't matter. If it is truly important for a particular platform
to make sure that there is no i/o, then the low-level i/o routines
could be modified to drop any accidentally issued i/o on the floor.
This doesn't require a change to either the API or the policy.

> 3) If both the link and slot are reset after all error_detected are called,
> the device should go back to initial status and all DMA should be stopped
> automatically. Why does the driver still need a chance to stop DMA? 

As explained previously, not all drivers may want to have a full
electrical device reset.

> The
> error_detected of the drivers in the latest kernel who support err handlers
> always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.

Just because the current drivers do it this way does not mean that this is
the best way to do things. A full reset is time-consuming. Some drivers
may want to implement a faster and quicker reset.

--linas
