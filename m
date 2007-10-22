Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A522FDDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 04:13:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9MIDhDC029066
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 14:13:43 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9MIDc6R052488
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 12:13:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9MIDbku023073
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 12:13:38 -0600
Date: Mon, 22 Oct 2007 13:13:37 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/7] pci: Export the pci_restore_msi_state() function
Message-ID: <20071022181336.GC4280@austin.ibm.com>
References: <1192829817.22064.559.camel@teletran1>
	<20071021.162131.43417026.davem@davemloft.net>
	<1193017764.10318.17.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193017764.10318.17.camel@concordia>
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

On Mon, Oct 22, 2007 at 11:49:24AM +1000, Michael Ellerman wrote:
> 
> On pseries there's a chance it will work for PCI error recovery, but if
> so it's just lucky that firmware has left everything configured the same
> way. 

? The papr is quite clear that i is up to the OS to restore the msi
state after an eeh error.

> Yes I think so. That way we can properly reconfigure via the firmware
> interface. The other option would be to design some new arch hook to do
> resume, but just doing a disable/enable seems simpler to me.

Err, If you read the code for suspend/resume, it never actually calls
disable/enable (and thus doesn't go to the firmware); it calls 
restore_msi_state() function!

If suspend/resume needs to call firmware to restore the state, then,
at the moment, suspend/resume is broken.  As I mentioned earlier,
I presumed that no powerpc laptops currently use msi-enabled devices,
as otherwise, this would have been flushed out.

--linas
