Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 40A766883E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 08:41:19 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Demke Torsten-atd012'" <torsten.demke@motorola.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Fri, 25 Nov 2005 22:41:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <TMNT04vAauNjVuMhvqg000000ab@tmnt04.transmode.se>
Subject: RE: Badness in 2.6.15-rc1 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > 
> > -----Original Message----- 
> > From: linuxppc-embedded-bounces@ozlabs.org 
> > [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of 
> > Joakim Tjernlund 
> > Sent: Freitag, 25. November 2005 14:28 
> > To: linuxppc-embedded@ozlabs.org 
> > Subject: Badness in 2.6.15-rc1 on 8xx 
> > 
> > Anyone seen this when booting 2.6.15-rc1 on 8xx? 
> >   Mount-cache hash table entries: 512 
> >   Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:346 
> >   Call trace: 
> >    [c00039e8] check_bug_trap+0x80/0xa8 
> >    [c0003c1c] program_check_exception+0x20c/0x480 
> >    [c00031e0] ret_from_except_full+0x0/0x4c 
> >    [c01b86b8] dma_alloc_init+0x40/0xcc 
> >    [c000225c] init+0x8c/0x288 
> >    [c00050ac] kernel_thread+0x44/0x60 
> >   NET: Registered protocol family 16 
> > The kernel boots just fine into user space so it seems 
> > harmless, but I suspect it will bite me later. 
> > 
> > Something anoying: 
> > Why did the new cpm_uart driver change major and minor number 
> > for the tty? 
> > As it is now I can't boot my 2.4 rootfs as init think it 
> > should find the console on ttyS0. 
> > Would be great if major and minor could be configurable. 
> Because it's a new driver...with a new name (ttyCPM0) and a new 
> device number. It shared the device number and name in 2.4 
> with the "standard" device driver (8250/16550), and that made 
> it very difficult to use both in 2.4. 

To me it makes more sense to let a major number represent a function, not a driver.
Shouldn't be that hard to make these drivers cooperate wrt. minor number.

To allow for easy customization one could instead do:
#ifndef SERIAL_CPM_MAJOR
#define SERIAL_CPM_MAJOR        204
#endif
#ifndef SERIAL_CPM_MINOR
#define SERIAL_CPM_MINOR        46
#endif

Each platform could then define major and minor as they like.

 Jocke
  
> Maybe you should use console=ttyCPM0 in your boot parameters for 2.6. 
> 
> Regards, 
> Torsten 
> > 
> >   Jocke 
