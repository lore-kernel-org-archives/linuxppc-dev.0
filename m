From: "Joe Dery" <jedery@mtu.edu>
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 14 Feb 2001 08:58:14 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Big vs. Little endian was Re: Walnut user-space software problem
Message-ID: <3A8A48A6.25364.B8424@localhost>
In-reply-to: <3A89435B.4A4515E9@Ferrari.DE>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


So is there a FAQ or HOWTO on the issues involved in porting
little endian to big endian software somewhere ?  I haven't seen
it yet after some looking.

Thanks
Joe Dery

> Hi Joe,
>
> > My senior design group is working with a IBM Walnut board
> > with the 200 MHz 405GP r3.  We have the linux kernel and
> > target filesystem taken from the Nov. 26, 2000 sources.
> > The board boots Linux from NFS flawlessly after compilation
> > using the CDK 1.0 8xx toolkit.
> >
> > Our project objectives include  compiling the ITU-T G.723.1
> > (Voice over IP) standard C source code.  We are (again) using
> > the powerpc-linux-gcc included with the MV CDK 1.0 tools for
> > PowerPC 8xx-based machines.
> >
> > I understand that an updated devkit is available, but since
> > our budget cannot touch the subscription fees needed to
> > obtain the MontaVista toolkit for the 405GP.
> >
> > Enough background already.  The problem arises in that
> > when we compile the VoIP source code and run it on the
> > PowerPC, the output of the encoder and decoder is wrong.
> > When the same code is compiled for our host machine
> > (using i386 gcc) the output is ok.  This C code involves a
> > lot of speed-oriented fixed-point mathematics - that is, a lot
> > of multiplies and shifts (to avoid divides)  Just searching for the
> > >> and << operators in the kernel source doesn't bring up much.  So
> > to me this may be the culprit.  Sorry to make this so vague - I am
> > just hoping that someone has seen problems with math/DSP oriented
> > programs before and can suggest something!
>
> If I had to put money on a bet where the problem might be located I
> would say your VoIP en-/decoder program is not written properly for a
> big endian machine. Especially reading data from/writing to memory via
> pointers can cause all kinds of errors. Please find a known good big
> endian machine somewhere and see if the algorithms work properly. If
> not kick the developer of the beast and fix it. I've seen a lot of
> integer DSP code to break when ported from little to big endian.
>
> Don't blame CPU or compiler too early, C doesn't abstract endianess
> issues completely - so they might visible.
>
> > Also, I wanted to verify the size of the variable types in the
> > gcc compiler for the PowerPC.  Please correct me if I'm
> > wrong.
> >
> > int             - 32 bit signed integer
> > short   - 16 bit signed integer
>
> correct for PPC.
> short always 16
> long always 32
> long long always 64
> int = machine word size
>
> I hope I could point you in the proper direction,
> Rolf
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
