Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86FC3DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:00:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RM0TKD001360
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 18:00:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RM0Ptm457214
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 16:00:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RM0Nqk027888
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 16:00:23 -0600
Date: Thu, 27 Sep 2007 17:00:22 -0500
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20070927220022.GC18686@austin.ibm.com>
References: <20070420204114.GL31947@austin.ibm.com>
	<20070420204720.GM31947@austin.ibm.com>
	<20070926150216.GH3899@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070926150216.GH3899@parisc-linux.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2007 at 09:02:16AM -0600, Matthew Wilcox wrote:
> On Fri, Apr 20, 2007 at 03:47:20PM -0500, Linas Vepstas wrote:
> > Implement the so-called "first failure data capture" (FFDC) for the
> > symbios PCI error recovery.  After a PCI error event is reported,
> > the driver requests that MMIO be enabled. Once enabled, it 
> > then reads and dumps assorted status registers, and concludes
> > by requesting the usual reset sequence.
> 
> > +	/* Request that MMIO be enabled, so register dump can be taken. */
> > +	return PCI_ERS_RESULT_CAN_RECOVER;
> > +}
> 
> I'm a little concerned by the mention of MMIO.  It's entirely possible
> for the sym2 driver to be using ioports to access the card rather than
> MMIO.  Is it simply that it can't on the platform you test on?

The comment is misleading. I've been in the bad habit of calling
it "mmio" whenever its not DMA.

The habit is because there are two distinct enable bits in the 
pci-host bridge during error recovery: one to enable mmio/ioports, 
and the other to enable DMA. If the adapter has gone crazy, I don't 
want to enable DMA, so that it doesn't scribble to bad places. But, 
by enabling mmio/ioports, perhaps it can be finessed back into a 
semi-sane state, e.g. sane enough to perform a dump of its internal
state.

--linas
