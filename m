MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: boot flash problem,
Date: Mon, 9 Dec 2002 16:42:29 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B9B@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Li Xiangrong" <lixiangrong@china.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Both time, i set the base address 0xffe00000, which
> means i can use a flash of 2M words here.

I don't think so.

The 32-bits address bus of the PPC is still
on a byte boundary, not on a word of 16 bits.

A 16-bits flash means the GPCM reads 16 bits at a time from
the data bus, and outputs addresses aligned on 16 bits.
Then you wire PPC:A30 to Flash:A0, PPC:A29 to Flash:A1, and so on,
leaving PPC:A31 unconnected.

Here, both flashes you specified are 16-bits wide,
so I understand the connections were compatible
between the 16MBits and the 32MBits,
with one more address line PPC:A10 wired to Flash:A20.

If you have a flash of 32Mbits (4MBytes), even if it has a port
size of 8, 16 or 32 bits wide, you will address it from your code
(running on the PPC) using an address range of 4MBytes also.

Thus, its base address should be at 0xFFC00000,
both in BDI and (very important) in the boot loader also.

Good luck,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
