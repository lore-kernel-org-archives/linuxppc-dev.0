Message-ID: <3841AF8D.48EDE940@netx4.com>
Date: Sun, 28 Nov 1999 17:41:17 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Dan Malek <dan@penguin.netx4.com>, Christian Zankel <chris@mvista.com>,
        cort@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <Pine.GSO.4.10.9911261005360.29385-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> So what's wrong with the approach above?


Nothing....

> ...... All unused code will be optimized away
> by the compiler.


Maybe.  I haven't seen much dead code elimination by
the compiler.  I guess one of the bazillion compiler switch
combinations would do it.  I haven't found a good one yet.

> .... There's no difference between the first and the second
> version, except that the first one is more readable.

Well, OK.  Just to provide some history.  When I did the
first 8xx ports, I used #ifdefs to remove large portions of
PMac, Prep, and CHRP nested case statements instead of
trying to rewrite something that I had no ability to test.
By using the #ifdefs, I could almost guarantee I didn't
break something that already exists.  Although in some of
the files that contain the #ifdefs only a few lines of code
are conditional compiled, the big win was elimination of
function calls into other machine dependent files that
simply didn't have to be compiled.  I think the Makefiles
look worse than the C code.......It may be nice to dynamically
generate the Makefiles for the configuration rather than have
the "if" statements in those.

It has now become a little more difficult to handle, although
I have noticed others are starting to use more #ifdefs around
other machine dependent code.  If you want to support multiple
machines in one binary, define them and the code will support
it.  I don't think the code will ever support a single binary
to run on an 8xx (or 82xx) and a PMac.

I have seen some pretty bad code over the past 20 years of my
career, and this stuff isn't even close to bad.  That doesn't
mean I am not going to try to make it better, we just have
to do it carefully because any changes in these files affect
lots of people (and other files).  Just remember that one of
my goals is to build small as possible embedded software that
reduces Flash ROM requirements.  Carrying along stuff like
keyboard and ADB drivers just to resolve some symbols doesn't
help us do this.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
