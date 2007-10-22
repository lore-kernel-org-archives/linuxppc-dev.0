Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F32ADDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 05:54:57 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9MJsr0q017954
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 15:54:53 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9MJsrBr101382
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 13:54:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9MJsqJS001414
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 13:54:52 -0600
Date: Mon, 22 Oct 2007 14:54:52 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [BUG] powerpc does not save msi state [was Re: [PATCH 5/7] pci:
	Export the pci_restore_msi_state() function
Message-ID: <20071022195451.GE4280@austin.ibm.com>
References: <20071020000421.GO29903@austin.ibm.com>
	<20071019.172706.57467960.davem@davemloft.net>
	<20071020004610.GR29903@austin.ibm.com>
	<20071019.175308.54212640.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019.175308.54212640.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com, linuxppc-dev@ozlabs.org,
	mchan@broadcom.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 05:53:08PM -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Fri, 19 Oct 2007 19:46:10 -0500
> 
> > FWIW, it looks like not all that many arches do this; the output
> > for grep -r address_hi * is pretty thin. Then, looking at
> > i386/kernel/io_apic.c as an example, one can see that the 
> > msi state save happens "by accident" if CONFIG_SMP is enabled;
> > and so its surely broekn on uniprocesor machines.
> 
> I don't see this, in all cases write_msi_msg() will transfer
> the given "*msg" to entry->msg by this assignment in
> drivers/pci/msi.c:
> 
> void write_msi_msg(unsigned int irq, struct msi_msg *msg)
> {
>  ...
> 	entry->msg = *msg;
> }
> 
> So as long as write_msi_msg() is invoked, it will be saved
> properly.

As Michael Ellerman points out, the pseries msi setup is done
by firmware, and so this bit never happens. 

As discussed in the other thread, I'll try to set up a patch
for an arch callback for restoring msi state.

-linas
