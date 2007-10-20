Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83D38DDEC4
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 10:46:38 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9K0m3w9027815
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 20:48:03 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9K0kWH5062396
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 20:46:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9K0kLN8013361
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 20:46:22 -0400
Date: Fri, 19 Oct 2007 19:46:10 -0500
To: David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
Subject: [BUG] powerpc does not save msi state [was Re: [PATCH 5/7] pci:
	Export the pci_restore_msi_state() function
Message-ID: <20071020004610.GR29903@austin.ibm.com>
References: <20071019232926.GL29903@austin.ibm.com>
	<1192840577.5369.9.camel@dell>
	<20071020000421.GO29903@austin.ibm.com>
	<20071019.172706.57467960.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019.172706.57467960.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	mcarlson@broadcom.com, mchan@broadcom.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Oct 19, 2007 at 05:27:06PM -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Fri, 19 Oct 2007 19:04:21 -0500
> 
> > I'm working in linux-2.6.23-rc8-mm1 at the moment, and I don't see
> > that happening. viz. read_msi_msg() is not called anywhere, and I need
> > to have valid msg->address_lo and msg->address_hi and msg->data
> > in order to be able to restore.
> 
> See the pci_restore_msi_state() call done from pci_restore_state()
> in drivers/pci/pci.c, that pci_restore_msi_state() code in
> drivers/pci/msi.c very much relies upon the entry->msg values
> being uptodate and valid.
> 
> The MSI arch layer code is supposed to fill the entry->msg values in
> via arch_setup_msi_irq().  Perhaps the pseries code is forgetting to
> do that.

Yep.  Thank you for confirming the correct location for the fix.

FWIW, it looks like not all that many arches do this; the output
for grep -r address_hi * is pretty thin. Then, looking at
i386/kernel/io_apic.c as an example, one can see that the 
msi state save happens "by accident" if CONFIG_SMP is enabled;
and so its surely broekn on uniprocesor machines.

I'm cc'ing the powerpc mailing list to point this out: 
it looks like only cell/axon_msi.c and mpic_u3msi.c 
bother do do anything.  I guess that there aren't any old 
macintosh laptops that have msi on them? Because without
this, suspend and resume breaks.

Paul,
On the off chance your reading this, I'll send a pseries
patch on Monday, with luck (and some other patches too).
I'm not touching any of the other plaforms, you and benh 
would know those better.

--linas
