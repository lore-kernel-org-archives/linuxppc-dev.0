Message-ID: <38EE0267.FB881499@embeddededge.com>
Date: Fri, 07 Apr 2000 11:44:39 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Pavel Roskin <pavel_roskin@geocities.com>
CC: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > "Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x"

So, decode the address/instruction and see if it makes sense.

> The problem has gone after upgrading to the Montavista kernel (from their
> CDK 1.0)

Since I know something about both of your custom board designs, I
can say that the software is unlikely to be the trouble, although it
could affect the problem.  This exception is typical of custom designs
that haven't properly designed the external device interfaces to the
8xx bus.  I strongly suspect one of the external devices isn't working
correctly, and when the processor is executing code from DRAM it gets
some trash from the bus instead of the proper instruction.  After
something like this occurs, dump the memory at this address and check
to make sure what the processor claims to have executed is really there.


> However, I have no idea what caused the problem and whether it has been
> fixed.

If you haven't attached a logic analyzer, tripped the error, and verified
the bus timing you will never know what caused it.  Things like this
don't fix themselves :-).

These problems are sensitive to the instruction stream (the instruction
pointer, the instruction itself, and access to the device).  Moving the
code around may appear to "fix" the problem, but it is still there
waiting to happen once the product is shipping......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
