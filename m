Message-ID: <3BA7D3B4.6D0C6BB4@mvista.com>
Date: Tue, 18 Sep 2001 19:07:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: cejka@inf.enst.fr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 and audio codec MC145481 problems
References: <20010918024908.A18414@inf.enst.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


cejka@inf.enst.fr wrote:

> .... The problem
> is that both clock signals MCLK/BCLKR/BCLKT and FSR/FST has to be generated
> by PowerPC and there is none input sync signal into PowerPC.

You're not going to be very happy with this design.  I doubt you
will be able to generate these clocks in software with the precision
necessary to drive the audio codec.  Further, if you do this in
software you aren't likely to have much CPU available for any other
task.

I've worked on a couple of designs that use a Crystal codec,
connected to the TDM interface.  This requires minimal CPU
intervention as the audio I/O is handled by the CPM using DMA.
The driver is in the MontaVista HHL distribution, and I'm
currently rewriting it to fit into the linuxppc_2_4 tree.

Good Luck.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
