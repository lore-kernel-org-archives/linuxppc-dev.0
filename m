Date: Thu, 31 Aug 2000 09:52:23 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm in OF? YES!
In-Reply-To: <200008302138.XAA00750@piglet.grunz.lu>
Message-ID: <Pine.HPX.4.10.10008310935230.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, Michel Lanners wrote:

	Hi,

> Yep, it works! I can boot off mesh again ;-)

Glad it helped...

> > ok code ictc@ ok 979ffffc l, 7f99faa6 l, 4e800420 l, ;code
> > ok see ictc@
> > code ictc@
> > edcc5c     stwu    r28,-4(r31)
> > edcc60     mfspr   r28,spr1017
>
> 1017 is actually l2cr, but never mind...

Right, anyway the 603e has neither ictc nor l2cr so I presume it would
work in ay case...

> >> How do you terminate a 'code' sequence?
> >
> > Oops, forgot about it, my bad. With ';code', isn't it obvious ?
>
> Hm, doesn't work in Apple's OF 1.0.5. end-code is the answer ;-). Here
> is my ictc! implementation, if anyone's interested:

You've just got to love OF portability across machines and architecture
independance :-( Add to this the fact that I have somewhere a FirmWorks
document which claims that on PPC the top of the stack is always in r28,
r20/r21 are scratch registers. r31 is still the stack pointer (and r30 the
return stack AFAIR).

>
> code ictc!
>         7e9bfba6 l, 829f0000 l, 3bff0004 l, 4e800020 l,
> end-code
[snipped]
>
> 11 ictc! slows this loop by a factor of 4.
>
> Now, go figure why this helps the MESH driver... It seems to use some
> busy loop timing somewhere; however there is the ms word available which
> uses the timebase and is accurate even on my upgraded box.... That would
> have been the better choice, unless the driver uses sub-1ms loops. Which
> would explain...

Indeed, to find it you might simply try to `see' all the words in the mesh
driver, but it may be large. BTW there is another interesting word in my
OF (apart from the even more interesting bugs ;-)):

' some_word .calls

will show all Forth words which call some_word (with a few false positives
to make things more entertaining). Does Apple's OF have something similar
or is it also crippled ?

> Anyway, thanks for your help, Gabriel!

De nada.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
