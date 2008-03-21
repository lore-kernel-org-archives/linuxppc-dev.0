Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 201F1DDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 16:14:54 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so299048anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 22:14:52 -0700 (PDT)
Message-ID: <fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
Date: Thu, 20 Mar 2008 23:14:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olaf Hering" <olaf@aepfle.de>, "Paul Mackerras" <paulus@samba.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: crash in init_ipic_sysfs on efika
In-Reply-To: <20080317195305.GA13298@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317195305.GA13298@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 1:53 PM, Olaf Hering <olaf@aepfle.de> wrote:
>
>  I cant reproduce this bug on my board, but:
>
>  The global primary_ipic in arch/powerpc/sysdev/ipic.c can remain NULL if
>  ipic_init() fails. init_ipic_sysfs() will crash in that case.
>
>  Something like this may fix it:
>
>  Index: linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
>  ===================================================================
>  --- linux-2.6.25-rc6.orig/arch/powerpc/sysdev/ipic.c
>  +++ linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
>  @@ -906,7 +906,7 @@ static int __init init_ipic_sysfs(void)
>   {
>         int rc;
>
>  -       if (!primary_ipic->regs)
>  +       if (!primary_ipic || !primary_ipic->regs)
>                 return -ENODEV;
>         printk(KERN_DEBUG "Registering ipic with sysfs...\n");

Confirmed, this patch fixes the problem.  Paulus or Kumar, can you
please pick it up for .25?

Thanks,
g.

>
>
>
>  ok boot eth:192.168.2.52,inst32 inst32 console=ttyPSC0,115200
>
>  SuSE Linux zImage starting: loaded at 00040000-00d24cbc (0/0/01003ed8;
>  sp: 017ffe80)
>  uncompressing ELF header done. (00000100 bytes)
>  Allocated 008584d4 bytes for kernel @ 02000000
>  Allocated 00a963a2 bytes for initrd @ 02859000
>  uncompressing kernel done. (004faeb8 bytes)
>  entering kernel at 02010000(2859000/a963a2/01003ed8)
>  OF stdout device is: /failsafe
>  command line: console=ttyPSC0,115200
>  memory layout at init:
>   alloc_bottom : 032f0000
>   alloc_top    : 30000000
>   alloc_top_hi : f000c000
>   rmo_top      : 30000000
>   ram_top      : f000c000
>  Looking for displays
>  instantiating rtas at 0x07ffb000 ... done
>  Applying EFIKA device tree fixups
>  Fixing bestcomm interrupts property
>  Adding Ethernet MDIO node
>  Adding Ethernet PHY node
>  copying OF device tree ...
>  Building dt strings...
>  Building dt structure...
>  Device tree strings 0x032f1000 -> 0x032f17e0
>  Device tree struct  0x032f2000 -> 0x03315000
>  Calling quiesce ...
>  returning from prom_init
>  Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
>  Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>  Memory: 113264k/131072k available (4808k kernel code, 17648k reserved,
>  164k data, 461k bss, 228k init)
>  Security Framework initialized
>  AppArmor: AppArmor initialized
>  AppArmor: Unable to log event (1505) to audit subsys
>  AppArmor: Registered secondary security module name="capability"
>  AppArmor: Unable to log event (1505) to audit subsys
>  Capability LSM initialized as secondary
>  Failure registering Root Plug module with the kernel
>  AppArmor: Unable to register %s as a secondary security module
>  name="root_plug"
>  AppArmor: Unable to log event (1505) to audit subsys
>  Failure registering Root Plug  module with primary security module.
>  Mount-cache hash table entries: 512
>  net_namespace: 544 bytes
>  NET: Registered protocol family 16
>  PCI: Probing PCI hardware
>  DMA: MPC52xx BestComm driver
>  DMA: MPC52xx BestComm engine @f0001200 ok !
>  Unable to handle kernel paging request for data at address 0x00000000
>  Faulting instruction address: 0xc0486aac
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  Efika
>  Modules linked in:
>  NIP: c0486aac LR: c0479200 CTR: c0486a90
>  REGS: c782bea0 TRAP: 0300   Not tainted  (2.6.25-rc5-git2-5-default)
>  MSR: 00009032 <EE,ME,IR,DR>  CR: 44002082  XER: 20000000
>  DAR: 00000000, DSISR: 20000000
>  TASK = c78237c0[1] 'swapper' THREAD: c782a000
>  GPR00: c0479200 c782bf50 c78237c0 ffffffed 00000003 00000000 00000000
>  00000000
>  GPR08: fffffffc 00000000 c7800780 000f06a0 22002022 dffffff7 c0405540
>  c0405558
>  GPR16: c0405568 c040558c c0405594 c04055a4 c04055d0 c0400000 024184a4
>  ffffffff
>  GPR24: 00000000 c04a6468 c0405550 c782a000 c04e0000 00000000 00000000
>  c04af198
>  NIP [c0486aac] init_ipic_sysfs+0x1c/0x90
>  LR [c0479200] kernel_init+0xf8/0x2a0
>  Call Trace:
>  [c782bf50] [c04869fc] mpc52xx_bcom_init+0x24/0x34 (unreliable)
>  [c782bf60] [c0479200] kernel_init+0xf8/0x2a0
>  [c782bff0] [c001330c] kernel_thread+0x44/0x60
>  Instruction dump:
>  80010024 bb61000c 38210020 7c0803a6 4e800020 9421fff0 7c0802a6 3d20c04f
>  3860ffed 90010014 93e1000c 81299730 <80090000> 2f800000 41be0058 3c60c041
>  ---[ end trace 8640abe69a316dee ]---
>  Kernel panic - not syncing: Attempted to kill init!
>  Rebooting in 180 seconds..
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
