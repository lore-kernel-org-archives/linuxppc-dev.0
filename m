Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVe9+Y4Xn24BpR+1zFF3Wes6uvwx-EA3A2jASyoA66Vjg@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-8-git-send-email-a.heider@gmail.com>
	<4E39CCF3.7000406@infradead.org>
	<CAHsu+b8iEA53gq45Dyv-n+9X8ZG97xTTp50JQxGxVLA_UUppBw@mail.gmail.com>
	<CAMuHMdVe9+Y4Xn24BpR+1zFF3Wes6uvwx-EA3A2jASyoA66Vjg@mail.gmail.com>
Date: Sat, 6 Aug 2011 14:40:20 +0200
Message-ID: <CAHsu+b9Yt_c65O4Hx6zhkKTtQ-meHVUrDuGY6T07DQJuHOeGEw@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 07/15] ps3flash: Refuse to work in lpars
	other than OtherOS
From: Andre Heider <a.heider@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Aug 4, 2011 at 9:27 PM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> On Thu, Aug 4, 2011 at 18:40, Andre Heider <a.heider@gmail.com> wrote:
>> On Thu, Aug 4, 2011 at 12:34 AM, Geoff Levand <geoff@infradead.org> wrot=
e:
>>> On 08/01/2011 01:02 PM, Andre Heider wrote:
>>>> --- a/drivers/char/ps3flash.c
>>>> +++ b/drivers/char/ps3flash.c
>>>> @@ -25,6 +25,7 @@
>>>>
>>>> =A0#include <asm/lv1call.h>
>>>> =A0#include <asm/ps3stor.h>
>>>> +#include <asm/firmware.h>
>>>>
>>>>
>>>> =A0#define DEVICE_NAME =A0 =A0 =A0 =A0 =A0"ps3flash"
>>>> @@ -455,6 +456,12 @@ static struct ps3_system_bus_driver ps3flash =3D =
{
>>>>
>>>> =A0static int __init ps3flash_init(void)
>>>> =A0{
>>>> + =A0 =A0 if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>>
>>> Is this needed? =A0Won't this driver only be loaded on PS3 hardware?
>>>
>>
>> The same code is in drivers/block/ps3disk.c, I wasn't sure if it is
>> missing here or redundant there.
>> Should I remove it here?
>>
>>>> +
>>>> + =A0 =A0 if (ps3_get_ss_laid() !=3D PS3_SS_LAID_OTHEROS)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>>> +
>>>> =A0 =A0 =A0 return ps3_system_bus_driver_register(&ps3flash);
>>>> =A0}
>
> ps3flash_init() is called straight from module_init(), so it could be
> called on non-PS3.
> ps3_system_bus_driver_register() has the firmware_has_feature_check(),
> so it will
> reject non-PS3.
>
> But if your *_init() does any processing before calling
> ps3_system_bus_driver_register()
> (like ps3disk_init() does, and ps3flash_init() now does due to your
> patch), you have to
> do the check yourself, to make sure it returns early on non-PS3.

Aha, makes perfect sense.

Thanks Geert
