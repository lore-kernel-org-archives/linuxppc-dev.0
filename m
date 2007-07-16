Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01149DE2FD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 01:40:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6GFeG54021057
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 11:40:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6GFeEuN109498
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 09:40:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6GFeEMa007357
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 09:40:14 -0600
Subject: Re: hvc_iseries not working
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070713170540.GA1987@aepfle.de>
References: <20070713170540.GA1987@aepfle.de>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 10:39:16 -0500
Message-Id: <1184600356.22547.121.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-13 at 19:05 +0200, Olaf Hering wrote:
> 2.6.21 arch/powerpc/configs/iseries_defconfig works on an i825 with v5r4
> 2.6.22 arch/powerpc/configs/iseries_defconfig does not. But it works on
> a i820 with v5r3.
> 2.6.22 boots ok with CONFIG_VIOCONS

When it works, do you have more than one processor assigned to the
partition?   

I noticed something similar last last week.  What I've narrowed down so
far, is that it only fails in a single-processor partition, (dedicated
or shared doesnt matter).  if I assign another proc,  the partition
boots as expected. 

turning on initcall_debug, output to the console stops after we get as
far as hvc_vio_init().   

a small sampling of register dumps show us in these places: 
	put_chars() calling spin_lock_irqsave()
	put_chars() calling vio_get_event_buffer()
	put_chars() calling vio_free_event_buffer()
	spin_unlock_irqrestore() calling local_irq_restore()
	



> 
> It gets up to this point:
> 
> vio_bus_init: processing c0000000fbfff570
> vio_bus_init: processing c0000000fbfff6b0
> vio_bus_init: processing c0000000fbfff7f0
> vio_bus_init: processing c0000000fbfff930
> vio_bus_init: processing c0000000fbfffa70
> vio_bus_init: processing c0000000fbfffbb0
> audit: initializing netlink socket (disabled)
> audit(1184327881.720:1): initialized
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> viopath: opening connection to partition 0, setting sinst 32778, tinst 32769
> hvc: hosting partition 0
> vio_register_driver: driver hvc_console registering
> Generic RTC Driver v1.07
> RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blo
> 
> 
> with ppc64_defconfig it looks like that:
> 
> 
> audit: initializing netlink socket (disabled)
> audit(1184326841.030:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
> rpadlpar_io_init: partition not DLPAR capable
> HVSI: registered 0 devices
> viopath: opening connection to partition 0, setting sinst 32774, tinst 32769
> hvc: hosting partition 0
> vio_register_driver: driver hvc_console registering
> Generic RTC Driver v1.07
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
