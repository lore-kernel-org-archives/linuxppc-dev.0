From: ckrobins@rockwellcollins.com
Subject: SCSI Host Adapter configuration question
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 19 Oct 2001 14:02:42 -0500
Message-ID: <OFC683C7DD.17A98E05-ON86256AEA.00647739@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can a SYM53C825a SCSI host adapter be configured to talk to a wide SCSI
disk drive using a narrow SCSI interconnect.

I have a Motorola MVME-3604 processor card with the MVME-712M transition
      module attached.    The primary SCSI host
adapter chip for the '3604 is a SYM53C825A and its SCSI interface is routed
      to the '712 module as a narrow SCSI bus
terminating with a 50-pin Centronics connector.

I am trying to add an external SCSI disk to this system as a second
      filesystem - the card boots from a ramdisk.

I have tried 3 different external SCSI disks with this and 2 of the 3 fail
      because of a SCSI parity error.

The 2 disks that generate SCSI parity errors are a Seagate ST32550W and a
      Seagate ST318405LW
The disk that doesn't generate SCSI parity errors is a Seagate ST34371N

After checking these on Seagate's website, I find that the disk that works
      has a narrow SCSI interface (the N suffix) and
the two that don't are wide SCSI interfaces.

I have checked the cabling and terminations carefully and have, where it
      was possible, used the same cables and
terminations in both the working and non-working setups.

My SCSI driver is the sym53c8xx ver 1.3g and the linux distribution is
      2.2.12 modified with Gabriel Paubert's patches for
the MVME2604 (the 3604's predecessor)

This paragraph is speculation on my part - if it doesn't work this way
      please don't be afraid to set me straight.  -  I believe
that the autoconfiguration being done at boot is assuming that if my disk
      has a wide SCSI interface and my host
adapter can support a wide SCSI bus, then it should configure for wide
      SCSI.    Problem is, the interconnection is only
8 bit, not 16, and I can imagine that a parity error is easy to get if you
      can only read half of the bus.     The narrow SCSI
disk would cause the host adapter to configure for narrow SCSI and
      therefore the parity test would pass.

Here's the question:

Can I change the driver's parameters to force it to configure a narrow SCSI
      bus regardless of the disk's interface type?

Thanks for your help

Regards,
Craig Robinson  (ckrobins@rockwellcollins.com)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
