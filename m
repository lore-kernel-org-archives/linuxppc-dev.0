Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8767DDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:13:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9N0D9Z0007420
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 20:13:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9N0D9Q2086212
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 18:13:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9N0D8m5028405
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 18:13:09 -0600
Date: Mon, 22 Oct 2007 19:13:07 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/7] pci: Export the pci_restore_msi_state() function
Message-ID: <20071023001307.GF4280@austin.ibm.com>
References: <1192829817.22064.559.camel@teletran1>
	<20071021.162131.43417026.davem@davemloft.net>
	<1193017764.10318.17.camel@concordia>
	<20071022181336.GC4280@austin.ibm.com>
	<1193088267.6745.108.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193088267.6745.108.camel@pasglop>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, mchan@broadcom.com,
	linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 07:24:27AM +1000, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2007-10-22 at 13:13 -0500, Linas Vepstas wrote:
> > On Mon, Oct 22, 2007 at 11:49:24AM +1000, Michael Ellerman wrote:
> > > 
> > > On pseries there's a chance it will work for PCI error recovery, but if
> > > so it's just lucky that firmware has left everything configured the same
> > > way. 
> > 
> > ? The papr is quite clear that i is up to the OS to restore the msi
> > state after an eeh error.
> 
> Via direct config space access or via firmware change-msi calls ?

Direct config space access. It says that the OS is supposed to read the
MSI config (after its been set up), save it, and restore it, (via direct
config space writes) if the device is ever reset.

> I don't know why you keep talking about powerpc laptops here ... 

Well, there are Apple laptops, right?  Aren't those the "powermac" 
platform?  Now, I don't know if they support MSI, but if they do,
I get the impression that they might not restore msi state correctly,
after being put into hardware suspend.  But perhaps I'm mistaken;
I was simply grepping for various msi-related functions in various
arch subdirectories, comparing x86 to other arches, and noticed 
that code that would restore msi state seems to be missing for
most arches and most powerpc platforms.

--linas
