Message-ID: <3D80D9E1.1020001@embeddededge.com>
Date: Thu, 12 Sep 2002 14:16:01 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Conn Clark <clark@esteem.com>
Cc: Alban Wood <awood@bloodwolf.org>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx fpu emu
References: <Pine.LNX.4.44.0209121107090.7728-100000@manoir.bloodwolf.org> <3D80D1F2.6FBAEFE6@esteem.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn Clark wrote:


> 	Unfortunatly I haven't tried using the fpu emulation,

The kernel fpu emulation works, it's just slower than using
the soft-float in the C library.

> .... I'm just
> relaying to you what I've been told when I pursued it hoping to save ram.

I wouldn't use the reason for trade off as memory savings.  The things
you trade are performance and "big brother" (those processors with floating
point) :-) binary compatibility.

> 	I don't know of anyone who has tried it lately,

I run some systems with kernel FPU and some without.  Just depends upon
the libraries and applications I have available.  Since most libraries
these days for the 8xx are built with soft-float, I tend to use that.
In this case, it doesn't matter if the kernel has the fpu emulation
option enabled or not.

The only bugs you will find is when you mix applications and libraries
that aren't compiled to match.  The function calling conventions are
different between the FPU enabled programs/libraries and the soft-float
programs/libraries.

Even when you don't enable the kernel FPU emulation, we still emulate a
few FP instructions.  This is to allow programs that use absolutely no
floating point to work with the generic FPU PowerPC libraries.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
