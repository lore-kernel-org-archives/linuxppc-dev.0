Message-ID: <382FD386.5BCEBF84@agelectronics.co.uk>
Date: Mon, 15 Nov 1999 09:33:58 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: "David W. Patmore" <dwp@bluesteelnet.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 + Linux + PCI device + x86 driver = 0
References: <NDBBKOPFGLPEGICBJFDIAEDMCCAA.dwp@bluesteelnet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David W. Patmore" wrote:
[snip]
> The original x86 (Redhat 6.0) driver uses virt_to_bus() to get the address
> to write to.  In LinuxPPC, that function is not available (not in name
> table).  I guess that I'm supposed to use ioremap(), but that doesn't seem
> to do it for me either.

You should include <asm/io.h>. But virt_to_bus(), phys_to_virt(), and
their relatives, only apply to RAM.

> Code snip:
>         ul_reg_addr = p_dev->base_address[0];
> 
>         pul_remapped =ioremap( ul_reg_addr, 32 );
> 
>         printk( "pcidrv: base addr %08X \n", ul_reg_addr );
>         printk( "pcidrv: pul_remapped %08X \n", pul_remapped );
>         printk( "pcidrv: remapped data: %08X \n", *pul_remapped );
> 
>         iounmap( pul_remapped );

Note that as a general principal of cross platform Linux programming,
the thing returned by ioremap is not a true pointer, and should only be
used with readl(), writel(), etc.

These are not your problem - the problem is most likely the device not
being enabled by the boot firmware. This may mean that 
(1) The PCI fixup code is broken on the G4s.
(2) The device has unusual startup requirements.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
