Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 36281DE136
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 08:16:50 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so3903740rvb.1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 15:16:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49E505B3.5070005@ovro.caltech.edu>
References: <20090224000002.GA578@ovro.caltech.edu>
	<fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
	<49E4FED0.1020003@ovro.caltech.edu>
	<fa686aa40904141445x6a125e12r391e0853d89baf72@mail.gmail.com>
	<49E505B3.5070005@ovro.caltech.edu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 14 Apr 2009 16:16:34 -0600
Message-ID: <fa686aa40904141516s1ca2965fted07bf2a6f5ce390@mail.gmail.com>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Apr 14, 2009 at 3:52 PM, David Hawkins <dwh@ovro.caltech.edu> wrote=
:
> Hi Grant,
>
>> Thanks David. =A0I haven't looked closely at the xilinx pci data sheet
>> yet, but I don't expect too many issues in this area. =A0As you say, it
>> won't take much to code it up. =A0I'll be poking my VHDL engineer to
>> make it do what I want it to. =A0:-)
>
> The key aspects of the core will be that it is Master/Target
> so that it can take over the PCI bus, and that it has a
> DMA engine that can take care of most of the work. In
> your case, since you have a DMA controller on the host
> (MPC5200) and the target (Xilinx), your driver might end
> up having nicer symmetry than our application. The
> most efficient implementation will be the one that
> uses PCI writes, i.e., MPC5200 DMAs to the Xilinx core,
> and the Xilinx core DMAs to the MPC5200.

Hmmm, I hadn't thought about this.  I was intending to use the
Virtex's memory region for all virtio, but if I can allocate memory
regions on both sides of the PCI bus, then that may be best.

> If you use
> a PCI Target only core, then the MPC5200 DMA controller
> will have to do all the work, and read transfers might
> be slightly less efficient.

I'll definitely intend to enable master mode on the Xilinx PCI controller.

> Our target boards (PowerPC) live in compactPCI backplanes
> and talk to x86 boards that do not have DMA controllers.
> So the PCI target board DMA controllers are used to
> transfer data efficiently to the x86 host (writes)
> and less efficiently from the host to the boards
> (reads). Our bandwidth requirements are 'to the host',
> so we can live with the asymmetry in performance.

Fortunately I don't have very high bandwidth requirements for the
first spin, so I have some room to experiment.  :-)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
