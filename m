Message-ID: <3DD40793.101BD0FD@phx.mcd.mot.com>
Date: Thu, 14 Nov 2002 13:29:07 -0700
From: Tom Armistead <Tom_Armistead@phx.mcd.mot.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: ???? <yuj@mail.ndsc.com.cn>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: motorola lopec mpc7410
References: <200211140848.CAA19190@lists.linuxppc.org> <20021114151038.GA14431@opus.bloom.county> <3DD3D715.8BA00B56@phx.mcd.mot.com> <20021114173507.GB605@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

>
> >
> > PPC5Bug is the firmware for Lopec.  The last released version for Lopec is PPC5Bug 1.4 RM02 but it is unlikely that upgrading the firmware (from 1.3) would have any effect on the described problem.   I don't know much about Linux but my
> > guess is that something is misconfigured in your kernel (console IO would be the first thing I'd check...).
>
> Well, if he is using the MVista supplied LSP, the config should be
> correct, as it was tested on a similar machine at mvista.  What changed
> from PPC5Bug 1.3 to 1.4?  There is a general reliance on the lopec for
> the firmware to have set things up correctly, so if there was some
> critical fix in 1.4, that might explain it.
>
> >

Here is the list of changes from 1.3 to 1.4 from the release notes:

Fixed the Symbios 895A SCSI reset problem and corrected the EIDE DMA test so that it doesn't display errant warnings when the test executes on a known good board.


Corrected the PCIBUS REG test to check the PCI bridge device to ensure it supports interrupts. This ensures the Int Line register is not tested if the device does not support interrupts.


Removed the UPDATE command from PPCxBUG and restructured the board feature calls (internal changes only).


Corrected the calculation of the bus speed after having used the PF (Port Format) command to change the baud rate of the serial debug port.


Added support for the Intel 82543 and 82544 ethernet controllers.


Added support for Non-ECC memory (primarily an issue for LoPEC which provides DIMM sockets).


Added ECC error checking during RAM tests to PPC5BUG.


Added Intel 82544 PHY access support.


Corrected an I2C access problem that intermittantly caused the I2C bus to stick in a BUSY state for long periods of time. This resulted in unusually long boot-up times for PPC5BUG, especially for LoPEC boards running at 100MHz (local bus)
with certain combinations of DIMMs. Instead of consuming the typical 15 to 30 seconds (depending upon memory size) during the boot process, a period of 70 to 80 seconds would transpire.

Fixed several problems with the I82543 diagnostic tests (the only test available currently is the SPACK test).


Corrected a condition where running the CL1283 diagnostic on a board without the CL1283 generated an error condition instead of simply bypassing the test. The error condition was visible, though, only through invoking either the DE or DEM
command.


Tom Armistead


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
