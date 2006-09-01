Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5112767B79
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Sep 2006 07:32:57 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k81LWrDW029675
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2006 17:32:53 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k81LWr6Y254374
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2006 17:32:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k81LWql9004553
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2006 17:32:53 -0400
Date: Fri, 1 Sep 2006 16:32:51 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060901213251.GT8704@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157082169.20092.174.camel@ymzhang-perf.sh.intel.com>
	<1157101449.20092.180.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157101449.20092.180.camel@ymzhang-perf.sh.intel.com>
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

On Fri, Sep 01, 2006 at 05:04:09PM +0800, Zhang, Yanmin wrote:
> One more comment: The second parameter of error_detected also could be deleted
> because recovery procedures will save error to pci_dev->error_state.

Yes, I beleive so.

> So, the err_handler pci_error_handlers could be:
> struct pci_error_handlers
> {
>         pci_ers_result_t (*error_detected)(struct pci_dev *dev);
>         pci_ers_result_t (*error_resume)(struct pci_dev *dev);
> };

No, as per other email, we still need a multi-step process for
multi-function cards, and for cards that may not want to get
a full electrical reset. Finally, there might be platforms 
that cannot perform a per-slot electrical reset, and would 
therefore require drivers that can recover on thier own.

--linas
