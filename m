Message-Id: <v02140b01b2b1919b3cc8@[209.157.72.95]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 31 Dec 1998 13:13:35 -0800
To: "Timothy A. Seufert" <tas@mindspring.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
From: daver@idiom.com (David Ray)
Subject: Re: Test kernels for chipsfb (2400/3400)
Cc: Paul Mackerras <paulus@cs.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, I wanted to give an update with my pb2400 results with the latest kernels from Ben. My access to the computer & email is intermittent during these weeks but I had a chance to check out the builds available on 12.31.1998. I tried Ben's experimental build with extra changes to chipsfb.c and ADB changes, with the following results:

- video mode 16 has corrupted color on the console, but useable. Same results with nvvideo set to "color-mode-2" and "color-mode-3". Vmode 10 8 works fine.

- The Xpmac binary specially made for the pb2400/3400 would not run either in 8-bit or 16-bit mode. In both 8-bit and 16-bit the screen appeared to go black. In 16-bit there was a faint off-black appearance of xdm login screen but unusable. I tried it with nvvideo set to both "color-mode-2" and "color-mode-3", with no noticeable difference. Fortunately this Xpmac binary has a built-in kill switch with option-power, so it is easy to exit back to the console. This result is unusual because all other varianlts of kernel 2.1.130 allowed this Xpmac binary to work while the XF86_FBdev binary would not.

- The latest XF86_FBdev binary for LinuxPPC from the xfree86.org site works (for the first time ever on a pb2400) in 16-bit mode. But it is broken: the color balance is very corrupted.  I also tried this with nvvideo set to both "color-mode-2" and "color-mode-3", with no noticeable difference. Since 16-bit is also corrupted on the console, perhaps they are symptoms of a single problem. 

- Despite corrupted colors in X, I was still able to get around in X, see the cursor and type into terminal windows, etc. THE NEW TRACKPAD TAPPING CODE IS EXCELLENT!!!! Thank you!  To put it simply, this has almost the same trackpad behavior as the Trackpad Control Panel in MacOS 8.x. Thanks for providing the diff.


Before the holiday season I was compiling my own kernels with the latest patches for chipsfb.c but I haven't been able to keep up with t he latest over these last few weeks. Hopefully this email is useful in debugging the problems with chipsfb.c. I'll try to update myself next week.

-Dave


At 4:23 AM 12/24/98, Timothy A. Seufert wrote:
> At 10:00 AM +0100 12/23/98, Benjamin Herrenschmidt wrote:
> >I got a first round of feedback and I uploaded 2 new test kernels:
> >
> > <http://calvaweb.calvacom.fr/bh40/vmlinux_test3.gz>
> > <http://calvaweb.calvacom.fr/bh40/vmlinux_test4.gz>
> >
> >(the first one uses truecolor for chipsfb, the second directcolor). offb
> >is "fixed" to disable the ATI kuldge when not in 8 bits (apparently
> >breaks some models like PowerBook G3 Series) so "No video driver" should
> >work all the time again.
> 
> On my 2400, test3 works okay for the console (8 & 16 bit) and Xpmac3400 (16
> bit).  XF68FBDev is still screwed up in 16 bit, though -- the colors are
> all wrong.  Also, XF68FBDev repeatably crashes on the first attempt to run
> it after booting, but subsequent runs succeed.
> 
> I didn't try test4 because it failed to uncompress.
> 
> >Note that those kernel will do funny things with your ADB like
> >auto-setting handler IDs of mice to 2 or 4 (depending on what the mouse
> >supports) and detecting the powerbook trackball. All this is quite
> >verbose (lots of printks) and I would like to know if it breaks
> >something. The result of those changes should be that now, mice should
> >use better capabilities by default and mousemode should not be necessary
> >most of the time.
> >Note also that the trackpad tapping is partially implemented (you will be
> >able to click by tapping but sometimes it behaves strangely).
> >
> >I'll post cleaned up patches for all this later today or later this week.
> 
> I haven't tried to test any of these things.
> 
> I did notice that one thing was broken, compared to the 2.1.130 kernels
> I've been compiling for myself from the vger cvs tree.  Paul's "snooze"
> program does not successfully put the powerbook into sleep mode with your
> test3 kernel.  The screen blanks, but the sleep light never starts
> blinking, as if the machine hangs in the middle of the process of going to
> sleep.  Keyboard reset seems to be the only way out.  I looked at the
> source code for snooze and it's bonehead simple -- opens /dev/pmu, does a
> sync(), then uses an ioctl on /dev/pmu to sleep the machine.  So this must
> be a kernel bug.
> 
> 
> I'm going to be away from email the next few days for Christmas.  However,
> that also means I may have some spare time to try to work on patching up
> chipsfb to work for all situations myself.  I also went and printed myself
> a copy of the enormous C&T65550 datasheet, so now I have register specs for
> everything and may get brave and try to implement some acceleration
> functions for the console.
> 
>   Tim Seufert



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
