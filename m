Message-ID: <C08678384BE7D311B4D70004ACA371050B763346@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	PPCBoot <ppcboot-users@lists.sourceforge.net>
Subject: RE: MPC8xx, FEC and DP83847 !?
Date: Thu, 21 Mar 2002 09:49:33 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using a DP83846 with 857T FEC.  At the software
level, I am just using the plain fec.c, and it works for me.

One note (if you want details, I'll have to check with my
hardware guys and get back to you, but here's the gist):
The Motorola reference boards use port D for MII, but we
used PCMCIA/port A pins instead.  This caused us a bit of
trouble when bringing up the board, but the resolution
was that we had to clear PDPAR[UT], set ECNTRL[PIN_MUX]
and set UTMODE[SPLIT].  I pasted these few lines into
fec.c's init function and it works like a charm.



-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Thursday, March 21, 2002 5:37 AM
To: LinuxPPC; PPCBoot
Subject: MPC8xx, FEC and DP83847 !?



Hi there,

I am about to redesign my board and consider to replace Level One's
LXT971 with National's DP83847.

Is anyone using National's Phyter DP83846/7 together with MPC8xx FEC?
Is there support for this chip like it is for LXT97x, AMD79c874 and
QS6612?
Or do I have to use ./drivers/net/natsemi.c or somthing similar?

Are there any (dis)advantages over the LXT971?

Cheers,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
