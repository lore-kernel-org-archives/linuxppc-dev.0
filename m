Subject: 8250 IDMA TX problems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 27 Feb 2003 18:23:03 -0800
Message-ID: <BD92DBD34D62AC4FA034933E33E53F7E172451@grog>
From: "Penn, John" <jpenn@magisnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

After searching the archives I still have a few basic questions.  I am
using an
8250 Hip 4 Rev A.  Linux kernel 2.4.19 with a few patches.

I am trying to get IDMA working to transfer data between the 60x system
memory
and a device on the local bus.  I am using DREQ and nDACK for TX, RX
will come
later.

When I send a start command for IDMA3 to the CPM my serial port locks
up.  I have
Initialized all the IDMA registers and loaded up 1 buffer descriptor
with the
LAST and WRAP bits set.

Using a BDI 2000 debugger I can access the 60x bus and it seems to be
working.  The
error registers of the CPM also don't show any info.

The nDACK signal never asserts either and data does not seem to be
written into the
DPM transfer buffer.  I checked DREQ and it is asserting though I am
usually locked
up before this event.

Some info:
   RCCR = 		DR3M - DREQ 3 is level sensitive
			DR3QP - DREQ has lowest priority
					than the comm. controllers

   DCM = 		FB - Dual address mode
   			DMA_WRAP - size of IDMA 3
					transfer buffer = 2048 bytes
			SINC - source addr increment
			ERM - External Request Mode
					CP responds to DREQ
			S/D - Read from memory, write to peripheral


1.	Has anyone used IDMA on an 8250?  The 8250 and the 8260 are
supposedly
	the same die so this functionality should be there, so I was
told.

2.	Has anyone managed to get IDMA working between 60x memory and a
	peripheral on the Local Bus using DPM for :
	a. BDs ?
	b. IDMAx Parameter Ram ?

3.	Should I switch to local bus ram for BDs?

4.	Should I use local bus ram for the data buffers?

5.	For a write transaction I am using the following values :
	SS_MAX = 2048-32;
	STS = 2048-32;
	DTS = 4;			// The peripheral port is 32
bits.

	2048 is the largest packet I will ever transfer.

	Do these values look ok?


Thanks for the help,

John Penn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
