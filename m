Message-ID: <3D889176.4070600@embeddededge.com>
Date: Wed, 18 Sep 2002 10:45:10 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Conn Clark <clark@esteem.com>, Alban Wood <awood@bloodwolf.org>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx fpu emu
References: <D8A0BB5A-CB12-11D6-AAF4-003065BFB10E@motorola.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kumar Gala wrote:

> Can you elaborate on this?  Why exactly is this done?  Is it because
> glibc has some minor FP code @ startup?

The best example is the setjmp/longjmp code and associated signal functions.
There is lots of assembly code in the C library specific to processors to
support this.  When you call some setup functions or use signals (in this
case) you will execute load/store FP instructions.

I originally added these minimal emulations so I could use the standard
PowerPC libraries even though I didn't do any floating point in the application.
It was also necessary to simply get a shell running :-)

Note 1, just because you compile libraries with -msoft-float doesn't mean
there won't be floating point instructions in the code.  You have to go through
the libraries and fix up all of the assembly code that may use floating
point instructions.

Note 2, don't ever mix real float instructions, soft-float libraries, soft-float
applications and kernel emulation.  Everything must properly match for context
switching and passing of arguments between functions.  A tempting combination
is an FP enabled library, minimal FP emulation in the kernel, and a soft-float
application to get maximum performance with minimal effort......don't do that,
it will not work.  Either use complete user-land soft-float, or real FP
instructions with complete kernel emulation.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
