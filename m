Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AD4D7DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 06:14:34 +1000 (EST)
Message-ID: <46E05FFD.3020605@ovro.caltech.edu>
Date: Thu, 06 Sep 2007 13:15:57 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: PCI target implementation on AMCC PPC CPUs
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>	<20070906184308.GA22380@ld0162-tx32.am.freescale.net>
	<406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
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

Hi Leonid,

> Does somebody have any experience of using AMCC PPC chips (such as
> PPC440ep) or any other PPC at all as PCI target (slave)? PPC440ep has
> PCI-PLB bridge which certainly can be configured as slave. CPU will need
> to do configuration and then I assume another CPU (PCI host) will be
> able to access all memories via the bridge including peripherals'
> controllers. Slave CPU involvement would be minimal then.
> 
> Can anybody point me to design like this or to that end to any SW design
> where PPC CPU works as PCI slave?

I have an application where I want to communicate with up
to 20 cPCI slaves per cPCI chassis, where the slave devices
each use a PowerPC based processor. (The masters happen
to be x86 CPUs; because I have them).

I looked at the 440EP using the Yosemite board

http://www.ovro.caltech.edu/~dwh/powerpc_440ep.pdf

and the Freescale MPC8349E

http://www.ovro.caltech.edu/~dwh/powerpc_mpc8349e.pdf

I had some trouble the with AMCC chips; the DMA controller
operation was weird, and AMCC tech support was pretty
much useless.

Freescale's technical (design) support is great, and they
(the software developers; Kim, Timur, etc) are actively
maintaining/contributing to git trees for u-boot and Linux.
If you can change processors, I'd recommend any Freescale
part over an AMCC part.

I'm working on a cPCI board design at the moment, you're
welcome to look at the design;

  * PowerPC
  * Altera Stratix II FPGAs
  * dual 8-bit 1GHz ADCs

http://www.ovro.caltech.edu/~dwh/carma_board/

Regards,
Dave
