Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 472FFDE0D5
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 08:27:16 +1000 (EST)
Message-ID: <49E50DC4.3080108@ovro.caltech.edu>
Date: Tue, 14 Apr 2009 15:27:16 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
References: <20090224000002.GA578@ovro.caltech.edu>
	<fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
	<49E4FED0.1020003@ovro.caltech.edu>
	<fa686aa40904141445x6a125e12r391e0853d89baf72@mail.gmail.com>
	<49E505B3.5070005@ovro.caltech.edu>
	<fa686aa40904141516s1ca2965fted07bf2a6f5ce390@mail.gmail.com>
In-Reply-To: <fa686aa40904141516s1ca2965fted07bf2a6f5ce390@mail.gmail.com>
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

> Hmmm, I hadn't thought about this.  I was intending to use the
> Virtex's memory region for all virtio, but if I can allocate memory
> regions on both sides of the PCI bus, then that may be best.

Sounds like you can experiment and see what works best :)

>> If you use
>> a PCI Target only core, then the MPC5200 DMA controller
>> will have to do all the work, and read transfers might
>> be slightly less efficient.
> 
> I'll definitely intend to enable master mode on the Xilinx PCI controller.

Since you understand the lingo, you clearly understand
there are core differences :)

>> Our target boards (PowerPC) live in compactPCI backplanes
>> and talk to x86 boards that do not have DMA controllers.
>> So the PCI target board DMA controllers are used to
>> transfer data efficiently to the x86 host (writes)
>> and less efficiently from the host to the boards
>> (reads). Our bandwidth requirements are 'to the host',
>> so we can live with the asymmetry in performance.
> 
> Fortunately I don't have very high bandwidth requirements for the
> first spin, so I have some room to experiment.  :-)

Yes, in theory you have enough bandwidth ... then a
few features are added, the PCI core is not quite as
fast as advertised, etc etc :)

Cheers,
Dave
