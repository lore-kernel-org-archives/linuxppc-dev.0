Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id EBAEADDE42
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 17:53:46 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 3 Jun 2007 09:53:41 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070603075341.GA2157@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<1180828253.14025.22.camel@localhost.localdomain>
	<20070603001323.GA25653@iram.es>
	<438689f53c9fc6605b9091a54f112a37@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <438689f53c9fc6605b9091a54f112a37@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 09:42:55AM +0200, Segher Boessenkool wrote:
> >Maybe the 0x4d0/4d1 ports can be accessed with 16 bit
> >instructions, I don't know. What I know for sure is that
> >accessing port 0x20 with an inl/outl on some boards
> >locks immediately the system up (perhaps through infinite
> >retries).
> 
> And inw/outw?  There are only two bytes of registers
> there after all.

It does not lock up on the boards I've tested, but the results 
are undefined (and perhaps implementation dependent). The problem
being that most accesses to the first register (command) change 
the definition of which internal register is accessed with the 
second byte.

	Gabriel
