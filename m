Date: Tue, 19 Nov 2002 11:11:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd
Message-ID: <20021119181107.GD779@opus.bloom.county>
References: <3DD3C747.8B7EE5CD@opensource.se> <20021114174807.GC605@opus.bloom.county> <3DD4E271.16FA374A@opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DD4E271.16FA374A@opensource.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 15, 2002 at 01:02:57PM +0100, Magnus Damm wrote:

> > Can you give more information about where everything is loaded up at?  I
> > thought this was a non-issue, but it's been a while since I tested
> > initrds.
>
> Sure.
[snip]
> this mail says something about typos or misuse of _ALIGN().
> http://www.geocrawler.com/archives/3/8358/2002/9/0/9715261/

I _think_ this is intentional, ie make sure we have bigger than needed
alignments, possibly to try and avoid what we've hit here.

> If _ALIGN() now is used correctly, then the align definition
> maybe chould be changed from
> #define _ALIGN(addr,size)        (((addr)+size-1)&(~(size-1)))
> to
> #define _ALIGN(addr,size)        (((addr)+(size)-1)&(~((size)-1)))
> to make sure that size is treated correctly. Or maybe it's a feature. =)

Fixing that now, thanks.

> Second example:
[snip]
> I have not been able to output the value of zimage_size for this case, but I'm
> sure that my initrd gets overwritten with the bi_record at 0x00200000.

Yeah, I'm sure too.  Here's an untested patch vs current
linuxppc_2_4_devel, which will relocate the initrd if needed.  The
current bi_rec code in the kernel shouldn't care if the initrd is moved
(This was broken in the past and then pointed out / fixed later, so I'm
rather confident of this part :)) so it should be OK.

For 2.5, I'm pondering going back and re-reading all of the discussions
and maybe even starting on it, with an arbitrary location for the
bi_recs which would let this case be much simpiler.

> Another thing - why is the second argument (dstlen) to gunzip() always 4 megabytes?
> Maybe it could be set to the address that the image is loaded at / relocated to?
> (0x180000 above) That way the gunzip function wouldn't overwrite the running code,
> if I understand the dstlen argument correctly that is.

I'm not sure about this part.  Tested patches are welcome of course. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
