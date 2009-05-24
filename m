Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 917C7DE031
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 16:48:11 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1266385yxb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 23:48:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 24 May 2009 00:47:50 -0600
Message-ID: <fa686aa40905232347t57187d0fv51c714bfe6dd40d9@mail.gmail.com>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ilya, any comment on this?  Can a fix be made quickly, or should this
patch be reverted until a more robust version can be crafted?

g.

On Thu, May 21, 2009 at 10:50 AM, Albert Herranz
<albert_herranz@yahoo.es> wrote:
>
> Hello list,
>
> Commit 33f00dcedb0e22cdb156a23632814fc580fcfcf8 seems to have broken DMA =
coherent allocations for CONFIG_NOT_COHERENT_CACHE platforms.
>
> The problems seem to be that the new __dma_alloc_coherent() and __dma_fre=
e_coherent() implementations:
>
> - don't respect anymore the passed gfp flags (__dma_alloc_coherent() unco=
nditionally uses GFP_KERNEL within the function irrespective of the caller =
flags)
> - can't be used in interrupt context as they use get_vm_area_caller()/vfr=
ee() which end up triggering BUG_ON(in_interrupt())
>
> One victim happens to be the USB core subsystem which sometimes frees dma=
 coherent memory in interrupt context for drivers flagged HCD_LOCAL_MEM.
>
> This has been experienced while writing a new EHCI driver for the Nintend=
o Wii platform.
>
> usb 1-1: new high speed USB device using ehci-mipc and address 2
> ------------[ cut here ]------------
> kernel BUG at mm/vmalloc.c:1328!
> Oops: Exception in kernel mode, sig: 5 [#1]
> PREEMPT wii
> Modules linked in:
> NIP: c008ea20 LR: c0015890 CTR: c00111d4
> REGS: d2c65b10 TRAP: 0700 =A0 Not tainted =A0(2.6.30-rc2-isobel-wii-00092=
-gcba94db-dirty)
> MSR: 00021032 <ME,CE,IR,DR> =A0CR: 42482028 =A0XER: 00000000
> TASK =3D d2c600f0[28] 'kmmcd' THREAD: d2c64000
> GPR00: 00010000 d2c65bc0 d2c600f0 d4030000 d4030000 d4030000 12da1000 000=
00001
> GPR08: 00000000 d2c64000 00000020 00000000 22482022 94fdfb98 6e1979bc c6b=
bdbdd
> GPR16: 00000020 00200200 00100100 d4020060 00000001 d401c0ec 00000001 d40=
1c0ec
> GPR24: d2d9a6c0 00000000 00000000 d2f69de0 d2d9a600 d2f69e30 d2f69e2c d2d=
a08e0
> NIP [c008ea20] vfree+0xc/0x18
> LR [c0015890] __dma_free_coherent+0x14/0x24
> Call Trace:
> [d2c65bc0] [c0017af8] __mipc_recv_req+0x160/0x178 (unreliable)
> [d2c65bd0] [c00111ec] dma_direct_free_coherent+0x18/0x28
> [d2c65be0] [c01cfca4] hcd_free_coherent+0x7c/0x12c
> [d2c65c10] [c01d00b8] unmap_urb_for_dma+0x150/0x1cc
> [d2c65c20] [c01d0174] usb_hcd_giveback_urb+0x40/0xe4
> [d2c65c30] [c01df474] ehci_urb_done+0xf0/0x114
> [d2c65c50] [c01e3870] qh_completions+0x41c/0x4dc
> [d2c65ca0] [c01e44e0] scan_async+0x9c/0x1a0
> [d2c65cc0] [c01e49ec] ehci_work+0x58/0xc4
> [d2c65cd0] [c01e5424] ehci_irq+0x22c/0x230
> [d2c65d00] [c01cfa88] usb_hcd_irq+0x50/0xa8
> [d2c65d20] [c00597d8] handle_IRQ_event+0xdc/0x250
> [d2c65d60] [c005ba20] handle_level_irq+0x9c/0x138
> [d2c65d80] [c001cbc8] hollywood_pic_irq_cascade+0x7c/0xf8
> [d2c65da0] [c00064b4] do_IRQ+0x9c/0xc4
> [d2c65dc0] [c0011fb8] ret_from_except+0x0/0x14
>
> Any comments on how to address this issue (other than reverting the above=
 mentioned commit, which fixes it) are welcome.
>
> Thanks,
> Albert
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
