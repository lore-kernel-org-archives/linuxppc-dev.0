Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-ua0-x22b.google.com (mail-ua0-x22b.google.com
 [IPv6:2607:f8b0:400c:c08::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkLvW6nW0zDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 09:18:31 +1000 (AEST)
Received: by mail-ua0-x22b.google.com with SMTP id h39so26518253uaa.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 16:18:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608230752.GA4254@jelly>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws>
 <20170528114758.52b619f2@neko> <20170528175540.GA8094@dtor-ws>
 <20170607185351.5fcd91df@kitsune.suse.cz> <20170607171622.GE13116@dtor-ws>
 <20170607211737.01888f04@kitsune.suse.cz> <20170607231303.GB29224@jelly>
 <20170608151842.71b59dad@kitsune.suse.cz> <20170608230752.GA4254@jelly>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 8 Jun 2017 16:18:28 -0700
Message-ID: <CAKdAkRSho0vBDZ5az+JJ=x7_c1paZb=C6=bVKp4sqNEHB7twvA@mail.gmail.com>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 8, 2017 at 4:07 PM, Peter Hutterer <peter.hutterer@who-t.net> w=
rote:
> On Thu, Jun 08, 2017 at 03:18:42PM +0200, Michal Such=C3=A1nek wrote:
>> This is what evtest reports about my keyboard:
>>
>> Select the device event number [0-12]: 2
>> Input driver version is 1.0.1
>> Input device ID: bus 0x3 vendor 0x413c product 0x2107 version 0x111
>> Input device name: "DELL Dell USB Entry Keyboard"
>> Supported events:
>>   Event type 0 (EV_SYN)
>>   Event type 1 (EV_KEY)
>>     Event code 1 (KEY_ESC)
>>     Event code 2 (KEY_1)
>>     Event code 3 (KEY_2)
>>     Event code 4 (KEY_3)
>> ...
>>     Event code 193 (KEY_F23)
>>     Event code 194 (KEY_F24)
>>     Event code 240 (KEY_UNKNOWN)
>>     Event code 272 (BTN_LEFT)
>>     Event code 273 (BTN_RIGHT)
>>     Event code 274 (BTN_MIDDLE)
>>   Event type 4 (EV_MSC)
>>     Event code 4 (MSC_SCAN)
>>   Event type 17 (EV_LED)
>>     Event code 0 (LED_NUML) state 1
>>     Event code 1 (LED_CAPSL) state 0
>>     Event code 2 (LED_SCROLLL) state 0
>>     Event code 3 (LED_COMPOSE) state 0
>>     Event code 4 (LED_KANA) state 0
>> Key repeat handling:
>>   Repeat type 20 (EV_REP)
>>     Repeat code 0 (REP_DELAY)
>>       Value    250
>>     Repeat code 1 (REP_PERIOD)
>>       Value     33
>> Properties:
>
> looks like it's not tagged as ID_INPUT_MOUSE by the default udev rules
> because for that we need x/y axes (either relative for real mice or absol=
ute
> ones for the VMWare USB mouse). This keyboard only has buttons though. So=
 it
> gets ID_INPUT_KEYBOARD for the keys, but no ID_INPUT_MOUSE.
>
> Google isn't overly forthcoming on "DELL Dell USB Entry Keyboard" but the
> few pictures I can find all point to a keyboard that doesn't have any
> physical mouse buttons at all. Does yours have buttons? Can you post a
> picture of it somewhere?
>

Michal is using udev/hwdb to replace some of the keys on his keyboard
to generate BTN_RIGHT/BTN_MIDDLE trying to achive the same end result
as with mac_hid. It is not the default keyboard behavior. Having
another custom udev rule to mark the device as ID_INPUT_MOUSE is a
fair requirement in this case I think.

--=20
Dmitry
