From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 17 Nov 2003 10:19:59 +0100
To: David Edelsohn <dje@watson.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>, Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Alan Modra <amodra@bigpond.net.au>
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031117091959.GA28611@iram.es>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com> <1068977831.681.8.camel@gaston> <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com> <1069024357.4760.14.camel@gaston> <200311162331.hAGNVjT29698@makai.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311162331.hAGNVjT29698@makai.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 16, 2003 at 06:31:45PM -0500, David Edelsohn wrote:
>
> >>>>> Benjamin Herrenschmidt writes:
>
> Ben> We surely don't want them on G5 at least as they are microcoded
>
> 	Again, one cannot approach this as black or white.  What about
> optimizing for size?

Using lswi/stswi is fine when optimizing for size, but I think
that using these instructions for the case of an 8 byte
move is wrong in most cases because an additional instruction
is often (but not always) needed to compute the address.

Moving 8 bytes with lswi/stswi:

	la rx,src # compute source address
	lswi 5,rx,8
	la ry, dst# compute destination address
	stswi 5,ry,8

Moving 8 bytes with standard instructions:

	lwz rx,src
	lwz ry,src+4
	stw rx,dst
	stw ry,dst+4

IMHO, lswi/stswi should only be used when the move
would be split into 3 or more l[bhw]z/st[bhw] pairs
(i.e., for sizes of 7 or 9 and up).

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
