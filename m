Message-ID: <395B9171.76934B4E@netx4.com>
Date: Thu, 29 Jun 2000 14:12:01 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FEC performance on the 855T/860T
References: <20000629120913.8045B5060C@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> .....The first bottleneck to stand
> out is that the FEC port isn't going as fast as we'd like.


We have discussed this before.  The FEC runs at 100 Mbits/sec,
back to back packets.  It has to....there isn't any buffer
space in the FEC to do otherwise.  The bottleneck is the protocol
and application processing in the PPC core.  The performance of
a TCP/IP connection scales nearly linearly with the processor
speed.

The 50 MHz 860P will run about 30 Mbits/sec TCP/IP, and a 100
MHz 860P will run about 60 Mbits/sec TCP/IP.  You can write
a program that will send back-to-back Ethernet frames at the
maximum rate, and will read and discard Ethernet frames at the
maximum rate.

Just write a program (nttcp works) to benchmark using the local
loopback device.  That will tell you what the processor can
accomplish.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
