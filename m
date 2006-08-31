Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E02367B6E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2006 03:50:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7VHo3gQ004160
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 13:50:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7VHo3vI278222
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 11:50:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7VHo2HE000344
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 11:50:02 -0600
Date: Thu, 31 Aug 2006 12:50:01 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060831175001.GE8704@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Yanmin Zhang <yanmin.zhang@intel.com>,
	inux-kernel@vger.kernel.org, Rajesh Shah <rajesh.shah@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 31, 2006 at 03:10:12PM +0800, Zhang, Yanmin wrote:
> Linas,
> 
> I am reviewing the error handlers of e1000 driver and got some ideas. My
> startpoint is to simplify the err handler implementations for drivers, or
> driver developers are *not willing* to add it if it's too complicated.

I don't see that its to complicated ... 

> 1) Callback mmio_enabled looks useless. Documentation/pci-error-recovery.txt
> says the current powerpc implementation does not implement this callback.

I don't know if its useless or not. I have not needed it yet for the
symbios, ipr and e1000 drivers, but its possible that some more
sophisticated device may want it. I'm tempted to keep it a while 
longer befoe discarding it.

The scenario is this: the device driver decides that, rather than asking
for a full electical reset of the card, instead, it wants to perform 
its own recovery. It can do this as follows:

a) enable MMIO
b) issue reset command to adapter
c) enable DMA.

If we enabled both DMA and MMIO at the same time, there are mnay cases
where the card will immediately trap again -- for example, if its
DMA'ing to some crazy address. Thus, typically, one wants DMA disabled 
until after the card reset.  Withouth the mmio_enabled() reset, there
is no way of doing this.

> 2) Callback slot_reset could be merged with resume. The new resume could be:
> int (*error_resume)(struct pci_dev *dev); I checked e1000 and e100 drivers and
> think there is no actual reason to have both slot_reset and resume.

The idea here was to handle multi-function cards.  On a multi-function card, 
*all* devices need to indicate that they were able to reset. Once all devices 
have been successfuly reset, then operation can be resumed. If the reset 
of one function fails, then operation is not resumed for any f the
functions.

> 3) link_reset is not used in pci express aer implementation, so it could be
> deleted also.

OK. Link reset was added explicitly to support PCI-E, so if its not wanted,
we can eliminate it.

> How did you test e1000 err_handler? 

We have three methods (I thought these were documented). In one, a
technician brushes a grounding strap to some of the signal pins. 
In the second, slots are populated with known-bad cards. The third test
involes sending a command down to the pci bridge chip, telling it to 
behave as if it detected an error. For development, the last is
quick-n-easy.

> In the simulated enviroment, the testing might be
> incorrect. 

Why would it be incorrect?  I mean, we don't simulate having someone pour a
cup of coffee into the guts of the machine ... but my understanding is
the machines do get standard vibration/thermal/humidity testing, which
is good enough for me.

> For example, e1000_io_error_detected would call e1000_down to reset NIC. 

Why would that be incorrect?

> During
> our last discussion on LKML, you said PowerPC will block further I/O if the platform captures
> a pci error, so the all I/O in e1000_down will be blocked. Later on, e1000_io_slot_reset
> will reenable pci device and initiate NIC. I guess late initiate might fail because prior
> e1000_down I/O don't reach NIC.

Why would it fail? The e1000_down serves primarily to get the Linux
kernel into a known state. It doesn't matter what happens to the card,
since the next step will be to perform an electrical reset of the card.

--linas
