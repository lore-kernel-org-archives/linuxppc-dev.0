In-Reply-To: <Pine.LNX.4.03.9812301219080.15589-100000@mercator.cs.kuleuven.ac.be>
Date: Wed, 30 Dec 1998 12:35:59 +0100
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: grackle, patches, MMU, ...
Message-Id: <19981230123559.019295@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 30, 1998, Geert Uytterhoeven
<Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

>Grackle is the host bridge, right? In that case it's always device 0 / bus 0.

Yep.

>But for user space, we're still stuck with a normal mapping. And there speed
>is
>more important, I think, since most people (R5 installers? :-) run X and
don't
>use the text console that much.

Yes, having a way to use BATs for large user-space mappings would be a
benefit for framebuffer and also for other devices like frame grabbers.
I'm not familiar enough yet with the user-side MM stuff to implement this
now, but if no one does it, I'll try it as soon as I have undersood
enough things there.

BTW. Geert: Since you are working on m68k too, do you know if linux-m68k
uses the same adb code as linux-ppc ? I'm working on a new adb.c/.h,
which cleans up things (especially "hook-like" entry points to the
controller by exporting functions for registering hardware controllers
(via a structure with function pointers)) and for registering devices
(also a structure with function pointers with more entrypoint to allow
proper re-probing when a bus reset is done for example) and I would like
to know if there are risk I break m68k while doing so. Currently,
adb.c/.h is in arch/ppc but I don't know if vger is the main repository
for m68k too or not


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
