Date: Thu, 20 Apr 2000 23:58:46 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ron Flory <ron.flory@adtran.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: char type is unsigned with PPC gcc?
In-Reply-To: <38FF3543.19894457@adtran.com>
Message-ID: <Pine.HPX.4.10.10004201926010.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 20 Apr 2000, Ron Flory wrote:

> Hi-
>
>  Despite the strongly worded exchanges, this isn't really a big deal.
> We all have opinions, which is good.  So long as the compiler lets us
> config it the way we think it should be, then I'm happy.

Well,

>  There are some problems with chars having different signed'ness, such
> as many of the GNU tools not compiling correctly on some platforms
> though-

Indeed, I know this but there are cases where setting -fsigned-char
actually was a way to hide a bug:

http://lists.linuxppc.org/listarcs/linuxppc-dev/200003/msg00528.html

I don't know how frquent this case is, but I strongly suspect that is is
not an isolated one.

>  Ummm, endianness has nothing to do with bit ordering from MSB->LSB, it
> refers to the order BYTES (or the minimum quanta of assessable data) are
> ordered in memory when accessing multi-byte values.  On big-endian
> machines the 2-bytes value 0x1234 is stored sequentially as 0x12, 0x34,
> whereas little-endian machines store it at 0x34, 0x12.  Notice the bits
> in these bytes are not 'mirrored' as you suggest.

No, bit and byte ordering have to be consistent. Otherwise you end up with
the 68020+ mess, where a bit field one bit wide is not the same as a
single bit. I've not suggested anything about any kind of mirroring or so,
but perhaps did I not express myself clearly.

>  All CPUs I'm aware of (even the PPC) correctly refer to the LSB as
> being the rightmost bit, being consistent with the conventions of number
> theory and representation, however the PPC is (almost) unique, and
> incorrect in labeling the LSB as D31 instead of D0.

You've never seen a NS32000 documentation from the mid-eighties then:
all instructions encodings were show in binary starting from the LSB on
the left side. So 01101001 was 0x96 !

And claiming that the PPC is unique in this respect is simply grossly
incorrect...

> > Brain damage is believing that the fact that bit n represents 2 to the
> > n has any advantage or mathematical weight.
>
>  Actually not.  The association of data bits Dn as representing 2^n is a
> fundamental identity in computer science, electrical engineering, and
> mathematics.  A binary numerical value is defined as a polynomial of the
> form 2^n-1 + 2^n-2 + n^n-3 + .... 2^0.  The fact that IBM chose to
> ignore Mr. Boole's work is an unfortunate historical oversight that we
> are stuck with.

It is is not fundamental by any stretch of the imagination, and this
relationship is a mere superficial convenience as Dan Malek explained much
better than I would.

>  That's OK, I wish you well.  I've got this out of my system now...  ;)

Actually, I believed in all what you claim about polynomials and so on a
long time ago, then I thought deeply and now I've seen the light...

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
