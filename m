Date: Thu, 20 Apr 2000 23:38:38 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@netx4.com>
cc: W4OQM@aol.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re^2: char type is unsigned with PPC gcc?
In-Reply-To: <38FF238C.C0DD8140@embeddededge.com>
Message-ID: <Pine.HPX.4.10.10004202249100.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 20 Apr 2000, Dan Malek wrote:

>
> W4OQM@aol.com wrote:
>
> > How about:
> >
> > #define BIT_8_OF_BYTE   (1<<0)
> > #define BIT_8_OF_WORD   (1<<8)
> > #define BIT_8_OF_LONG   (1<<24)
>
> Whoa there, youngster.....let the old man tell you a story.
> There is computing equipment in the world where a byte is not
> eight bits, a word is not two bytes, and so on.

Indeed, AFAICT the only way in (ISO?) C to know the bit size of an item is
to use CHAR_BIT*sizeof(type) (on Texas DSPs for example sizeif(int) is 1
and CHAR_BIT is 32, but it is only safe to assume 8 for portability).

There were (are?) machines baroque enough to not permit C to be
implemented with the usual conventions used for the other (FORTRAN, COBOL,
PL/1, whatever) languages (down to having to use a different character
size...)

> Left to right (big endian) bit numbering works just fine on
> these computers, as it does on all big endian machines.
>
> On big endian byte ordered machines, you also want big endian
> bit ordering.  If I load some address as a byte, word, long word
> or whatever, bit 6 is still bit 6.  You probably don't remember
> the bit instruction mess when Motorola added that to the '020......

That's the biggest blunder in the whole 68000 family design IMHO.

> If you had a programming language that supported bit array objects,
> how would you index the array?  How would that map into larger
> objects?

Exactly.

>
>
> > ...  Personally, the left-to-right bit numbering drives me nuts.
>
>
> That's because you are worried about the implementation details and
> not solving the data communication application.  Look at flow of
> bits through a data communication system.  Serial stream, left to
> right.  Start numbering bits anywhere, stop anywhere, left to right
> makes perfect sense.  Map any aribitary object on top of the bits,
> still makes sense.  Look at coding theory and the algorithms they
> write...left to right bit ordering.

Dan, brother ;-) I have the impression we are the only 2 people on this
planet (aliens anywhere ?)^W^W^W^Wmailing list thinking this way. But of
course we know that we are right ;-)

>
> The 2^n bit numbering is a mathematical convenience that can be
> easily hidden behind programming language macros or functions.  I have
> seen very little code make use of this convenience,

100% agreed...

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
