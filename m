In-Reply-To: <v04011700b2a7ddd993aa@[209.86.155.175]>
Date: Thu, 24 Dec 1998 18:27:06 +0100
To: linuxppc-dev@lists.linuxppc.org, "Timothy A. Seufert" <tas@mindspring.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Test kernels for chipsfb (2400/3400)
Message-Id: <19981224182706.019715@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 24, 1998, Timothy A. Seufert <tas@mindspring.com> wrote:


>I did notice that one thing was broken, compared to the 2.1.130 kernels
>I've been compiling for myself from the vger cvs tree.  Paul's "snooze"
>program does not successfully put the powerbook into sleep mode with your
>test3 kernel.  The screen blanks, but the sleep light never starts
>blinking, as if the machine hangs in the middle of the process of going to
>sleep.  Keyboard reset seems to be the only way out.  I looked at the
>source code for snooze and it's bonehead simple -- opens /dev/pmu, does a
>sync(), then uses an ioctl on /dev/pmu to sleep the machine.  So this must
>be a kernel bug.

Yep, this kernel is not really meant for everyday use, I just wanted some
feedback about the chipsfb. The sleep is broken because I'm working on it
(trying to adapt it to newer PowerBooks, unsucessfully for the moment)
and when I compiled those test kernels, the sleep code was a rest of some
tests I made and is absolutely not functional.
>
>I'm going to be away from email the next few days for Christmas.  However,
>that also means I may have some spare time to try to work on patching up
>chipsfb to work for all situations myself.  I also went and printed myself
>a copy of the enormous C&T65550 datasheet, so now I have register specs for
>everything and may get brave and try to implement some acceleration
>functions for the console.

Ok. The main changes I made were to add a compile option for either using
DIRECTCOLORS or TRUECOLORS. Since you disable the colormap in 16 bits,
then it's TRUECOLOR. If you don't it's DIRECTCOLORS.

In TRUECOLOR, you must have the code is setcolorreg update the cfb16 data
with the default colors. In direct colors, it should contain (regno <<
10) | (regno | 5) | regno. I'm sending you in a separate mail my modified
version of chipsfb.

I've not yet identified the problem with XFBDev and 15 bits, but I do
have the same pr oblem with my fixed offb.c too, I'll have a look at it.



-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
