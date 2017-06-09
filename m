Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkgMG36y0zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 21:40:09 +1000 (AEST)
Date: Fri, 9 Jun 2017 13:39:53 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Message-ID: <20170609133953.1e7221a8@kitsune.suse.cz>
In-Reply-To: <CAKdAkRSho0vBDZ5az+JJ=x7_c1paZb=C6=bVKp4sqNEHB7twvA@mail.gmail.com>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws> <20170528114758.52b619f2@neko>
 <20170528175540.GA8094@dtor-ws>
 <20170607185351.5fcd91df@kitsune.suse.cz>
 <20170607171622.GE13116@dtor-ws>
 <20170607211737.01888f04@kitsune.suse.cz>
 <20170607231303.GB29224@jelly>
 <20170608151842.71b59dad@kitsune.suse.cz>
 <20170608230752.GA4254@jelly>
 <CAKdAkRSho0vBDZ5az+JJ=x7_c1paZb=C6=bVKp4sqNEHB7twvA@mail.gmail.com>
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

On Thu, 8 Jun 2017 16:18:28 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Thu, Jun 8, 2017 at 4:07 PM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Thu, Jun 08, 2017 at 03:18:42PM +0200, Michal Such=C3=A1nek wrote: =
=20
> >> This is what evtest reports about my keyboard:
> >>
> >> Select the device event number [0-12]: 2
> >> Input driver version is 1.0.1
> >> Input device ID: bus 0x3 vendor 0x413c product 0x2107 version 0x111
> >> Input device name: "DELL Dell USB Entry Keyboard"
> >> Supported events:
> >>   Event type 0 (EV_SYN)
> >>   Event type 1 (EV_KEY)
> >>     Event code 1 (KEY_ESC)
> >>     Event code 2 (KEY_1)
> >>     Event code 3 (KEY_2)
> >>     Event code 4 (KEY_3)
> >> ...
> >>     Event code 193 (KEY_F23)
> >>     Event code 194 (KEY_F24)
> >>     Event code 240 (KEY_UNKNOWN)
> >>     Event code 272 (BTN_LEFT)
> >>     Event code 273 (BTN_RIGHT)
> >>     Event code 274 (BTN_MIDDLE)
> >>   Event type 4 (EV_MSC)
> >>     Event code 4 (MSC_SCAN)
> >>   Event type 17 (EV_LED)
> >>     Event code 0 (LED_NUML) state 1
> >>     Event code 1 (LED_CAPSL) state 0
> >>     Event code 2 (LED_SCROLLL) state 0
> >>     Event code 3 (LED_COMPOSE) state 0
> >>     Event code 4 (LED_KANA) state 0
> >> Key repeat handling:
> >>   Repeat type 20 (EV_REP)
> >>     Repeat code 0 (REP_DELAY)
> >>       Value    250
> >>     Repeat code 1 (REP_PERIOD)
> >>       Value     33
> >> Properties: =20
> >
> > looks like it's not tagged as ID_INPUT_MOUSE by the default udev
> > rules because for that we need x/y axes (either relative for real
> > mice or absolute ones for the VMWare USB mouse). This keyboard only
> > has buttons though. So it gets ID_INPUT_KEYBOARD for the keys, but
> > no ID_INPUT_MOUSE.
> >
> > Google isn't overly forthcoming on "DELL Dell USB Entry Keyboard"
> > but the few pictures I can find all point to a keyboard that
> > doesn't have any physical mouse buttons at all. Does yours have
> > buttons? Can you post a picture of it somewhere?
> > =20
>=20
> Michal is using udev/hwdb to replace some of the keys on his keyboard
> to generate BTN_RIGHT/BTN_MIDDLE trying to achive the same end result
> as with mac_hid. It is not the default keyboard behavior. Having
> another custom udev rule to mark the device as ID_INPUT_MOUSE is a
> fair requirement in this case I think.
>=20

Which is done in different place, and uses device matching with
completely different patterns. So for this to work reasonably either

 - all devices should have all capabilities by default
 - the capabilities should be detected based on the events actually
   available on the device

And if my keyboard actually claimed to have relative axis because of
some great firmware engineering on the manufacturer's part and I found
how to remove them in hwdb it would not take effect either.

Thanks

Michal
