Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk5bZ53t6zDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:18:50 +1000 (AEST)
Date: Thu, 8 Jun 2017 15:18:42 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Message-ID: <20170608151842.71b59dad@kitsune.suse.cz>
In-Reply-To: <20170607231303.GB29224@jelly>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws> <20170528114758.52b619f2@neko>
 <20170528175540.GA8094@dtor-ws>
 <20170607185351.5fcd91df@kitsune.suse.cz>
 <20170607171622.GE13116@dtor-ws>
 <20170607211737.01888f04@kitsune.suse.cz>
 <20170607231303.GB29224@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 8 Jun 2017 09:13:03 +1000
Peter Hutterer <peter.hutterer@who-t.net> wrote:

> On Wed, Jun 07, 2017 at 09:17:37PM +0200, Michal Such=C3=A1nek wrote:
> > On Wed, 7 Jun 2017 10:16:22 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >  =20
> > > On Wed, Jun 07, 2017 at 06:53:51PM +0200, Michal Such=C3=A1nek wrote:=
 =20
> > > > On Sun, 28 May 2017 10:55:40 -0700
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > >    =20
> > > > > On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek
> > > > > wrote:   =20
> > > > > > On Tue, 9 May 2017 17:43:27 -0700
> > > > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
   =20
> > > > > >      =20
> > > > > > >=20
> > > > > > > What hardware do you believe would benefit from this and
> > > > > > > why?     =20
> > > > > >=20
> > > > > > Any touchpad hardware where you cannot press two buttons at
> > > > > > once to emulate the third button due to hardware design. And
> > > > > > any touchpad hardware on which some of the buttons are
> > > > > > broken when it comes to it.
> > > > > >=20
> > > > > > It is built into a notebook and works fine for moving the
> > > > > > cursor but due to lack of usable buttons you still need a
> > > > > > mouse to use the notebook.     =20
> > > > >=20
> > > > > Have you tried simply redefining keymap of your keyboard to
> > > > > emit BTN_RIGHT/BTN_MIDDLE? Both atkbd and HID keyboards
> > > > > support keymap updates from userspace/udev/hwdb and if there
> > > > > is a driver that does not support it I will take patches
> > > > > fixing that.   =20
> > > >=20
> > > > Indeed, they do support it. Such keymap update just does not
> > > > work as mouse button regardless of sending the BTN_* event. At
> > > > least not in X11.
> > > >=20
> > > > So what is next?   =20
> > >=20
> > > Teach X11 to handle it properly.
> > >=20
> > > Thanks.
> > >  =20
> >=20
> > That's actually libinputs fault. It marks devices with some random
> > capabilities and when the event does not match capability set it is
> > dropped. =20
>=20
> just because it's not immediately apparent doesn't mean it's random.
> We use ID_INPUT_* from udev to determine the device capabilities. In
> some cases we override it when we have some information udev doesn't
> have. e.g. we disable gestures on some touchpads known to be
> inaccurate for multi-finger gestures. or on some devices we disable
> event codes because the device doesn't actually have them. see my
> explanation here:
> https://who-t.blogspot.com.au/2015/06/libinput-and-lack-of-device-types.h=
tml
>=20
> the reason we do it this way is so that a) all of the stack can agree
> on a device's device type and b) you can override many misdetections
> with a hwdb entry or a custom udev rule rather than waiting for a new
> libinput release that encodes the new magic.
>=20
> > Adding the capability with /etc/udev/rules.d/xxx-input.rules
> >=20
> > ENV{ID_INPUT_KEYBOARD}=3D=3D"1" ENV{ID_INPUT_MOUSE}=3D"1"
> >=20
> > resolves the problem. It must come very late in rules otherwise
> > something resets it back.
> >=20
> > This is inefficient to enable by default because libinput must
> > create a second shadow X11 device for devices that generate both
> > input and keyboard events.  =20
>=20
> false. xf86-input-libinput has to do this. libinput doesn't do it,
> it's capable of one device having multiple capabilities. due to the
> previously mentioned design restrictions in the X server, this is the
> most efficient way to work around it. if xf86-input-evdev supported
> multi-type devices, it would have to do the same thing.

And that's argument just for the sake of arguing or what?

>=20
> > =E2=8E=A1 Virtual core pointer                   id=3D2   [master point=
er
> > (3)] =E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer         id=3D4   =
[slave
> > pointer  (2)] =E2=8E=9C   =E2=86=B3 DELL Dell USB Entry Keyboard       =
id=3D8
> > [slave  pointer  (2)] =E2=8E=9C   =E2=86=B3 PixArt Dell MS116 USB Optic=
al
> > Mouseid=3D9   [slave  pointer  (2)] =E2=8E=A3 Virtual core
> > keyboard                  id=3D3   [master keyboard (2)] =E2=86=B3 Virt=
ual
> > core XTEST keyboard        id=3D5   [slave  keyboard (3)] =E2=86=B3 Pow=
er
> > Button                       id=3D6   [slave  keyboard (3)] =E2=86=B3 D=
ELL
> > Dell USB Entry Keyboard       id=3D10  [slave  keyboard (3)] =E2=86=B3 =
Power
> > Button                       id=3D7   [slave  keyboard (3)]
> >=20
> > Presumably it could infer the capabilities from the supported events
> > rather than hardcoding them in udev. Surely there are devices with
> > stub/broken features that do not actually generate events but that
> > is hopefully not the norm. =20
>=20
> how do you think udev decides on the device type? it looks at the
> supported events and then picks a type based on that.
> https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-inpu=
t_id.c
> "presumably, it could..." is btw a perfect example of how everything
> looks simple when viewed from enough distance...

This is what evtest reports about my keyboard:

Select the device event number [0-12]: 2
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x413c product 0x2107 version 0x111
Input device name: "DELL Dell USB Entry Keyboard"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
...
    Event code 193 (KEY_F23)
    Event code 194 (KEY_F24)
    Event code 240 (KEY_UNKNOWN)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML) state 1
    Event code 1 (LED_CAPSL) state 0
    Event code 2 (LED_SCROLLL) state 0
    Event code 3 (LED_COMPOSE) state 0
    Event code 4 (LED_KANA) state 0
Key repeat handling:
  Repeat type 20 (EV_REP)
    Repeat code 0 (REP_DELAY)
      Value    250
    Repeat code 1 (REP_PERIOD)
      Value     33
Properties:

>=20
> Anyway, I'm done here. If you have any specific technical questions
> feel free to ask, but this is enough time wasted arguing. The one
So from the distance of evtest it looks like it supports mouse buttons
yet from the distance of libinput it does not. So maybe libinput needs
to take a step back from the keyboard to see that?=20

Like maybe assigning the classes after it went through the hwdb fixups.

> question that hasn't been asked yet though: what specific device are
> we talking about here? That may put the "broken by design" claims
> into a better perspective.

Which part broken by design do you mean, exactly?

There are too many when it comes to input devices to be able to tell.

Thanks

Michal
