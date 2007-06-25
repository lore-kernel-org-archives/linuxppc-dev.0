Return-Path: <tmorrison@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Follow up on 4 Gig of DDR on  MPC8548E
Date: Mon, 25 Jun 2007 19:12:07 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E84E5@EMPBEDEX.empirix.com>
References: <mailman.1956.1182519826.2671.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D90108361D90@EMPBEDEX.empirix.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0310C3ED@ismail.innsys.innovsys.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Rune Torgersen" <runet@innovsys.com>, <linuxppc-dev@ozlabs.org>,
	<ltib@nongnu.org>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> 0x0000_0000 to 0xffff_ffff or do you have 64GB of mem...

4 GIG DDR Memory...that we say...there is 3 GIG for the moment...
=20
the LAW's are  setup in priority order - thus, if you have overlapping
regions (aka: PCI & DDR memory) the one with the lower #'d LAW
is the one it is mapped to....

>> If you have all physical mem in the first 32bit, where are your PCI
>> windows set?
>> And in modst cases the PCI devices (if they are bus-mastring ) need =
1-1
>> inbound mapping to be able to write to memory.

you can use the LAW's to remap anything to anywhere...
see above for priority - but in our case, we are mapping
the PCI/PEX/Local Bus to the last 4 GIG at a higher=20
priority LAW than the DDR...that is what the MPC8548=20
spec says how it works...and it does - if you don't tell
the kernel there is more than 2GIG (and ioremap that last
GIG to access the full 'other' 2 GIG...
=20
that is not the issue here....
=20
apparently after more investigations - it looks like there is something =
in the ext2 driver code
that is mal-adjusted....I haven't talked to the guy today who was =
looking at that - but the ext2
driver code that was openning a 'virtual file' / console - had some =
problems mapping that
space - again, my gut is telling me more stronger there is a problem =
with signed/unsigned...
now deeper in the ext2 code...

Am at the Freescale Technical Forum the next few days - if any of you =
guys
are down here in Florida...I am intending to track down a few freescale =
folk
on this issue...:-)
=20
Tom
