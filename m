Date: Fri, 6 Feb 2004 17:45:17 +1100 (EDT)
Message-Id: <200402060645.RAA20828@sprint.tenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Interrupts on PPC 405Gr
From: "MERRITT Nigel" <Nigel.Merritt@tenix.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Solved it.  For your information...

When calling request_irq, the irq number had to be 30, which is the bit
in the UIC0_ER register that needs setting.  I was passing it 5, which
is the IRQ I wanted setting.  When I changed the IRQ number to 30 it
worked!  I'm not sure if this is a screw up on my part for not passing
the correct value in the first place, or an error in the Timesys kernel
(surely the number passed in should be the IRQ required, not the bit
position in the UIC registers).

Nigel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
