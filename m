Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id DFCD4DE120
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 07:51:24 +1000 (EST)
Message-ID: <49E4FED0.1020003@ovro.caltech.edu>
Date: Tue, 14 Apr 2009 14:23:28 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
References: <20090224000002.GA578@ovro.caltech.edu>
	<fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
In-Reply-To: <fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
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

> I like this a lot.  I need to do much the same thing on one of my
> platforms, so I'm going to use your patch as my starting point.  Have
> you made many changes since you posted this version of your patch?
> I'd like to collaborate on the development and help to get it
> mainlined.
> 
> In my case I've got an MPC5200 as the 'host' and a Xilinx Virtex
> (ppc440) as the 'client'.  I intend set aside a region of the Xilinx
> Virtex's memory space for the shared queues.  I'm starting work on it
> now, and I'll provide you with feedback and/or patches as I make
> progress.

I'll let Ira update you on the patch status.

If you want someone to chat about the hardware-level interaction,
feel free to chat off-list - assuming of course that no one wants
to hear us talk hardware :)

I selected the MPC8349EA in-part due to its PCI mailboxes, so
that we could implement this type of driver (an interlocked
handshake for flow control of data transfers). The previous
chip I'd used was a PLX PCI9054 Master/Target, and it has
similar registers.

I'm not sure if the Xilinx PCI core, or whatever PCI core you
are using, already has something like the mailboxes implemented,
but if not, it won't take much to code up some logic.
I prefer VHDL myself, but can speak Verilog if forced to :)

Cheers,
Dave
