Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 02E4667A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 02:15:57 +1000 (EST)
Message-ID: <44BE5A97.50807@ovro.caltech.edu>
Date: Wed, 19 Jul 2006 09:15:19 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
Subject: Re: Linux controlling Hardware-Tasks on FPGA
References: <44BDDFD2.9040702@cs.fau.de>
In-Reply-To: <44BDDFD2.9040702@cs.fau.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


> anyone else out there using or wanting to use Linux to control the
> reconfiguration of a FPGA ? - Do you use dynamic partial reconfiguration
> too ? - If so how did you design the relevant software coarsely ?

Hi Josef,

If you are talking 'partial reconfiguration' then I guess you
are discussing Xilinx devices.

I use Altera devices in my designs. However, this solution could
work for you.

Generally an FPGA is configured, and I assume reconfigured,
by writing the configuration file to a specific set of pins
on the device. Altera devices have passive serial programming
and fast passive parallel programming (and other options).
In my current design I will create either a /dev entry or
use a /sys/firmware type interface that when opened
initializes the programming logic, and then writes whatever
bytes are written to the filesystem node to the programming
interface, eg. so the following will program the FPGA

dd if=firmware.bin of=/dev/fpga

If I get a programming error, then the driver can just return
-EIO, and I'm pretty sure dd will report the error. I plan
to use this approach as I can then buffer the data from user-space
into a kernel buffer, and then setup a DMA controller to
write to the device node. This will ensure that burst transactions
are used (to a system controller FPGA sitting on the local bus
of a PowerQUICC II Pro).

The alternative is to implement mmap() for the region containing
your programming interface control registers, and then just
bit- or byte-bang the programming interface. However, if the
serial interface is slow, then you could turn your 100MHz+ CPU
into a 1MHz- CPU. Linux sometimes has trouble with this
(I've seen the x86 kernel lose ticks when performing lots of
PCI I/O, so now use DMA when its available - which for x86
is basically never, so you have to depend on the adapter board).

Hope that gives you some ideas.

Regards
Dave
