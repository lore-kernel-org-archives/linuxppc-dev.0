Date: Mon, 08 Mar 1999 16:53:46 -0500
From: harry eaton <haceaton@aplcomm.jhuapl.edu>
Subject: Re: Segfaults in powerpc ld (binutils-2.9.1-19a)
To: Gary Thomas <gdt@linuxppc.org>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <36E446EA.A59B51B6@aplcomm.jhuapl.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <XFMail.990305211648.gdt@linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:

> On 05-Mar-99 harry eaton wrote:
> > Gary,
> >
> > I'm not sure what's going on.  My source was derived from
> > binutils-2.9.1-19a.src.rpm from linuxppc.org's
> > which was unpacked with
> > rpm -iv ../SRPMS/binutils-2.9.1-19a.src.rpm
> > rpm -bc bintuils.spec
> >
> > but the file doesn't match yours!  It looks most similar at line 2665
> > which originally looked like:
> > .. snip.

> Your source seems to have another hundred lines
> > that mine doesn't!!!
> > Of course I found this segfault problem with the linker from the binary
> > rpm.
> >
> > More ideas?
> >
>
> The patch came from code I have which is slightly different than the
> released binutils code, sorry.  If I have time, I'll try and give you
> a more complete patch.
>
> In the meantime, you might try just not using -Bsymbolic which seems
> to be the root of the problem.  If you're building a shared library with
> -fPIC, I don't think it's necessary.

I tried removing the -Bsymbolic and indeed that stopped the segfaults.
However the resulting files didn't work.  In particular when calling one of
the shared library routines, the caller puts the first argument into R3, but
the linker blows away R3 and the library uses R28 (or maybe the stack) to
retrieve its first argument (at least that's what gdb shows and it seems to
agree with the code behavior)  It's all pretty strange to me; I'll have to
look at the ABI again to get a sense of what's going on.  If the args were
supposed to be copied to the stack, they didn't make it correctly.  I also
tried the binutils-2.9.1-19b that you (Gary) made available recently - same
segfault problem when linking with -Bsymbolic.

harry




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
