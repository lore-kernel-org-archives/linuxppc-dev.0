Message-ID: <37F4DE03.F884047C@chpc.utah.edu>
Date: Fri, 01 Oct 1999 10:14:59 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
References: <Pine.LNX.3.96LJ1.1b7.990929021435.16135B-100000@ofey.inetnebr.com> <4.2.0.58.19991001150704.03c6b230@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> At 22:00 29.09.99 , Lou Langholtz wrote:
> >I just locked up my system and had to reboot. The above change then
> >doesn't seem
> >to fix the system hangs. On the other hand I never did see the "FB. overflow"
> >message at least.
>
> Hmm, in the recent kernels Paul changed the code to only print the FB
> message once! For me these lockups (I'm using vger nearly unmodified) are
> gone since quite a while, but I don't really know a reason why. The major
> specialties on my 7200/75 are:
>
> - disabled syslog's fsync'ing of /var/log/messages (this prevents the
> amplifying effect of the FB messages)
> - all major stuff is compiled with gcc-2.95.2pre
>
> Franz.

thats good to hear. you're using a kernel newer than 2.2.12 which has the fixes
i've been experimenting with plus others. like only printing the fb overflow
message the first time it occurs in the sequence rather than all the time. the
overflow may still be occuring but the message wont keep getting printed. this no
doubt makes a few things more usable but by itself shouldn't prevent the tcp slow
down to nothing over ppp nor the complete lock up. there's also a kernel memory
routine that has some ppc specific fixes to it which seems to greatly imprive ppp
performance. 2.2.12 still has some sti() calls in macserial.c which look
suspicious. the newer code has gotten rid of at least some of those and i'm now
running a kernel that has none of those in macserial.c. this seems to be running
much better but i haven't run long enough to have a high confidence that that was
particularly problematic.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
