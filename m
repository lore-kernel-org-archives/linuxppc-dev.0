In-Reply-To: <JPEALJAFNGDDLOPNDIEECEJBCIAA.joakim.tjernlund@lumentis.se>
References: <JPEALJAFNGDDLOPNDIEECEJBCIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3EECAC02-A8EC-11D8-BBC2-003065F9B7DC@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Serial port text corruption
Date: Tue, 18 May 2004 12:56:02 -0400
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 18, 2004, at 6:03 AM, Joakim Tjernlund wrote:

> This is very confusing and I would fix it but I don't know where to
> start.
> Any guesses as to where the problem is? Kernel serial layer, the 8xx
> uart.c driver,
> the user space login program or somewhere else?

Are you using a USB to serial adapter on your laptop?  I've seen similar
things on many different systems only to trace down problems with the
USB/serial adapter and the host terminal emulation program.  Find some
computer with a real serial port and ensure it fails the same way.

On the other hand, many. many years ago when the 8xx uart driver was
written we added some delays during mode changes (which happens
during this phase of the log in) to ensure all of the CPM fifos were
drained
properly.  Again, this wasn't exactly the SMC problem, but shifting out
bits
that didn't look proper messed up the host serial interface.  Maybe
during
all of the recent updates to the drivers people "optimized" things not
knowing
their effects.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
