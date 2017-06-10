Return-Path: <peter.hutterer@who-t.net>
Received: from mail.clearchain.com (leo.clearchain.com [199.73.29.74])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wl2S16pkNzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jun 2017 12:00:32 +1000 (AEST)
Date: Sat, 10 Jun 2017 12:00:22 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Message-ID: <20170610020021.GA10528@m72e.redhat.com>
References: <20170528114758.52b619f2@neko> <20170528175540.GA8094@dtor-ws>
 <20170607185351.5fcd91df@kitsune.suse.cz>
 <20170607171622.GE13116@dtor-ws>
 <20170607211737.01888f04@kitsune.suse.cz>
 <20170607231303.GB29224@jelly>
 <20170608151842.71b59dad@kitsune.suse.cz>
 <20170608230752.GA4254@jelly>
 <CAKdAkRSho0vBDZ5az+JJ=x7_c1paZb=C6=bVKp4sqNEHB7twvA@mail.gmail.com>
 <20170609133953.1e7221a8@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170609133953.1e7221a8@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 09, 2017 at 01:39:53PM +0200, Michal Suchánek wrote:
> On Thu, 8 Jun 2017 16:18:28 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Thu, Jun 8, 2017 at 4:07 PM, Peter Hutterer
> > <peter.hutterer@who-t.net> wrote:
> > > On Thu, Jun 08, 2017 at 03:18:42PM +0200, Michal Suchánek wrote:  
> > >> This is what evtest reports about my keyboard:
> > >>
> > >> Select the device event number [0-12]: 2
> > >> Input driver version is 1.0.1
> > >> Input device ID: bus 0x3 vendor 0x413c product 0x2107 version 0x111
> > >> Input device name: "DELL Dell USB Entry Keyboard"
> > >> Supported events:
> > >>   Event type 0 (EV_SYN)
> > >>   Event type 1 (EV_KEY)
> > >>     Event code 1 (KEY_ESC)
> > >>     Event code 2 (KEY_1)
> > >>     Event code 3 (KEY_2)
> > >>     Event code 4 (KEY_3)
> > >> ...
> > >>     Event code 193 (KEY_F23)
> > >>     Event code 194 (KEY_F24)
> > >>     Event code 240 (KEY_UNKNOWN)
> > >>     Event code 272 (BTN_LEFT)
> > >>     Event code 273 (BTN_RIGHT)
> > >>     Event code 274 (BTN_MIDDLE)
> > >>   Event type 4 (EV_MSC)
> > >>     Event code 4 (MSC_SCAN)
> > >>   Event type 17 (EV_LED)
> > >>     Event code 0 (LED_NUML) state 1
> > >>     Event code 1 (LED_CAPSL) state 0
> > >>     Event code 2 (LED_SCROLLL) state 0
> > >>     Event code 3 (LED_COMPOSE) state 0
> > >>     Event code 4 (LED_KANA) state 0
> > >> Key repeat handling:
> > >>   Repeat type 20 (EV_REP)
> > >>     Repeat code 0 (REP_DELAY)
> > >>       Value    250
> > >>     Repeat code 1 (REP_PERIOD)
> > >>       Value     33
> > >> Properties:  
> > >
> > > looks like it's not tagged as ID_INPUT_MOUSE by the default udev
> > > rules because for that we need x/y axes (either relative for real
> > > mice or absolute ones for the VMWare USB mouse). This keyboard only
> > > has buttons though. So it gets ID_INPUT_KEYBOARD for the keys, but
> > > no ID_INPUT_MOUSE.
> > >
> > > Google isn't overly forthcoming on "DELL Dell USB Entry Keyboard"
> > > but the few pictures I can find all point to a keyboard that
> > > doesn't have any physical mouse buttons at all. Does yours have
> > > buttons? Can you post a picture of it somewhere?
> > >  
> > 
> > Michal is using udev/hwdb to replace some of the keys on his keyboard
> > to generate BTN_RIGHT/BTN_MIDDLE trying to achive the same end result
> > as with mac_hid. It is not the default keyboard behavior. Having
> > another custom udev rule to mark the device as ID_INPUT_MOUSE is a
> > fair requirement in this case I think.
> > 
> 
> Which is done in different place, and uses device matching with
> completely different patterns. So for this to work reasonably either
> 
>  - all devices should have all capabilities by default
>  - the capabilities should be detected based on the events actually
>    available on the device
> 
> And if my keyboard actually claimed to have relative axis because of
> some great firmware engineering on the manufacturer's part and I found
> how to remove them in hwdb it would not take effect either.

https://github.com/systemd/systemd/blob/master/rules/50-udev-default.rules.in
calls input-id which sets the ID_INPUT_* tags. If you modify the
capabilities after that happens, you need to call input-id again to get
updated udev properties.

There is no kernel facility to handle devices that change capabilities at
runtime. We discussed this a short while ago (search for SYN_CONFIG) but
it's ... tricky.

Cheers,
   Peter
