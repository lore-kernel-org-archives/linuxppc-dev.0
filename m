Message-ID: <3A2610E8.F130EC03@Ferrari.DE>
Date: Thu, 30 Nov 2000 09:33:44 +0100
From: Rolf Fiedler <Rolf.Fiedler@Ferrari.DE>
Reply-To: Rolf.Fiedler@Ferrari.DE
MIME-Version: 1.0
To: mgreer@mvista.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: target entered debug mode
References: <3A251EA8.74A26893@Ferrari.DE> <3A2540C6.9CC58476@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark,

thank you for answering... Please find my comment below.

> >
> > I have a monta vista 2.4.0-test1 kernel running on a IBM PPC405GP
> > selfmade board. Connected to the board is an Abatron BDI2000, which
> > I use for TFTP booting. The board mounts the root nfs via PMC ethernet
> > (intel i82559ER). The internal ethernet controller isn't working,
> > I have no idea why - can't talk to the LXT972 via MII management
> > interface. That is my next task...
>
> Doesn't the 82559 have an integrated PHY?

Yes, I have the 82559 on a PCI mezzanine card in the system, since
the PPC405 internal EMAC is not working with the LXT972 PHY. The 82559
is eth1, which I use for NFS root mount.

>
> I've seen a problem with the eepro100 driver on big-endian machines where a
> value written to a register is byte-swapped twice (making it unswapped).
>
> Look in eepro100.c near the bottom of speedo_resume().  If you have a line
> like:
> outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE)),
> then the outl is byte-swapping and so is the cpu_to_le32.  That's wrong.  You
> need to get rid of the cpu_to_le32.  Look for other combinations of outl and
> cpu_to_le32 together and remove the cpu_to_le32--on my version, there is only
> one occurance of this.


Thank you for the hint regarding the eepro big endian driver bug.
I checked, and the monta vista source for 2.4.0-test1 has been
fixed. there are two occurances:


        wait_for_cmd_done(ioaddr + SCBCmd);
#ifdef  CONFIG_IBM405GP
        outl((TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE)),
                ioaddr + SCBPointer);
#else
        outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->dirty_tx %
TX_RING_SIZE)),
                 ioaddr + SCBPointer);
#endif

        /* We are not ACK-ing FCP and ER in the interrupt handler yet so
	   they should remain masked --Dragan */
        outw(CUStart | SCBMaskEarlyRx | SCBMaskFlowCtl, ioaddr +
SCBCmd);

---------- and -------
        speedo_show_state(dev);
#if 0
        if ((status & 0x00C0) != 0x0080
                &&  (status & 0x003C) == 0x0010) {
                /* Only the command unit has stopped. */
                printk(KERN_WARNING "%s: Trying to restart the
transmitter...\n", dev->name);
                outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, dirty_tx %
TX_RING_SIZE]))
,
                         ioaddr + SCBPointer);
                outw(CUStart, ioaddr + SCBCmd);
                reset_mii(dev);
        } else {
#else
        {

- So that shouldn't be it.


> > My question is:
> > How come the board enters debug mode on the Abatron BDI2000 once
> > in a while? I had it running processing data all over the weekend,
> > and on monday it locked. I had a number of lock-ups since.
> >
> > what I get from the debugger is:
> > - TARGET: target has entered debug mode
> >
> > and if I do info:
> > Target state      : debug mode
> > Debug entry cause : JTAG stop request
> > Current PC        : 0xc0012b90
> > Current CR        : 0x24000028
> > Current MSR       : 0x00009230
> > Current LR        : 0xc00048c4
> >
> > Is it a problem with the Abatron debugger or is my board instable?
> >
> > I did a objdump -d of the kernel running and the debug mode entry
> > happend in the scheduler, in schedule:
> >         /*
> >          * 'sched_data' is protected by the fact that we can run
> >          * only one process per CPU.
> >          */
> >         sched_data = & aligned_data[this_cpu].schedule_data;
> > c0012b84:       3d 20 c0 14     lis     r9,-16364
> > c0012b88:       39 29 b0 c0     addi    r9,r9,-20288
> > c0012b8c:       7f de 4a 14     add     r30,r30,r9
> >
> >         spin_lock_irq(&runqueue_lock);
> > c0012b90:       3d 60 c0 13     lis     r11,-16365     <--------
> > c0012b94:       80 0b 83 e0     lwz     r0,-31776(r11)
> > c0012b98:       7c 08 03 a6     mtlr    r0
> > c0012b9c:       4e 80 00 21     blrl
>
> I see this when cache is stale.  This is very easy to do when you download via
> the bdi (or other probes).  A good general practice when downloading code with
> a jtag probe is to invalidate all of L1 and L2 caches because they may/will be
> stale.
>
> I don't know what the cacheline size is on a 405GP so I don't know if 0x90 is
> the first word on a new cacheline (usually ppc processor have 32 byte
> cachelines which means it wouldn't be).  Either way, try invalidating all your
> caches (do NOT flush them) as soon as the code you downloaded starts to run
> and see if that helps.

Thank you for that hint as well. Although I doubt that the lock-up
is related to stale cache, since the CPU is decompressing the kernel
image into memory. This should invalidate the appropriate cache lines
in the CPU while the CPU is writing memory. And schedule has probably
been run a couple of times before lock-up occurs. however, I will
do the experiment you suggest. By doing so I can measure the influence
of cache on the performance of our application.

Thanks again for your valuable remarks,
kind regards,
Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
