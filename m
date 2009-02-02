Return-Path: <kodiakuppercut@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 0A313DDF08
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 07:14:49 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j5so875409wah.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Feb 2009 12:14:48 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 2 Feb 2009 13:14:48 -0700
Message-ID: <bc81dc640902021214y4b263898r407bdf0c96a6ef31@mail.gmail.com>
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28 kernel
From: Aaron Pace <kodiakuppercut@gmail.com>
To: linuxppc-dev@ozlabs.org, Lixin.Yao@HSTX.com
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> I use a San Disk compact flash (CF) card on a board with MPC8248
> processor. The CF is connected to data and address bus of the processor
> and operates in TRUE IDE mode. The registers are memory mapped. I can
> read the file system on the CF in u-boot (1.3.4). U-boot can identify
> the CF and mount file system correctly.
<snip>

I have just gone through solving a problem that sounds very similar
(using several flash cards).
We also have a flash card wired up in true IDE mode.  The problem that
I ran into is that any time the Interrupt Enable (bit 1) or Software
Reset(bit 2) bits were set in the control register, the flash would
show an error in the status register (bit 0), and was not recoverable
except by toggling the power to the card.
To work around this, write a driver based on the PATA driver, but
replace (or at least examine) each and every element of the
ata_port_operations struct you are using, replacing any function which
soft resets or enables interrupts.

> ata_host_alloc: ENTER
> ata_port_alloc: ENTER
> __ata_port_freeze: ata4294967295 port frozen
> scsi0 : pata_platform
> ata1: PATA max PIO3 no IRQ, using PIO polling mmio cmd 0x30000000 ctl
> 0x40000000
> ata_host_register: probe begin
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_link_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata1 port frozen
> ata_sff_softreset: ENTER
> ata_sff_softreset: about to softreset, devmask=0
> ata_bus_softreset: ata1: bus reset via SRST
> ata_sff_softreset: EXIT, classes[0]=9 [1]=9
> ata_eh_thaw_port: ata1 port thawed
> ata_std_postreset: ENTER
> ata_std_postreset: EXIT
> ata_sff_postreset: EXIT, no device
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=0
> ata_scsi_error: EXIT

The above sequence of ATA calls you are seeing is essentially
identical to what I ran into -- part of the registration attempted to
either enable interrupts or soft reset the card, the error bit stuck
high, and everything went downhill from there.
Hope that helps.

-Aaron Pace
