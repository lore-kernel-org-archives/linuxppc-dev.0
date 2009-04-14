Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 3EE42DE125
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 07:52:51 +1000 (EST)
Message-ID: <49E505B3.5070005@ovro.caltech.edu>
Date: Tue, 14 Apr 2009 14:52:51 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
References: <20090224000002.GA578@ovro.caltech.edu>
	<fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
	<49E4FED0.1020003@ovro.caltech.edu>
	<fa686aa40904141445x6a125e12r391e0853d89baf72@mail.gmail.com>
In-Reply-To: <fa686aa40904141445x6a125e12r391e0853d89baf72@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

> Thanks David.  I haven't looked closely at the xilinx pci data sheet
> yet, but I don't expect too many issues in this area.  As you say, it
> won't take much to code it up.  I'll be poking my VHDL engineer to
> make it do what I want it to.  :-)

The key aspects of the core will be that it is Master/Target
so that it can take over the PCI bus, and that it has a
DMA engine that can take care of most of the work. In
your case, since you have a DMA controller on the host
(MPC5200) and the target (Xilinx), your driver might end
up having nicer symmetry than our application. The
most efficient implementation will be the one that
uses PCI writes, i.e., MPC5200 DMAs to the Xilinx core,
and the Xilinx core DMAs to the MPC5200. If you use
a PCI Target only core, then the MPC5200 DMA controller
will have to do all the work, and read transfers might
be slightly less efficient.

Our target boards (PowerPC) live in compactPCI backplanes
and talk to x86 boards that do not have DMA controllers.
So the PCI target board DMA controllers are used to
transfer data efficiently to the x86 host (writes)
and less efficiently from the host to the boards
(reads). Our bandwidth requirements are 'to the host',
so we can live with the asymmetry in performance.

> I'll keep you up to date on my progress.

Sounds good.

Cheers,
Dave
