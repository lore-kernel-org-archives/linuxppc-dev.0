From: jlquinn@us.ibm.com
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "D.J. Barrow" <barrow_dj@yahoo.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <852568D9.0050704F.00@D51MTA03.pok.ibm.com>
Date: Mon, 8 May 2000 10:38:38 -0400
Subject: Re: Help with cross-endian bitfields?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In this particular instance, the data is read from the board a short at a
time (which I don't think I've got control over), but being placed into
data that we see as chars.  So I've got to undo the swap.  Then, the data
that has been returned is encoded within several bits inside a char.  In
this case, mask and shift will correctly access the data.  In general, the
problem is pretty disgusting, it seems.  At least I know how the data is
packed to start with.  Without that, there doesn't seem to be much hope for
portable solutions.

It's a shame, because otherwise, bitfields are an elegant way to deal with
packed data.

Jerry Quinn


Geert Uytterhoeven <geert@linux-m68k.org>@lists.linuxppc.org on 05/08/2000
10:19:59 AM
On Mon, 8 May 2000, D.J. Barrow wrote:
> struct blah
> {
>    unsigned a : 3;
>    unsigned b : 3;
>    unsigned c : 2;
> } __attribute__(packed);
>
> I personally would be expecting to use ((*((u8
> *)&blah[0]))&0x0e0)>>5 to get the info from blah.a on
> both little & big endian machines.

Which no longer works if a is longer than 8 bits and/or spans multiple
bytes.
For PCI accesses, you can work around this by using {read,write}l(), which
do
byte swapping on big-endian platforms as well.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
