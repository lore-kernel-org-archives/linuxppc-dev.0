Return-Path: <pladow@gmail.com>
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com
 [IPv6:2a00:1450:4010:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C9A62C0394
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2013 02:56:54 +1000 (EST)
Received: by mail-la0-f52.google.com with SMTP id fo12so7449924lab.25
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 09:56:49 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
Date: Fri, 21 Jun 2013 09:56:48 -0700
Message-ID: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
Subject: Inbound PCI and Memory Corruption
From: Peter LaDow <petela@gocougs.wsu.edu>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm posting this to the ppc-dev since I think the problem may be
specific to the PPC kernel.

We are running into a case where we get memory corruption when an
external PCI master writes to the processor.  We are using an MPC8349
with an external Intel 82540EP (an E1000) part.  I've spent several
weeks on the e1000 list trying to track down this problem, and after
some digging I'm thinking the problem is somewhere other than the
e1000 driver or the e1000 part.

We are running 3.0.57-rt82, though I can reliably re-create this
problem with 3.0.80 (vanilla, no preempt).  Basically it involves
bringing down the e1000 interface while it is on an extremely busy
network (i.e. a ton of traffic incoming traffic into the e1000).  From
the kernel panics I've seen, it appears that the incoming traffic is
present in the corrupted memory regions.

I'm suspecting some issue related to the DMA'ing of packet data from
the e1000 into main memory.  I've traced the PCI traffic with a bus
analyzer, and the part stops DMA'ing when disabled, and the driver
disables the part before unmapping the ring buffers (i.e. calls to
dma_unmap_*).

Prior to using the e1000 part, we were using an e100 part (an 82551).
We never experienced this problem, but then again, the driver is
different.  Some initial digging shows that the DMA is setup
different.  The e100 driver uses pci_map_single, but the e1000 driver
uses dma_alloc_coherent.  I don't know much about the guts of the
kernel related to PCI and DMA, but based upon the PCI traces and other
debugging, it seems to point there.

Below is the kernel panic output when the failure occurs.

Does anyone have an idea of where I can look to try and debug this?

Unable to handle kernel paging request for data at address 0x20454a46
 Faulting instruction address: 0xc0069924
 Oops: Kernel access of bad area, sig: 11 [#1]
 PREEMPT PPC Platform
 Modules linked in:
 NIP: c0069924 LR: c021cce0 CTR: c000cecc
 REGS: ed4f1c60 TRAP: 0300   Not tainted  (3.0.80-rt108)
 MSR: 00009032 <EE,ME,IR,DR>  CR: 24008248  XER: 00000000
 DAR: 20454a46, DSISR: 20000000
 TASK = eda46780[3106] 'ifconfig' THREAD: ed4f0000
 GPR00: 00000000 ed4f1d10 eda46780 20454a46 2d6fcc2a 000005f2 00000002 00000000
 GPR08: eda46780 ed6fd228 ed4f1cd0 000090b1 00000000 10084718 bfcceaec 10062044
 GPR16: 10062120 bfcceadc 00000000 bfcceac4 00000228 00000000 00008914 c01ac398
 GPR24: c01ac8c8 ed066520 00000061 ed0663a0 ef0448f0 00000000 00000001 ed575580
 NIP [c0069924] put_page+0x0/0x34
 LR [c021cce0] skb_release_data+0x78/0xc8
 Call Trace:
 [ed4f1d20] [c021c914] __kfree_skb+0x18/0xbc
 [ed4f1d30] [c01a7620] e1000_clean_rx_ring+0x10c/0x1a4
 [ed4f1d60] [c01a76e0] e1000_clean_all_rx_rings+0x28/0x54
 [ed4f1d70] [c01aac50] e1000_close+0x30/0xb4
 [ed4f1d90] [c0226e2c] __dev_close_many+0xa0/0xe0
 [ed4f1da0] [c0228c64] __dev_close+0x2c/0x4c
 [ed4f1dc0] [c0225224] __dev_change_flags+0xb8/0x140
 [ed4f1de0] [c0226d48] dev_change_flags+0x1c/0x60
 [ed4f1e00] [c027e7f8] devinet_ioctl+0x2a4/0x700
 [ed4f1e60] [c027f450] inet_ioctl+0xc8/0xfc
 [ed4f1e70] [c02147b0] sock_ioctl+0x260/0x2a0
 [ed4f1e90] [c009b468] vfs_ioctl+0x2c/0x58
 [ed4f1ea0] [c009bc44] do_vfs_ioctl+0x64c/0x6d4
 [ed4f1f10] [c009bd24] sys_ioctl+0x58/0x88
 [ed4f1f40] [c000e954] ret_from_syscall+0x0/0x38
 --- Exception: c01 at 0xff35a3c
     LR = 0xff359a0
 Instruction dump:
 7c0802a6 3c80c007 3884a500 90010024 38a10008 38000000 90010008 4bffff0d
 80010024 38210020 7c0803a6 4e800020
 <80030000> 7c691b78 700bc000 41a20008
 Kernel panic - not syncing: Fatal exception
 Call Trace:
 [ed4f1b90] [c0007ccc] show_stack+0x58/0x154 (unreliable)
 [ed4f1bd0] [c001d744] panic+0xb0/0x1d8
 [ed4f1c20] [c000b4b8] die+0x1ac/0x1d0
 [ed4f1c40] [c0011e38] bad_page_fault+0xe8/0xfc
 [ed4f1c50] [c000edf4] handle_page_fault+0x7c/0x80
 --- Exception: 300 at put_page+0x0/0x34
     LR = skb_release_data+0x78/0xc8
 [ed4f1d10] [00000000]   (null) (unreliable)
 [ed4f1d20] [c021c914] __kfree_skb+0x18/0xbc
 [ed4f1d30] [c01a7620] e1000_clean_rx_ring+0x10c/0x1a4
 [ed4f1d60] [c01a76e0] e1000_clean_all_rx_rings+0x28/0x54
 [ed4f1d70] [c01aac50] e1000_close+0x30/0xb4
 [ed4f1d90] [c0226e2c] __dev_close_many+0xa0/0xe0
 [ed4f1da0] [c0228c64] __dev_close+0x2c/0x4c
 [ed4f1dc0] [c0225224] __dev_change_flags+0xb8/0x140
 [ed4f1de0] [c0226d48] dev_change_flags+0x1c/0x60
 [ed4f1e00] [c027e7f8] devinet_ioctl+0x2a4/0x700
 [ed4f1e60] [c027f450] inet_ioctl+0xc8/0xfc
 [ed4f1e70] [c02147b0] sock_ioctl+0x260/0x2a0
 [ed4f1e90] [c009b468] vfs_ioctl+0x2c/0x58
 [ed4f1ea0] [c009bc44] do_vfs_ioctl+0x64c/0x6d4
 [ed4f1f10] [c009bd24] sys_ioctl+0x58/0x88
 [ed4f1f40] [c000e954] ret_from_syscall+0x0/0x38
 --- Exception: c01 at 0xff35a3c
     LR = 0xff359a0

When turning on SLAB checks, I see:

Slab corruption: size-16384 start=ed4ec000, len=16384
 690: 6b 6b ff ff ff ff ff ff b8 ac 6f 99 bf 8b 08 00
 6a0: 45 00 00 24 3f 34 00 00 80 11 ca cf 0a ca 0d 33
 6b0: 0a ca 0d ff 06 cc 06 cf 00 10 bc 1d c5 0b 40 01
 6c0: 00 10 00 33 00 00 00 00 00 00 00 00 00 00 3f dd
 6d0: ed f8 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 ea0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff ff ff
 Slab corruption: size-2048 start=ed4e6570, len=2048
 Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
 Last user: [<  (null)>](0x0)
 0c0: 6b 6b ff ff ff ff ff ff 5c 26 0a 41 81 27 08 00
 0d0: 45 00 00 4e 7d 44 00 00 80 11 8c 79 0a ca 0d 4f
 0e0: 0a ca 0d ff 00 89 00 89 00 3a b5 a7 be 71 01 10
 0f0: 00 01 00 00 00 00 00 00 20 45 4c 45 43 45 50 46
 100: 49 43 41 43 41 43 41 43 41 43 41 43 41 43 41 43
 110: 41 43 41 43 41 43 41 41 41 00 00 20 00 01 02 5a
 Next obj: start=ed4e6d88, len=2048
 Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
 Last user: [<c021e294>](__netdev_alloc_skb+0x28/0x60)
 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 Slab corruption: size-2048 start=ed54eb48, len=2048
 Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
 Last user: [<c021cd1c>](skb_release_data+0xb4/0xc8)
 020: 6b 6b ff ff ff ff ff ff 18 03 73 e4 64 18 08 00
 030: 45 00 00 44 61 b8 00 00 80 11 a7 c9 0a ca 0d 95
 040: 0a ca 0d ff f1 ee 07 9b 00 30 53 78 30 53 73 66
 050: 54 77 78 32 41 41 42 4b 52 55 5a 47 54 55 4e 51
 060: 51 7a 49 41 52 47 39 73 62 33 4a 54 61 58 52 42
 070: 62 57 55 41 bc fd 94 9f 6b 6b 6b 6b 6b 6b 6b 6b
 Prev obj: start=ed54e330, len=2048
 Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
 Last user: [<c021e294>](__netdev_alloc_skb+0x28/0x60)
 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 Next obj: start=ed54f360, len=2048
 Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
 Last user: [<c021e294>](__netdev_alloc_skb+0x28/0x60)
 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 Slab corruption: size-2048 start=ed4ae6f0, len=2048
 Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
 Last user: [<c021cd1c>](skb_release_data+0xb4/0xc8)
 020: 6b 6b ff ff ff ff ff ff 00 1a e2 bd 06 44 81 00
 030: 00 f2 08 06 00 01 08 00 06 04 00 01 00 1a e2 bd
 040: 06 44 0a f1 0a 4b 00 00 00 00 00 00 0a f1 0a 4b
 050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 060: 00 00 37 ea e4 d5 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 Next obj: start=ed4aef08, len=2048
 Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
 Last user: [<c01f2898>](rx_submit+0xa0/0x174)
 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 Slab corruption: size-2048 start=ed792928, len=2048
 Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
 Last user: [<c021cd1c>](skb_release_data+0xb4/0xc8)
 020: 6b 6b ff ff ff ff ff ff d4 be d9 a0 1d 8a 08 00
 030: 45 00 00 44 1c a9 00 00 80 11 ed 4b 0a ca 0d 22
 040: 0a ca 0d ff e6 ed 07 9b 00 30 63 13 48 74 77 37
 050: 55 46 51 4c 41 41 42 51 53 45 6c 4d 51 55 46 54
 060: 52 56 42 44 4d 67 42 73 62 33 4a 54 61 58 52 42
 070: 62 57 55 41 d0 91 83 aa 6b 6b 6b 6b 6b 6b 6b 6b
 Prev obj: start=ed792110, len=2048
 Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
 Last user: [<c021e294>](__netdev_alloc_skb+0x28/0x60)
 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 Next obj: start=ed793140, len=2048
 Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
 Last user: [<c021e294>](__netdev_alloc_skb+0x28/0x60)
 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a

After some digging through the list archives and online searchs, I
 thougth perhaps there were DMA issues (such as the controller DMA'ing
 into memory after the rings are disabled).  I turned on the DMA-API
 checks and see:

e1000 0000:00:13.0: DMA-API: device driver tries to free DMA memory it
 has not allocated [device address=0x000000004eae0000] [size=65535
 bytes]
 ------------[ cut here ]------------
 WARNING: at lib/dma-debug.c:811
 Modules linked in:
 NIP: c01450d4 LR: c01450d4 CTR: c0169388
 REGS: ed8fb7e0 TRAP: 0700   Not tainted  (3.0.57-rt82)
 MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24020482  XER: 20000000
 TASK = ed8f6b60[3394] 'ip' THREAD: ed8fa000
 GPR00: c01450d4 ed8fb890 ed8f6b60 00000093 00004718 ffffffff c01668a8 00000000
 GPR08: ed8f6b60 c03ca4c0 00004718 ed8f6c00 24020482 100456d0 c0302a48 c03029d4
 GPR16: c03ee31c ed8fbac8 ed732f10 ed8fbab0 ed8fbad8 00000000 c02fda70 00000000
 GPR24: ed732f00 ed8fb8d8 00000001 0000ffff 4eae0000 ed8fb8d8 c050f6b8 00000000
 NIP [c01450d4] check_unmap+0x1e0/0x7b0
 LR [c01450d4] check_unmap+0x1e0/0x7b0
 Call Trace:
 [ed8fb890] [c01450d4] check_unmap+0x1e0/0x7b0 (unreliable)
 [ed8fb8d0] [c01457a4] debug_dma_unmap_page+0x7c/0x90
 [ed8fb940] [c01ad344] e1000_unmap_and_free_tx_resource+0xf4/0x130
 [ed8fb960] [c01ad3a8] e1000_clean_tx_ring+0x28/0xac
 [ed8fb980] [c01aecb8] e1000_down+0x1e4/0x210
 [ed8fb9b0] [c01af488] e1000_close+0x30/0xb4
 [ed8fb9d0] [c022c2f0] __dev_close_many+0xa0/0xe0
 [ed8fb9e0] [c022e128] __dev_close+0x2c/0x4c
 [ed8fba00] [c022a748] __dev_change_flags+0xb8/0x140
 [ed8fba20] [c022c20c] dev_change_flags+0x1c/0x60
 [ed8fba40] [c023bc40] do_setlink+0x278/0x748
 [ed8fbaa0] [c023d044] rtnl_newlink+0x298/0x4b0
 [ed8fbbd0] [c023c5f4] rtnetlink_rcv_msg+0x210/0x23c
 [ed8fbbf0] [c02454bc] netlink_rcv_skb+0x5c/0xd4
 [ed8fbc10] [c023c3d0] rtnetlink_rcv+0x28/0x3c
 [ed8fbc30] [c0245200] netlink_unicast+0x244/0x2e4
 [ed8fbc70] [c0246020] netlink_sendmsg+0x260/0x2dc
 [ed8fbcc0] [c021a29c] sock_sendmsg+0xa0/0xc4
 [ed8fbda0] [c021b018] __sys_sendmsg+0x1d8/0x29c
 [ed8fbeb0] [c021b220] sys_sendmsg+0x40/0x70
 [ed8fbf00] [c021bfcc] sys_socketcall+0x1b0/0x230
 [ed8fbf40] [c000e9b4] ret_from_syscall+0x0/0x38
 --- Exception: c01 at 0xff0a9d4
     LR = 0x10020900
 Instruction dump:
 48000014 80a9002c 2f850000 40be0008 80a90008 813d0020 3c60c035 815d0024
 3863f06c 80fd0018 811d001c 4bed9c01 <0fe00000> 3d20c040 8009c360 2f800000
 ---[ end trace 0000000000000002 ]---
