Return-Path: <peter.hutterer@who-t.net>
Received: from mail.clearchain.com (leo.clearchain.com [199.73.29.74])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjl6z1V7QzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 09:26:18 +1000 (AEST)
Date: Thu, 8 Jun 2017 09:13:03 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Message-ID: <20170607231303.GB29224@jelly>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws> <20170528114758.52b619f2@neko>
 <20170528175540.GA8094@dtor-ws>
 <20170607185351.5fcd91df@kitsune.suse.cz>
 <20170607171622.GE13116@dtor-ws>
 <20170607211737.01888f04@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170607211737.01888f04@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 07, 2017 at 09:17:37PM +0200, Michal Suchánek wrote:
> On Wed, 7 Jun 2017 10:16:22 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Wed, Jun 07, 2017 at 06:53:51PM +0200, Michal Suchánek wrote:
> > > On Sun, 28 May 2017 10:55:40 -0700
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >   
> > > > On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek wrote:  
> > > > > On Tue, 9 May 2017 17:43:27 -0700
> > > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > >     
> > > > > > Hi Michal,
> > > > > > 
> > > > > > On Tue, May 09, 2017 at 09:14:18PM +0200, Michal Suchanek
> > > > > > wrote:    
> > > > > > > There is nothing mac-specific about this driver. Non-mac
> > > > > > > hardware with suboptimal built-in pointer devices exists.
> > > > > > > 
> > > > > > > This makes it possible to use this emulation not only on x86
> > > > > > > and ppc notebooks but also on arm and mips.      
> > > > > > 
> > > > > > I'd rather we did not promote from drivers/macintosh to other
> > > > > > platforms, but rather removed it. The same functionality can
> > > > > > be done from userspace.    
> > > > > 
> > > > > What is the status of this?    
> > > > 
> > > > The same as in above paragraph.
> > > >   
> > > > > 
> > > > > Do you reply to every patch to drivers/input that is not the the
> > > > > core infrastructure that you would rather drop the driver
> > > > > because it can be done is in userspace?
> > > > > 
> > > > > It sure can be done. Remove everything but the bus drivers and
> > > > > uinput from drivers/input and the rest can be done in userspace.
> > > > > 
> > > > > The question is who does it?
> > > > > 
> > > > > Are you saying that you will implement the userspace
> > > > > equivalent?    
> > > > 
> > > > No, I spend my time mostly with the kernel.
> > > >   
> > > > > 
> > > > > If not then please do your job as maintainer and accept trivial
> > > > > patches for perfectly working drivers we have now.    
> > > > 
> > > > I am doing my job as a maintainer right now. The driver might have
> > > > been beneficial 15 years ago, when we did not have better options,
> > > > but I would rather not continue expanding it's use.
> > > > 
> > > > The main problem with the driver is that the functionality it is
> > > > not easily discoverable by end users. And once you plumb it
> > > > through userspace to present users with options you might as well
> > > > handle it all in userspace.
> > > >   
> > > > > 
> > > > > If you want to move drivers/input into userspace I am not
> > > > > against it but I am not willing to do that for you either.    
> > > > 
> > > > Then we are at impasse.
> > > >   
> > > > >     
> > > > > > 
> > > > > > What hardware do you believe would benefit from this and
> > > > > > why?    
> > > > > 
> > > > > Any touchpad hardware where you cannot press two buttons at
> > > > > once to emulate the third button due to hardware design. And
> > > > > any touchpad hardware on which some of the buttons are broken
> > > > > when it comes to it.
> > > > > 
> > > > > It is built into a notebook and works fine for moving the
> > > > > cursor but due to lack of usable buttons you still need a mouse
> > > > > to use the notebook.    
> > > > 
> > > > Have you tried simply redefining keymap of your keyboard to emit
> > > > BTN_RIGHT/BTN_MIDDLE? Both atkbd and HID keyboards support keymap
> > > > updates from userspace/udev/hwdb and if there is a driver that
> > > > does not support it I will take patches fixing that.  
> > > 
> > > Indeed, they do support it. Such keymap update just does not work as
> > > mouse button regardless of sending the BTN_* event. At least not in
> > > X11.
> > > 
> > > So what is next?  
> > 
> > Teach X11 to handle it properly.
> > 
> > Thanks.
> > 
> 
> That's actually libinputs fault. It marks devices with some random
> capabilities and when the event does not match capability set it is
> dropped.

just because it's not immediately apparent doesn't mean it's random.
We use ID_INPUT_* from udev to determine the device capabilities. In some
cases we override it when we have some information udev doesn't have. e.g.
we disable gestures on some touchpads known to be inaccurate for
multi-finger gestures. or on some devices we disable event codes because the
device doesn't actually have them. see my explanation here:
https://who-t.blogspot.com.au/2015/06/libinput-and-lack-of-device-types.html

the reason we do it this way is so that a) all of the stack can agree on a
device's device type and b) you can override many misdetections with a hwdb
entry or a custom udev rule rather than waiting for a new libinput release
that encodes the new magic.

> Adding the capability with /etc/udev/rules.d/xxx-input.rules
> 
> ENV{ID_INPUT_KEYBOARD}=="1" ENV{ID_INPUT_MOUSE}="1"
> 
> resolves the problem. It must come very late in rules otherwise
> something resets it back.
> 
> This is inefficient to enable by default because libinput must create
> a second shadow X11 device for devices that generate both input and
> keyboard events. 

false. xf86-input-libinput has to do this. libinput doesn't do it, it's
capable of one device having multiple capabilities. due to the previously
mentioned design restrictions in the X server, this is the most efficient
way to work around it. if xf86-input-evdev supported multi-type devices, it
would have to do the same thing.

> ⎡ Virtual core pointer                   id=2   [master pointer  (3)]
> ⎜   ↳ Virtual core XTEST pointer         id=4   [slave  pointer  (2)]
> ⎜   ↳ DELL Dell USB Entry Keyboard       id=8   [slave  pointer  (2)]
> ⎜   ↳ PixArt Dell MS116 USB Optical Mouseid=9   [slave  pointer  (2)]
> ⎣ Virtual core keyboard                  id=3   [master keyboard (2)]
>     ↳ Virtual core XTEST keyboard        id=5   [slave  keyboard (3)]
>     ↳ Power Button                       id=6   [slave  keyboard (3)]
>     ↳ DELL Dell USB Entry Keyboard       id=10  [slave  keyboard (3)]
>     ↳ Power Button                       id=7   [slave  keyboard (3)]
> 
> Presumably it could infer the capabilities from the supported events
> rather than hardcoding them in udev. Surely there are devices with
> stub/broken features that do not actually generate events but that is
> hopefully not the norm.

how do you think udev decides on the device type? it looks at the supported
events and then picks a type based on that.
https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-input_id.c
"presumably, it could..." is btw a perfect example of how everything looks
simple when viewed from enough distance...

Anyway, I'm done here. If you have any specific technical questions feel
free to ask, but this is enough time wasted arguing. The one question that
hasn't been asked yet though: what specific device are we talking about
here? That may put the "broken by design" claims into a better perspective.

Cheers,
   Peter

> Anyway, this mapping is doable with hwdb provided the list of events is
> updated to include the BTN_* events. It is quite isolated change to one
> header but requires recompiling systemd, unfortunately.
> 
> Thanks
> 
> Michal
> 
