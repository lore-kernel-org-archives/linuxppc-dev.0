Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3A39DDDE6
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 03:57:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RHv1mt023801
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 13:57:01 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RHv0mF558950
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 13:57:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RHv085018121
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 13:57:00 -0400
Date: Thu, 27 Sep 2007 12:56:59 -0500
To: Michael Chan <mchan@broadcom.com>,
	linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linuxppc-dev@ozlabs.org
Subject: Re: tg3: PCI error recovery
Message-ID: <20070927175659.GG7970@austin.ibm.com>
References: <1189123415.17449.52.camel@teletran1>
	<20070925220334.GR5327@austin.ibm.com>
	<1190850518.25892.5.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1190850518.25892.5.camel@dell>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Matt Carlson <mcarlson@broadcom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


During a private conversation about how to save and restore 
device state after a pci error is detected, and the device is reset,
the following came up:

On Wed, Sep 26, 2007 at 04:48:38PM -0700, Michael Chan wrote:
> > 
> > > 1b) If so, is it safe to call pci_save_state() in
> > > tg3_io_error_detected(), or are we to assume they've been corrupted?
> > 
> > My conservative approach is to assume that anything and everything has
> > been corrupted. (e.g. temporary undervoltage on the bus might scramble
> > multiple registers)
> 
> In that case, we should call pci_restore_msi_state() to restore the MSI
> state, but this call is only defined if CONFIG_PM is defined.

There seem to be two choices:
1) enable CONFIG_PM in those arches that care about recovering from PCI
   errors. (Yuck)

2) remove the ifdef CONFIG_PM from around pci_restore_msi_state() in 
   rivers/pci/msi.c

I'd go for choice 2, but I thought I'd ask first ...

--linas
