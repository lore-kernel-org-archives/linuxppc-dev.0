From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15300.58365.841260.79702@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2001 10:12:45 +1000 (EST)
To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed solution for interrupt mapping on CPCI and PPMC CPU ports
In-Reply-To: <0110092014.AA22503@ivan.Harhan.ORG>
References: <0110092014.AA22503@ivan.Harhan.ORG>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov writes:

> Here then is the solution I propose for the world (I'm going to publish it as a
> spec). It goes like this. Anybody who makes a PPMC carrier board or CPCI
> backplane provides an INTMAP.TBL file (in the specified format) with it
> describing its interrupt map. INTMAP.TBL is 84 bytes long, 4 bytes for each AD
> line from 11 to 31. The first 4 bytes correspond to AD11, the next 4 to AD12,
> and so on, the last 4 bytes correspond to AD31. Each such 4-byte record
> describes the interrupt routing for the device whose IDSEL line is connected to
> the corresponding AD line. The 4 bytes correspond to that device's INTA#,
> INTB#, INTC#, and INTD# lines in this order. Each byte says how will this
> interrupt be presented to the monarch PPMC or the plane in the system slot.
> Values 01 through 04 correspond to the INTA-D# lines on the monarch PPMC or
> CPCI system slot connector respectively, value 00 means no such interrupt, and
> all other values are undefined.

Sounds OK, but I wonder why you want a binary format rather than
something more easily human-readable?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
