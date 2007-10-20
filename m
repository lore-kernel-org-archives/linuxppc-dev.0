Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 119C9DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 10:53:00 +1000 (EST)
Date: Fri, 19 Oct 2007 17:53:08 -0700 (PDT)
Message-Id: <20071019.175308.54212640.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [BUG] powerpc does not save msi state [was Re: [PATCH 5/7]
	pci: Export the pci_restore_msi_state() function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071020004610.GR29903@austin.ibm.com>
References: <20071020000421.GO29903@austin.ibm.com>
	<20071019.172706.57467960.davem@davemloft.net>
	<20071020004610.GR29903@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

From: linas@austin.ibm.com (Linas Vepstas)
Date: Fri, 19 Oct 2007 19:46:10 -0500

> FWIW, it looks like not all that many arches do this; the output
> for grep -r address_hi * is pretty thin. Then, looking at
> i386/kernel/io_apic.c as an example, one can see that the 
> msi state save happens "by accident" if CONFIG_SMP is enabled;
> and so its surely broekn on uniprocesor machines.

I don't see this, in all cases write_msi_msg() will transfer
the given "*msg" to entry->msg by this assignment in
drivers/pci/msi.c:

void write_msi_msg(unsigned int irq, struct msi_msg *msg)
{
 ...
	entry->msg = *msg;
}

So as long as write_msi_msg() is invoked, it will be saved
properly.

Platforms need not do this explicitly.
