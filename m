Return-Path: <albert_herranz@yahoo.es>
Received: from web28305.mail.ukl.yahoo.com (web28305.mail.ukl.yahoo.com
	[87.248.110.124]) by ozlabs.org (Postfix) with SMTP id 15F50DE057
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 02:57:05 +1000 (EST)
Message-ID: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
Date: Thu, 21 May 2009 16:50:23 +0000 (GMT)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: powerpc: DMA coherent allocations broken for CONFIG_NOT_COHERENT_CACHE
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello list,=0A=0ACommit 33f00dcedb0e22cdb156a23632814fc580fcfcf8 seems to h=
ave broken DMA coherent allocations for CONFIG_NOT_COHERENT_CACHE platforms=
.=0A=0AThe problems seem to be that the new __dma_alloc_coherent() and __dm=
a_free_coherent() implementations:=0A=0A- don't respect anymore the passed =
gfp flags (__dma_alloc_coherent() unconditionally uses GFP_KERNEL within th=
e function irrespective of the caller flags)=0A- can't be used in interrupt=
 context as they use get_vm_area_caller()/vfree() which end up triggering B=
UG_ON(in_interrupt())=0A=0AOne victim happens to be the USB core subsystem =
which sometimes frees dma coherent memory in interrupt context for drivers =
flagged HCD_LOCAL_MEM.=0A=0AThis has been experienced while writing a new E=
HCI driver for the Nintendo Wii platform.=0A=0Ausb 1-1: new high speed USB =
device using ehci-mipc and address 2=0A------------[ cut here ]------------=
=0Akernel BUG at mm/vmalloc.c:1328!=0AOops: Exception in kernel mode, sig: =
5 [#1]=0APREEMPT wii=0AModules linked in:=0ANIP: c008ea20 LR: c0015890 CTR:=
 c00111d4=0AREGS: d2c65b10 TRAP: 0700   Not tainted  (2.6.30-rc2-isobel-wii=
-00092-gcba94db-dirty)=0AMSR: 00021032 <ME,CE,IR,DR>  CR: 42482028  XER: 00=
000000=0ATASK =3D d2c600f0[28] 'kmmcd' THREAD: d2c64000=0AGPR00: 00010000 d=
2c65bc0 d2c600f0 d4030000 d4030000 d4030000 12da1000 00000001 =0AGPR08: 000=
00000 d2c64000 00000020 00000000 22482022 94fdfb98 6e1979bc c6bbdbdd =0AGPR=
16: 00000020 00200200 00100100 d4020060 00000001 d401c0ec 00000001 d401c0ec=
 =0AGPR24: d2d9a6c0 00000000 00000000 d2f69de0 d2d9a600 d2f69e30 d2f69e2c d=
2da08e0 =0ANIP [c008ea20] vfree+0xc/0x18=0ALR [c0015890] __dma_free_coheren=
t+0x14/0x24=0ACall Trace:=0A[d2c65bc0] [c0017af8] __mipc_recv_req+0x160/0x1=
78 (unreliable)=0A[d2c65bd0] [c00111ec] dma_direct_free_coherent+0x18/0x28=
=0A[d2c65be0] [c01cfca4] hcd_free_coherent+0x7c/0x12c=0A[d2c65c10] [c01d00b=
8] unmap_urb_for_dma+0x150/0x1cc=0A[d2c65c20] [c01d0174] usb_hcd_giveback_u=
rb+0x40/0xe4=0A[d2c65c30] [c01df474] ehci_urb_done+0xf0/0x114=0A[d2c65c50] =
[c01e3870] qh_completions+0x41c/0x4dc=0A[d2c65ca0] [c01e44e0] scan_async+0x=
9c/0x1a0=0A[d2c65cc0] [c01e49ec] ehci_work+0x58/0xc4=0A[d2c65cd0] [c01e5424=
] ehci_irq+0x22c/0x230=0A[d2c65d00] [c01cfa88] usb_hcd_irq+0x50/0xa8=0A[d2c=
65d20] [c00597d8] handle_IRQ_event+0xdc/0x250=0A[d2c65d60] [c005ba20] handl=
e_level_irq+0x9c/0x138=0A[d2c65d80] [c001cbc8] hollywood_pic_irq_cascade+0x=
7c/0xf8=0A[d2c65da0] [c00064b4] do_IRQ+0x9c/0xc4=0A[d2c65dc0] [c0011fb8] re=
t_from_except+0x0/0x14=0A=0AAny comments on how to address this issue (othe=
r than reverting the above mentioned commit, which fixes it) are welcome.=
=0A=0AThanks,=0AAlbert=0A=0A=0A=0A      
