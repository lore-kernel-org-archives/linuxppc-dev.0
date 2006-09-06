Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE78667BDC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 06:02:07 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k86K24Tc025238
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 16:02:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k86K24qt224152
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 14:02:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k86K1wtt002890
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 14:02:03 -0600
Date: Wed, 6 Sep 2006 15:01:55 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060906200155.GL7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<1157360592.22705.46.camel@localhost.localdomain>
	<1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
	<20060905190115.GE7139@austin.ibm.com>
	<1157506016.20092.386.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157506016.20092.386.camel@ymzhang-perf.sh.intel.com>
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

On Wed, Sep 06, 2006 at 09:26:56AM +0800, Zhang, Yanmin wrote:
> > > The
> > > error_detected of the drivers in the latest kernel who support err handlers
> > > always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.
> > 
> > Just because the current drivers do it this way does not mean that this is
> > the best way to do things.
>
> If it's not the best way, why did you choose to reset slot for e1000/e100/ipr
> error handlers? They are typical widely-used devices. To make it easier to
> add error handlers?

I did it that way just to get going, get something working. I do not
have hardware specs for any of these devices, and do not have much of 
an idea of what they are capable of; the recovery code I wrote is of
"brute force, hit it with a hammer"-nature.  Driver writers who 
know thier hardware well, and are interested in a more refined 
approach are encouraged to actualy use a more refined approach.

--linas
