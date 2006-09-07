Return-Path: <yanmin_zhang@linux.intel.com>
Received: from orsmga101.jf.intel.com (mga06.intel.com [134.134.136.21])
	by ozlabs.org (Postfix) with ESMTP id 0765A67B6F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 11:58:13 +1000 (EST)
Subject: Re: pci error recovery procedure
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060906200155.GL7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<1157360592.22705.46.camel@localhost.localdomain>
	<1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
	<20060905190115.GE7139@austin.ibm.com>
	<1157506016.20092.386.camel@ymzhang-perf.sh.intel.com>
	<20060906200155.GL7139@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1157594179.20092.451.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Date: Thu, 07 Sep 2006 09:56:19 +0800
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

On Thu, 2006-09-07 at 04:01, Linas Vepstas wrote:
> On Wed, Sep 06, 2006 at 09:26:56AM +0800, Zhang, Yanmin wrote:
> > > > The
> > > > error_detected of the drivers in the latest kernel who support err handlers
> > > > always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.
> > > 
> > > Just because the current drivers do it this way does not mean that this is
> > > the best way to do things.
> >
> > If it's not the best way, why did you choose to reset slot for e1000/e100/ipr
> > error handlers? They are typical widely-used devices. To make it easier to
> > add error handlers?
> 
> I did it that way just to get going, get something working. I do not
> have hardware specs for any of these devices, and do not have much of 
> an idea of what they are capable of;
Yes, it's difficult to add fine-grained error handlers for guys who are not
the driver developers.

>  the recovery code I wrote is of
> "brute force, hit it with a hammer"-nature.  Driver writers who 
> know thier hardware well, and are interested in a more refined 
> approach are encouraged to actualy use a more refined approach.
I guess almost no driver developer is happy to spend lots of time to
add refined steps. They would like to focus on normal process (for achievement
feeling? :) ).
In addition, if they use fine-grained steps in error handlers, all these
steps might be rewritten when the device specs is upgraded. Fine-grained steps in
error handlers are more difficut to debug.

It's impossible for you to develop error handlers for all device drivers.

The error handlers look a little like suspend/resume. Of course, it's more
complicated. If we could keep it as simple as suspend/resume, it's more welcomed.

pci error shouldn't happen frequently. And when it happens, I think mostly it's
an endpoint device instead of bridge. When it happens, if we choose always
reset slot, performance could be degraded, but not too much. I just deduce, and 
didn't test it on a machine with hundreds of devices.
