Date: Sat, 3 Feb 2001 11:14:27 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010203111427.B15855@allspice.cs.swarthmore.edu>
References: <20010130165710.B22219@allspice.cs.swarthmore.edu> <B69DFE88.9197%bootc@worldnet.fr> <20010201115015.A11149@allspice.cs.swarthmore.edu> <20010202023834.A17159@allspice.cs.swarthmore.edu> <14971.34502.222006.311092@diego.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14971.34502.222006.311092@diego.linuxcare.com.au>; from paulus@linuxcare.com.au on Sat, Feb 03, 2001 at 03:19:18PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 03, 2001 at 03:19:18PM +1100, Paul Mackerras <paulus@linuxcare.com.au> wrote:
> Daniel Eisenbud writes:
[...]
> As I said, it's been a while, and what I don't remember is whether the
> mesh gives you a phase mismatch interrupt if you tell it to receive
> data (do an IN operation) when the target also expects to receive data
> (i.e. do an OUT operation).  I have a vague idea that it might do so
> in PIO mode but not in DMA mode or something.  It's quite believable
> that the whole thing would lock up in this situation.

Ah.

> > There are still some issues outstanding:
> > 1)	The same table is duplicated in five or six drivers.  I think it
> > would make lots of sense to have a macro for the case statment in just
> > one place.  Should it go in scsi.h?  Or its own new file?
>
> Well, it could be declared in scsi.h but the actual table of values
> should go in a .c file.

My current patch has a static function in the new file scsi_dataout.h,
which is included by all the drivers in question.   But I agree that it
would be cleaner to declare the function in scsi.h, change
scsi_dataout.h to scsi_dataout.c, make the function no longer static,
and tell make about the dependencies.  I'll do that.

> > 3)	It continues to be worrisome that the mesh driver doesn't handle
> > aborts right or retry lost arbitration (nor does mac53c94.)  Is there
> > anywhere that the way to do these things is documented?  I'm willing to
> > try my hand at fixing them.
>
> I was never sure exactly how the higher levels of the scsi code
> expected the host adaptor drivers (like mesh.c) to do aborts.  At the
> time I tried to read the code but I found it to be quite opaque; it
> was very complicated and not very well structured.  I haven't looked
> at it lately, although I know Alan Cox was trying to tidy it up a bit
> at one stage.

I'll take a look...

> I thought the mesh driver did retry lost arbitration though.

The comment at the top of the file says that it doesn't, but that's as
far as I've investigated so far.  It may be that you just didn't get
around to changing the comment?

> If you want to try to fix the problems and implement the aborts and
> resets properly, that would be great.  You would at least need a copy
> of the SCSI-2 standard (or at least a late draft) plus the "Macintosh
> Technology in CHRP" document.

Are these available on the net, or would I have to order paper copies
from somewhere?

> > A quick patch will follow in the morning, and based on people's opinions
> > about issue 1 above, I'll make a more definitive patch to send to Linus
> > and Alan Cox and whoever one sends these things to.
>
> I would very much like to see the proposed patches before they are
> sent to Linus & Alan.

I'll be glad to show them to you first.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
