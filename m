From: "Ron Bianco" <ronb@junction.net>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using SCSI driver sym53c8xx.c - no nvram - no symbios BIOS
Date: Mon, 31 Jul 2000 16:24:52 -0700
Message-ID: <000001bffb46$8756d300$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone using a sym53c8xx family SCSI chip on their main board?  i.e. not on a plugin
PCI card with extra stuff.

I'm using the 53c895.
If there is no NVRAM or SCSI biosROM, then does one have to tune the driver by modifying
some #define's ?

I know there is a few things that the driver will use from the pci setup code, and that
this driver supports kernel command line options, for some stuff.  But I'd like to have a
proper default setup.

Right now I'm having trouble with ncr_getclock()  which is calling ncrgetfreq(),  always
reporting 0kHz.  I'm tempted to just force it to 40000khz which is the freq. of the osc
connected to the chip's SCLK input, but I'm not sure if this is the clock referred to in
the code. (NCR SCSI clock freq. )

This problem could also be due to a hardware problem, but the code detects the chip and
reads the config data OK.

Another problem I'm having is:  CACHE TEST FAILED: timeout.  I'm still tracing this.
I'm pretty sure I set a legal cache line size and latency in the sandpoint_pci.c config
code.

I shall forward this msg to the author of the driver tomorrow if no joy.

regards, Ron

Ron Bianco
Computer Systems Technologist
Level Control Systems
email: ronb@junction.net
phone: 250-549-2558 Ext 8
web:  www.lcsaudio.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
