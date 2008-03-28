Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 68755DDF28
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Mar 2008 10:24:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so112212anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Mar 2008 16:24:52 -0700 (PDT)
Message-ID: <fa686aa40803281624y7db3ca7cyc022bf78acf26f8@mail.gmail.com>
Date: Fri, 28 Mar 2008 17:24:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Glenn.G.Hart@us.westinghouse.com,
	"Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"John Linn" <John.Linn@xilinx.com>
Subject: Re: Network Bad Kernel Access
In-Reply-To: <OF268312ED.06BF1E68-ON85257344.0004544A-85257344.00059541@ct.wec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <OF268312ED.06BF1E68-ON85257344.0004544A-85257344.00059541@ct.wec.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Aug 26, 2007 at 7:00 PM,  <Glenn.G.Hart@us.westinghouse.com> wrote:
> I am having a problem with my network.  I am using a V4FX12 running linux
>  2.6.21 with the TEMAC.  I am running the PPC at 300 MHz and the TEMAC is
>  configured for DMA and DRE on the Xmit and the Recv.  I have tried varying
>  the FIFO depth and enabling/disabling the checksum offloading.  All produce
>  the error below when under heavy network traffic (specifically sending data
>  from the PPC).  Has anybody seen this?  It seems like I am overflowing some
>  memory, but I am not sure what/where to increase it.

I'm seeing the same behavior on my platform except that I get it
almost immediately after bringing up the Ethernet interface.  I've
only just started to debug this.  The bug showed up when DMA+DRE+CSUM
were enabled on the core.

Stephen, John; does any of this look familiar?

Cheers,
g.

>
>  Thanks,
>  Glenn
>
>
>
>  [  484.696738] Oops: kernel access of bad area, sig: 11 [#1]
>  [  484.761286] NIP: c00e1ef4 LR: c00cfec0 CTR: c00cfe34
>  [  484.820650] REGS: c0483b10 TRAP: 0300   Not tainted  (2.6.21)
>  [  484.889378] MSR: 00029030 <EE,ME,IR,DR>  CR: 93005999  XER: e0000000
>  [  484.965410] DAR: bb857caf, DSISR: 00000000
>  [  485.014365] TASK = c0648b60[129] 'rcS' THREAD: c0482000
>  [  485.074765] GPR00: c04fdfb8 c0483bc0 c0648b60 bb857c2b c04fd9a0 c0483bcc
>  04000000 ff107ac0
>  [  485.174747] GPR08: 0000000f c04fdfb8 c04d2478 00010001 00648d10 1003c2e0
>  00000000 00000001
>  [  485.274732] GPR16: 00000003 c0483ed8 00004fd8 000005b4 000005b4 00000000
>  00000000 0001679c
>  [  485.374716] GPR24: 7ff8b398 3002afe0 0000000f c04d2000 c04d23b8 c06bbe60
>  00000003 c04d2320
>  [  485.476784] NIP [c00e1ef4] kfree_skb+0x8/0x3c
>  [  485.528858] LR [c00cfec0] SgSendHandlerBH+0x8c/0x1cc
>  [  485.588223] Call Trace:
>  [  485.617389] [c0483bc0] [c00cfec0] SgSendHandlerBH+0x8c/0x1cc
>  (unreliable)
>  [  485.698628] [c0483bf0] [c0019218] tasklet_action+0x90/0xd4
>  [  485.764241] [c0483c00] [c0018ebc] __do_softirq+0x64/0xd0
>  [  485.827772] [c0483c20] [c00064a8] do_softirq+0x40/0x58
>  [  485.889221] [c0483c30] [c0018f74] irq_exit+0x38/0x48
>  [  485.948586] [c0483c40] [c0006450] do_IRQ+0x88/0xa0
>  [  486.005868] [c0483c50] [c00032d8] ret_from_except+0x0/0x18
>  [  486.071483] [c0483d10] [c0483d00] 0xc0483d00
>  [  486.122516] [c0483d20] [c00e17d4] __alloc_skb+0x48/0x11c
>  [  486.186048] [c0483d40] [c0109218] tcp_sendmsg+0x1ac/0xc40
>  [  486.250621] [c0483db0] [c0126b58] inet_sendmsg+0x60/0x74
>  [  486.314152] [c0483dd0] [c00dcf34] sock_aio_write+0xe0/0xfc
>  [  486.379765] [c0483e30] [c0050910] do_sync_write+0xb8/0x10c
>  [  486.445381] [c0483ef0] [c0050a40] vfs_write+0xdc/0x10c
>  [  486.506829] [c0483f10] [c0050b48] sys_write+0x4c/0x8c
>  [  486.567236] [c0483f40] [c0002c90] ret_from_syscall+0x0/0x3c
>  [  486.633888] Instruction dump:
>  [  486.669300] 0f000000 7fe3fb78 7d6803a6 4e800021 80010014 7fe3fb78
>  7c0803a6 bbc10008
>  [  486.761992] 38210010 4bfffe78 2c030000 4d820020 <80030084> 39230084
>  2f800001 409e0008
>  [  486.858162] Kernel panic - not syncing: Aiee, killing interrupt handler!
>  [  486.938382] Rebooting in 180 seconds..
>
>
>  _______________________________________________
>  Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
