Message-ID: <3ADF33DC.CDA78E27@mvista.com>
Date: Thu, 19 Apr 2001 14:52:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kyle Harris <kharris@nexus-tech.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TDM on mpc823
References: <3ADF222D.C860E056@nexus-tech.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kyle Harris wrote:

> Sorry if this is off-topic (not really linux related).

It's OK....It's an education about how to use Linux with a TDM
interface :-).

> But as soon as I go above 5 bytes, the TDM fails to send the correct
> number and sometimes stuffs the bits in an incorrect slot.

I'm going to assume you are using an SMC (since SMC2 is a logical
choice).  Here is another reason why you don't use the LAST indicator.
Unlike the SCC, the SMC doesn't start to load it's FIFO from the BD
until the TDM tells it the frame pulse has arrived.  Because of this,
you can't get the first slot of the TDM to transmit from an SMC after
it achieves synchronization.  You will notice my cs4218 driver
compensates for this by shifting the data in the buffer (by moving
the pointer) on the first buffer of a transfer.  Once the world is
streaming, the SMC can move through the buffers and get the first
TDM slot.  If you are using a processor with an available SCC (like
SCC3 on the 823e/850), I would use that instead of the SMC.  The SCC
pre-loads the FIFO, and behaves as you expect.  FYI, the SMC is useful
for managing the ISDN D-channel on either IDL or GCI, which isn't the
first slot and is low bandwidth.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
