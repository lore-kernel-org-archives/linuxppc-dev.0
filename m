From: "David Bryan" <Dave@ThePTRGroup.com>
To: "Michael R. Zucca" <mrz5149@acm.org>
Cc: "Rudy Klinksiek" <klink@arlut.utexas.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: "Illegal instruction" traps on smp clients - 2.4.19
Date: Thu, 27 Feb 2003 15:32:26 -0500
Message-ID: <NEBBLKDMGLOGOAOIDAIDMEMFEHAA.Dave@ThePTRGroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E5E584E.2020703@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael,

Certainly, be glad to...  however, I would make sure you fully understand
the operation of these bits and their applicability to your system.

On the 7400/7410 the MSSCR0 is accessed as SPR 1014.

At reset, the MSSCR0 is initialized to all 0s.

We OR'd 0x8000 with MSSCR0.

Bit 0 (MSB) controls whether the 7400 runs MEI or MESI coherency protocol.
Setting Bit 0 (SHDEN) causes the 7400 to implement "a 4-state MESI protocol
similar to the MPC604e family of processors".  Bit 1 (SHDPEN3) is valid only
in MEI mode, so its value is ignored when SHDEN is set.  In this
configuration, the 7400 will drive/sample the SHD/0/1 pins depending on the
bus mode (MPX or 60x).


Dave

David Bryan                www.ThePTRGroup.com
----------------------------------------------

-----Original Message-----
From: Michael R. Zucca [mailto:mrz5149@acm.org]
Sent: Thursday, February 27, 2003 1:26 PM
To: David Bryan
Cc: Rudy Klinksiek; linuxppc-dev@lists.linuxppc.org
Subject: Re: "Illegal instruction" traps on smp clients - 2.4.19


David Bryan wrote:
 > These modes are controlled by two bits in
> the Memory subsystem control register (MSSCR0).  At reset, the MSSCR0
> defaults to MEI mode with the SHD signal disabled.  By placing the 7400 in
> MESI mode at boot, we solved the problem.

Would you care to share what MSSCR0 bits these were and what you set
them to? :-)

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
