Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E87967B32
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 05:39:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8CJcxGS007703
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 15:38:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8CJcx1w296438
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 15:38:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8CJcwwX009741
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 15:38:58 -0400
Date: Tue, 12 Sep 2006 14:38:57 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060912193857.GB29167@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<20060905191739.GF7139@austin.ibm.com>
	<1157508270.20092.426.camel@ymzhang-perf.sh.intel.com>
	<20060906203939.GM7139@austin.ibm.com>
	<1157599136.20092.529.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157599136.20092.529.camel@ymzhang-perf.sh.intel.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org,
	linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
	Yanmin Zhang <yanmin.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Rajesh Shah <rajesh.shah@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2006 at 11:18:56AM +0800, Zhang, Yanmin wrote:
> The error recovery procedures
> are to process pci hardware errors instead of device driver bug.

Over the last three years, we've uncovered (and fixed) dozens of 
device driver bugs that were only detected because of the pci error
detection hardware.  The ability to get device dumps is important,
because many of these bugs are hard to reproduce, require getting
PCI bus analyzers attached to the system, etc.

> Current error handler infrastructure could support pci-e, but I want a better
> solution to faciliate driver developers to add error handlers more easily. My
> startpoint is driver developer. If they are not willing to add error handlers,
> it's impossible to do so for all drivers by you and me.

Right. As a result, we only care about the products that we actually 
sell to customers. PCI error recovery is not some "gee its nice" piece
of eye-candy or chrome: either one is serious about high-availability,
or one is not.

--linas
