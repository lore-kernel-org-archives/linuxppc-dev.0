Message-ID: <38FF238C.C0DD8140@embeddededge.com>
Date: Thu, 20 Apr 2000 11:34:36 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: W4OQM@aol.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re^2: char type is unsigned with PPC gcc?
References: <c9.39dbd77.262faf77@aol.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


W4OQM@aol.com wrote:

> How about:
>
> #define BIT_8_OF_BYTE   (1<<0)
> #define BIT_8_OF_WORD   (1<<8)
> #define BIT_8_OF_LONG   (1<<24)

Whoa there, youngster.....let the old man tell you a story.
There is computing equipment in the world where a byte is not
eight bits, a word is not two bytes, and so on.

Left to right (big endian) bit numbering works just fine on
these computers, as it does on all big endian machines.

On big endian byte ordered machines, you also want big endian
bit ordering.  If I load some address as a byte, word, long word
or whatever, bit 6 is still bit 6.  You probably don't remember
the bit instruction mess when Motorola added that to the '020......

If you had a programming language that supported bit array objects,
how would you index the array?  How would that map into larger
objects?


> ...  Personally, the left-to-right bit numbering drives me nuts.


That's because you are worried about the implementation details and
not solving the data communication application.  Look at flow of
bits through a data communication system.  Serial stream, left to
right.  Start numbering bits anywhere, stop anywhere, left to right
makes perfect sense.  Map any aribitary object on top of the bits,
still makes sense.  Look at coding theory and the algorithms they
write...left to right bit ordering.

The 2^n bit numbering is a mathematical convenience that can be
easily hidden behind programming language macros or functions.  I have
seen very little code make use of this convenience, while the real
world data, mathematics, and computer science theory usually use
big endian bit numbering.

> ....  If God
> meant bit numbering to start on the left, she'd have started with 1.

You better read some of the bibles from the beginning of computer time.
Lots of smart people provided insights into these discussions a very
long time ago.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
