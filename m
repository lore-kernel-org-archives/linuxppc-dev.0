Return-Path: <James.Grenier@adc.com>
Received: from smtp2.adc.com (smtp2.adc.com [155.226.255.86])
	by ozlabs.org (Postfix) with ESMTP id D299067CE8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 08:37:30 +1000 (EST)
Received: from mn01gtwy02.adc.com (mn01gtwy02.adc.com [155.226.11.208])
	by smtp2.adc.com (8.13.1/8.13.1) with ESMTP id k93MV4uo004829
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Oct 2006 17:31:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: linux-2.6 system ACE driver - need help
Date: Tue, 3 Oct 2006 17:31:03 -0500
Message-ID: <1838D4BEC0D73749BC5FF84D46F38E7901F274F0@mn01exch02.adc.com>
From: "Grenier, Jim" <James.Grenier@adc.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi Jeff,
>=20
> Thanks for your reply.
>=20
> > Does it work for you in polling mode?  If not, you probably have a
> problem with the way you are accessing the system ace - cache,
> endianess, byte alignment, etc.  If it does work in polling, the usual
> suspects are interrupt masking errors or some low level problems with
> your IRQ signals.  Since you know the size of a sector and the size of
> the sysace buffers, how many interrupts do you get per sector read?
Do
> you see extras or not enough?
>=20
> I heard from Ameet Patil that this driver is not tested in poilling
mode and it failed when we tried also.
> Thats when we moved to interrupt mode.=20
>=20
> I did check for the endianess...byte alignment etc.It looks ok to me.
>=20
> I am using a 64 MB flash. And the sector sice is 512K.When the kernel
boots up I see 128 interrupts getting registered. (I think its from
alloc_disk(16) function in adapter.c )
>=20
> Seems like the driver has issues with completing the request.
>=20
> We are having issues while mouting the device. It is erratic, that
sometimes we are able to mount/list files, copy files.
>=20
> But sometimes the kernel crashes and gives a Ooops message like :
>=20
> /*********************************************************/
>=20
> # ls /mnt/Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C00556B8 LR: C00557E4 CTR: 00000000
> REGS: dfec1e08 TRAP: 0300   Not tainted  (2.6.16.2)
> MSR: 00021000 <ME>  CR: 22128828  XER: 00000000
> DAR: 30303030, DSISR: 00800000
> TASK GPR00: 00100100 DFEC1EB8 DFF6C030 C0258C60 DFF7BE10 00000018
DF4E9000 C0256D60
> GPR08: 30303030 00200200 DF4E9154 30303030 22128888 00100400 1FFB9700
00000000
> GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0 1FFCEF78
C01F0000
> GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018 00000000
C0258C60
> NIP [C00556B8] free_block+0xa8/0x148
> LR [C00557E4] drain_array_locked+0x8c/0xd8
> Call Trace:
> [DFEC1EB8] [DFCA9490] 0xdfca9490 (unreliable)
> [DFEC1ED8] [C00557E4] drain_array_locked+0x8c/0xd8
> [DFEC1EF0] [C0056F80] cache_reap+0x74/0x18c
> [DFEC1F28] [C002B578] run_workqueue+0x9c/0x110
> [DFEC1F48] [C002B6E4] worker_thread+0xf8/0x13c
> [DFEC1FC0] [C002F6F0] kthread+0xf4/0x130
> [DFEC1FF0] [C000413C] kernel_thread+0x44/0x60
> Instruction dump:
> 7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14
80c9001c
> 3d200020 61290200 81060004 81660000 <91680000> 910b0004 3966001c
90060000
> BUG: events/0/4, lock held at task exit time!
>  [c01f5d60] {cache_chain_mutex}
> .. held by:          events/0:    4 [dff6c030, 110]
> ... acquired at:               cache_reap+0x1c/0x18c
> /*******************************************************************/
>
>
> We are able to do this after modiifying the file
xsysace_compactflash.c and xsysace_intr.c  to reset the controller( It
was commented out by applying the patch).
>=20
> The data in the CF looks sane.
>
> Please advise.
>
> Thanks for your help.
>
>
> Thanks
> Junita

I have run into a problem with random crashes with System ACE on a
custom board.
It turned out that sometimes the System ACE chip would generate an extra
interrupt
after a write operation completed. The ISR in the driver is dumb and
assumes a transfer
just completed. This messed up the empty read/write queue for the
device.

I was working on a 2.4.17 kernel, so I don't know if it applies to you.
The quick fix was to ignore these extra interrupts. I changed the line
in xsysace_intr.c from:

	if (StatusReg & XSA_SR_DATABUFRDY_MASK) {

to:

	if ( (StatusReg & XSA_SR_DATABUFRDY_MASK) &&
  	              (XSysAce_mGetControlReg(AcePtr->BaseAddress) &
  	               XSA_CR_DATARDYIRQ_MASK) ) {

With this change, the driver will generate a transfer complete event
only if a transfer was in progress.

Hope this helps.

Jim Grenier
