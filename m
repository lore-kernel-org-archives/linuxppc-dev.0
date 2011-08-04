Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAHsu+b8iEA53gq45Dyv-n+9X8ZG97xTTp50JQxGxVLA_UUppBw@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-8-git-send-email-a.heider@gmail.com>
	<4E39CCF3.7000406@infradead.org>
	<CAHsu+b8iEA53gq45Dyv-n+9X8ZG97xTTp50JQxGxVLA_UUppBw@mail.gmail.com>
Date: Thu, 4 Aug 2011 21:27:08 +0200
Message-ID: <CAMuHMdVe9+Y4Xn24BpR+1zFF3Wes6uvwx-EA3A2jASyoA66Vjg@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 07/15] ps3flash: Refuse to work in lpars
	other than OtherOS
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 4, 2011 at 18:40, Andre Heider <a.heider@gmail.com> wrote:
> On Thu, Aug 4, 2011 at 12:34 AM, Geoff Levand <geoff@infradead.org> wrote=
:
>> On 08/01/2011 01:02 PM, Andre Heider wrote:
>>> --- a/drivers/char/ps3flash.c
>>> +++ b/drivers/char/ps3flash.c
>>> @@ -25,6 +25,7 @@
>>>
>>> =C2=A0#include <asm/lv1call.h>
>>> =C2=A0#include <asm/ps3stor.h>
>>> +#include <asm/firmware.h>
>>>
>>>
>>> =C2=A0#define DEVICE_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"ps3flash"
>>> @@ -455,6 +456,12 @@ static struct ps3_system_bus_driver ps3flash =3D {
>>>
>>> =C2=A0static int __init ps3flash_init(void)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>>
>> Is this needed? =C2=A0Won't this driver only be loaded on PS3 hardware?
>>
>
> The same code is in drivers/block/ps3disk.c, I wasn't sure if it is
> missing here or redundant there.
> Should I remove it here?
>
>>> +
>>> + =C2=A0 =C2=A0 if (ps3_get_ss_laid() !=3D PS3_SS_LAID_OTHEROS)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 return ps3_system_bus_driver_register(&ps3flash);
>>> =C2=A0}

ps3flash_init() is called straight from module_init(), so it could be
called on non-PS3.
ps3_system_bus_driver_register() has the firmware_has_feature_check(),
so it will
reject non-PS3.

But if your *_init() does any processing before calling
ps3_system_bus_driver_register()
(like ps3disk_init() does, and ps3flash_init() now does due to your
patch), you have to
do the check yourself, to make sure it returns early on non-PS3.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
