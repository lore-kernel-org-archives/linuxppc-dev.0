Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id B2BD3DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Oct 2007 04:20:34 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so125061nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Oct 2007 11:20:33 -0700 (PDT)
Message-ID: <fa686aa40710191120w209b62a0l4f71e528e5f1a1b3@mail.gmail.com>
Date: Fri, 19 Oct 2007 12:20:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: aauer1 <aauer1@gmx.at>
Subject: Re: SystemACE driver problem
In-Reply-To: <13300089.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <13290652.post@talk.nabble.com>
	<fa686aa40710190704j18feabf2geb417d554ebb11c@mail.gmail.com>
	<13300089.post@talk.nabble.com>
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

On 10/19/07, aauer1 <aauer1@gmx.at> wrote:
>
>
>
> Grant Likely-2 wrote:
> >
> > On 10/19/07, aauer1 <aauer1@gmx.at> wrote:
> >>
> >> Hello
> >>
> >> I'm trying to boot a Linux Kernel 2.6.23-rc2 from Grant Likely (thanks
> >> for
> >> the great work) on a Xilinx ML403 board. I want to use the second
> >> partition
> >> of the Compact Flash Card as root filesystem. But the boot process hangs
> >> at
> >> the initialization of the SystemACE module. A strange effect is that the
> >> DONE LED (configuration of the FPGA is done) turns off. So, this means
> >> that
> >> the FPGA loses his configuration.
> >> Has anybody recognized a similar problem with the SystemACE module??
> >>
> >> The boot log:
> >> ========
> > [snipped]
> >> [    0.268807] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 2) is a
> >> uartlite
> >> [    0.270399] console [ttyUL0] enabled
> >> [    1.762725] RAMDISK driver initialized: 8 RAM disks of 8192K size 1024
> >> blocke
> >> [    1.852062] Registering Xilinx SystemACE driver, major=254
> >> [    1.919734] xsysace xsysace.0: ace_probe(c01638e0)
> >
> > Yes, I've seen that.  It means something went wrong with the setup and
> > caused the sysace to reload the FPGA.  Is the systemace base address
> > and bus width set correctly?
> >
> >
>
> The base address is the same as in the system.mhs file of my hardware
> design. So, I think it should be correct. The bus width is set to 16 bits
> (hardware design). So far as I can see, the sysace driver defines a 16 bit
> data bus (hard coded), too.

Hmmm; that's all very odd.  I don't know what could be causing that.

> A paper of BlueCat Linux says that there is a problem with the System ACE
> hardware module:
> "Due to a known problem of the opb_sysace IP Core programmed into the FPGA
> (incorrect operation in the interrupt mode) the SystemACE Compact Flash
> device is supported in the polling mode."
>
> Does anyone know something about the bug in the SystemACE IP core??

I don't know about the old xilinx supplied sysace driver, but the new
xsysace.c driver is robust enough to work around missed interrupts.  I
don't know of any other problems with the opb_sysace IP core.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
