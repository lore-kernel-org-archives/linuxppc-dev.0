Date: Sat, 5 Aug 2000 22:20:05 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question 
In-Reply-To: <200008060231.WAA22602@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000805220927.649I-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Aug 2000, David Edelsohn wrote:

> 	I would guess that for smaller numbers of cases, GCC is deciding
> that it is more efficient to use a series of "if" statements for a
> decision tree instead of a switch statement.  You can explicitly code it
> as such, e.g.,
>
> if (bi->dispDeviceDepth == 32)
> ...
> else if (bi-dispDeviceDepth == 16)
> ...
> else if
> ...
> else abort();

Ah, that works, though the code doesn't work for some other unknown
reasons now, probably due to something along the line of things Olaf was
talking about recently.  Thanks!

Is there other kind of C constructs besides a switch statement which uses
.rodata or some such internally that you know of?  If the use of .rodata
is explicit like for the case of printk("I'm in .rodata."), we can fix the
reference dynamically pretty easily, but not the internal one like for the
case of a switch statement.

> (BTW you do not provide a default case for some illegal value in your
> switch statement.)

The default action is to do nothing, so there is no default case in there.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
