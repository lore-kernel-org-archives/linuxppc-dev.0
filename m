MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: SDRAM is finally working
Date: Mon, 11 Feb 2002 13:42:30 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096A65@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

I now have Linux kernel booting up and mounting a file system without any problems.  I had all the timing right but my SDRAM initialization was messed up. My init sequence was missing a single NOP command at the very start. And so, things worked fine with PPCBOOT but with more memory intensive stuff that the kernel does, I had software emulation errors during the  kernel boot.

I appreciate all the help from Wolfgang in doing this. I got my very first SDRAM interface working on the 855 processor.

I would like to point out to everyone in this mailing list that there is an App. Note from Motorola (ANxxx/D) that talks about a high speed SDRAM interface to the MPC823. The document is a good start for anyone trying to interface the 8xx processor to and SDRAM while running the bus at speeds greater than 50Mhz. But please NOTE that the timings shown in the example SDRAM interface in this App. Note for the Micron MT48LC* chip are very wrong. Please do not design your timing around this example.

I looked at the sample timings from various board supports in PPCBOOT (eg. hermes). I manually inserted these timings into an *.mgp file for the MCUinit utility and looked at them in the GUI interface. But the final timings are totally dependent on your particular SDRAM chip ( The fact which Wolfgang tells us about all the time ;) ).

Navin.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
