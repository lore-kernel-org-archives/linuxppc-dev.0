Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b2a7ddd993aa@[209.86.155.175]>
In-Reply-To: <19981223100026.009089@mail.mipsys.com>
References: <v02140b00b2a6453f1cd9@[209.157.72.95]>
Date: Thu, 24 Dec 1998 04:23:21 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Test kernels for chipsfb (2400/3400)
Cc: David Ray <daver@idiom.com>, Paul Mackerras <paulus@cs.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:00 AM +0100 12/23/98, Benjamin Herrenschmidt wrote:
>I got a first round of feedback and I uploaded 2 new test kernels:
>
> <http://calvaweb.calvacom.fr/bh40/vmlinux_test3.gz>
> <http://calvaweb.calvacom.fr/bh40/vmlinux_test4.gz>
>
>(the first one uses truecolor for chipsfb, the second directcolor). offb
>is "fixed" to disable the ATI kuldge when not in 8 bits (apparently
>breaks some models like PowerBook G3 Series) so "No video driver" should
>work all the time again.

On my 2400, test3 works okay for the console (8 & 16 bit) and Xpmac3400 (16
bit).  XF68FBDev is still screwed up in 16 bit, though -- the colors are
all wrong.  Also, XF68FBDev repeatably crashes on the first attempt to run
it after booting, but subsequent runs succeed.

I didn't try test4 because it failed to uncompress.

>Note that those kernel will do funny things with your ADB like
>auto-setting handler IDs of mice to 2 or 4 (depending on what the mouse
>supports) and detecting the powerbook trackball. All this is quite
>verbose (lots of printks) and I would like to know if it breaks
>something. The result of those changes should be that now, mice should
>use better capabilities by default and mousemode should not be necessary
>most of the time.
>Note also that the trackpad tapping is partially implemented (you will be
>able to click by tapping but sometimes it behaves strangely).
>
>I'll post cleaned up patches for all this later today or later this week.

I haven't tried to test any of these things.

I did notice that one thing was broken, compared to the 2.1.130 kernels
I've been compiling for myself from the vger cvs tree.  Paul's "snooze"
program does not successfully put the powerbook into sleep mode with your
test3 kernel.  The screen blanks, but the sleep light never starts
blinking, as if the machine hangs in the middle of the process of going to
sleep.  Keyboard reset seems to be the only way out.  I looked at the
source code for snooze and it's bonehead simple -- opens /dev/pmu, does a
sync(), then uses an ioctl on /dev/pmu to sleep the machine.  So this must
be a kernel bug.


I'm going to be away from email the next few days for Christmas.  However,
that also means I may have some spare time to try to work on patching up
chipsfb to work for all situations myself.  I also went and printed myself
a copy of the enormous C&T65550 datasheet, so now I have register specs for
everything and may get brave and try to implement some acceleration
functions for the console.

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
