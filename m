Return-Path: <jgeissel@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5FB0D679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 21:34:44 +1000 (EST)
From: Arno Geissel <jgeissel@gmx.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: problem with watchdog/reboot MPC5200
Date: Thu, 20 Apr 2006 13:34:39 +0200
References: <200604201146.01342.jgeissel@gmx.net>
	<1145528473.13114.6.camel@linpc041.aimsys.nl>
In-Reply-To: <1145528473.13114.6.camel@linpc041.aimsys.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604201334.39513.jgeissel@gmx.net>
Reply-To: jgeissel@gmx.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jaap-Jan,

I'm not booting from flash. The kernel is loaded using bootp and
the rootfs is mounted over NFS. Flash is not needed for the boot
process at all. Fact is, that the mpc5200 watchdog timer
does not work, if I have written something to flash while runtime of
the system. If I have not, the reboot, which uses the watchdog,
performs OK.
On the other hand I would expect that the MTD package should
know how to handle an Intel Strataflash.

Arno

> Arno,
>
> I think your problem is related to Intel Strataflash specifics.
> After a write to strataflash, it remains in status mode until another
> read (or reset) command is issued. This means you don't get the flash
> contents when reading it, but a status bit (e.g. 0x8080 at every spot).
> So when the processor start executing after a reset, it's not reading
> proper instructions.
>
> You first need to e.g. write a reset cmd (0x5050) to it or connect
> the processor's hardreset line to the flash device.
>
> Jaap-Jan
>
> On Thu, 2006-04-20 at 11:46 +0200, Arno Geissel wrote:
> > Hello all,
> >
> > I have a custom board based on MPC5200 processor running
> > the latest linuxppc_2_4_devel.
> > Everything is working fine until a flash write access is performed
> > using MTD. After this a (soft) reboot stucks in mpc5xxx_restart()
> > where the watchdog timer is charged and linux waits with closed
> > interrupts until the MPC performs the reset. Only power off helps
> > in this situation.
> > It seems to me like a hardware problem, because the freescale
> > MPC5200lite reference board does not run into this.
> > The main difference of the custom board to the reference board
> > is, that it is using 16MB Intel Strada Flash instead of AMD flash,
> > which has an erase block size of 128kB.
> > Has anybody else experienced such behaviour?
> >
> > Arno Geissel
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
