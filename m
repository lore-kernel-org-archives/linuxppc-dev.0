Date: Wed, 22 Mar 2000 17:49:58 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        anthony tong <atong@uiuc.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128
  and Rage128Pros
In-Reply-To: <Pine.LNX.4.21.0003212046350.1173-100000@idd-01.imbc.gr>
Message-ID: <Pine.HPX.4.10.10003221746060.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, Kostas Gewrgiou wrote:

>   The current code always assume that the ROM is a BIOS one, the 2 bytes
> that it checks in the beggining are probably present in OF ati cards as
> well so it thinks that everything is ok, we need to know if the card has
> an OF rom or not (this is needed for other places in xfree as well the
> int10 module will try to softboot OF cards also), i am sure there is a way
> to find this i'll check the OF docs and see if i can find something.

All ROMS start AFAICT with 0x55,0xaa (or the other way around) followed by
a byte which gives the size of the ROM in 512 bytes blocks. On x86 the
entry point is at offset 0x03 and is always a jump (at least I have never
seen a board in whichit was not a jump), the opcode of which is 0xe9 or
0xeb. Could this be used as a test or as at least an heuristic ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
