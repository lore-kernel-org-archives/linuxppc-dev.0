Date: Thu, 22 Jun 2000 15:50:20 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Pavel Roskin <proski@gnu.org>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <Pine.LNX.4.21.0006221532500.6246-100000@sunapee.transcept.com>
Message-ID: <Pine.LNX.3.96.1000622154358.10852D-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I figured it was something like that.  Shouldn't that expression be
testing the topmost address of the mmap'd region instead of one beyond it?

i.e.:

   if ( (off+len-1) < off )
	return EINVAL;


It works on the G3?  Perhaps the compiler/processor difference is getting
you into some of the 64-bit register goofiness or a slightly different
code sequence that does something different w/ the overflow flag.  Just
guessing here.

-Mark


On Thu, 22 Jun 2000, Pavel Roskin wrote:

>
> Hello, Mark!
>
> > If it _were_ extremely  important I could always trace the mmap system
> > call.
>
> I already know that it happens in do_mmap(), at this point:
>
> /* offset overflow? */
> if (off + len < off)
>         return -EINVAL;
>
> I'm puzzled why it doesn't happen on G3.
>
> > _That's_ why Linux is so cool.
>
> Yup.
>
> Pavel
>
>
>


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
