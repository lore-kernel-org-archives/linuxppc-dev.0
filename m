Message-ID: <40E54869.4070908@iti.fi>
Date: Fri, 02 Jul 2004 14:35:05 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Lite5200 CoralP issues
References: <20040702085145.0A0C9C109F@atlas.denx.de>
In-Reply-To: <20040702085145.0A0C9C109F@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <40E514DE.6020300@iti.fi> you wrote:
>
>
>>>This is why we implemented an accelerated X11 driver for the Coral-P.
>>>
>>>
>>>
>>I should try this new one. With the older one i have some problems with get all required
>>virtual console etc drivers to compiled to kernel to make Xfree 4.4 happy. Ok, now
>>there looks a like to be icecube_5200_CoralP_defconfig
>>
>>
>Yes, this is what we use for testing. It requires  a  USB  mouse  and
>keyboard to make the X11 server happy.
>
>
>
I took as test the yours uImage-LITE5200 kernel etc. It booted up
nicelly with newest
CVS snapshot with console text to CoralP display.

But still starting X it says "can not open free VT". As i earlier wrote
on list, there is even hard coded
in Xfree sources that it tries open /dev/tty0 with following strace results

open("/dev/tty0", O_WRONLY)             = 4
ioctl(4, 0x5600, 0x101b6eb0)            = -1 ENOTTY (Inappropriate ioctl
for device)

The problem is that /dev/tty0 looks a like to be hardcoded to
"xf86OpenConsole(void)" in xfree86 lnx_init.c and
it is called unconditionally from xf86Init.c . I have not found any
switch to switch console off from xfree86
config files. Also linkig /dev/tty to /dev/null or /dev/vcs0 etc does
not help, it just replaces
"can not open" error with "Cannot find a free VT".

How you get avoid this one ?

>>May be it is worth to try use QT with X11 server instead using embedded qt direct to
>>fb device. In older driver it was anyhow much better to use embedded qt direrctly.
>>
>>
>
>We have standard versions of Debian  and  YellowDog  running  on  the
>LITE5200, so Qt embedded should be pretty straightforward, too.
>
>
The largest problem is to make minimun set that fits in a Flash memory
with enough functions.
I think that i am still missing something important why i can't get X
running with CoralP drivers.
It needs something and i should find out what is needed. If there is
full yellowdog, then
you have 99.9% extra for most embedded systems.

OK, there is two ways, take YDL and start strip it down untiull it stops
working
or then find out every dependensy that is needed to get minimun system
running.
I think that is better to find out and understand these dependensies.

The Embedded QT runs easier because there is less dependensies to some
strange things
but now with accellerated coralP driver there is reason use X server.

Finally anyhow in embedded systems there should be GUI that works
without any dependensies
to mouse/keyboard

Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
