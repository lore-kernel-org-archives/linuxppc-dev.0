Message-ID: <3EDBE422.EFCD17E5@opersys.com>
Date: Mon, 02 Jun 2003 19:56:18 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
MIME-Version: 1.0
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bare bones filesytem using Karim's book
References: <995FF289C9D69747A09E4299264459540C109861@penguin.adic.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Brian,

Apart from what Wolfgang has already said, I would add the following
gotchas:
- Make sure the library you are linking your init to, whichever one it
may be, is actually functional. I have seen some glibc versions
compile fine and fail to work on the target. See the 4th paragraph
on p. 112 for an example. Suggestion: try a different C library
version.
- Your libs may not be properly located. Suggestions: try linking
your init statically.
- Try putting something else as init. Use the init= kernel boot param
to pass some custom statically linked program that does something
obvious (while(1) printf(...); for example) and check if that works.

brian.auld@adic.com wrote:
> Any quick thoughts on why this might be happening? To provide a comparison benchmark as I worked through this, I copied the (i) dev files, (ii) inittab and (iii) rc.sysinit from chapter 6 of the book (my "from scratch filesytem") to the ELDK stripped down target filesystem and this setup still boots.

Right, this sounds like a library thing. Though I may be wrong.

> Most of the above were left in as I felt they needed to be there or they were "required" sysVinit or initscripts, which I didn't want to remove...

Better watch out for having both sysVinit and BusyBox-init as Wolfgang
already pointed out.

HTH,

Karim

--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
