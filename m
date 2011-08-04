Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E39CCF3.7000406@infradead.org>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-8-git-send-email-a.heider@gmail.com>
	<4E39CCF3.7000406@infradead.org>
Date: Thu, 4 Aug 2011 18:40:36 +0200
Message-ID: <CAHsu+b8iEA53gq45Dyv-n+9X8ZG97xTTp50JQxGxVLA_UUppBw@mail.gmail.com>
Subject: Re: [PATCH 07/15] ps3flash: Refuse to work in lpars other than OtherOS
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 4, 2011 at 12:34 AM, Geoff Levand <geoff@infradead.org> wrote:
> On 08/01/2011 01:02 PM, Andre Heider wrote:
>> The driver implements a character and misc device, meant for the
>> axed OtherOS to exchange various settings with GameOS.
>> Since Firmware 3.21 there is no GameOS support anymore to write these
>> settings, so limit the driver to the OtherOS environment.
>
> This is really a test if running on the PS3 OtherOS, so this
> comment should state that.

Ok.

>
>>
>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>> ---
>> =A0arch/powerpc/platforms/ps3/Kconfig | =A0 =A01 +
>> =A0drivers/char/ps3flash.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++++
>> =A02 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms=
/ps3/Kconfig
>> index 84df5c8..5eb956a 100644
>> --- a/arch/powerpc/platforms/ps3/Kconfig
>> +++ b/arch/powerpc/platforms/ps3/Kconfig
>> @@ -121,6 +121,7 @@ config PS3_FLASH
>>
>> =A0 =A0 =A0 =A0 This support is required to access the PS3 FLASH ROM, wh=
ich
>> =A0 =A0 =A0 =A0 contains the boot loader and some boot options.
>> + =A0 =A0 =A0 This driver only supports the deprecated OtherOS LPAR.
>
> This will be confusing for OtherOS users, so should be removed.

Ok.

>
>> =A0 =A0 =A0 =A0 In general, all users will say Y or M.
>
>
> This could be changed to: 'In general, all PS3 OtherOS users will say Y o=
r M.'

Yeah, you're right, that's much better

>
>>
>> =A0 =A0 =A0 =A0 As this driver needs a fixed buffer of 256 KiB of memory=
, it can
>> diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
>> index 69c734a..b1e8659 100644
>> --- a/drivers/char/ps3flash.c
>> +++ b/drivers/char/ps3flash.c
>> @@ -25,6 +25,7 @@
>>
>> =A0#include <asm/lv1call.h>
>> =A0#include <asm/ps3stor.h>
>> +#include <asm/firmware.h>
>>
>>
>> =A0#define DEVICE_NAME =A0 =A0 =A0 =A0 =A0"ps3flash"
>> @@ -455,6 +456,12 @@ static struct ps3_system_bus_driver ps3flash =3D {
>>
>> =A0static int __init ps3flash_init(void)
>> =A0{
>> + =A0 =A0 if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> Is this needed? =A0Won't this driver only be loaded on PS3 hardware?
>

The same code is in drivers/block/ps3disk.c, I wasn't sure if it is
missing here or redundant there.
Should I remove it here?

>> +
>> + =A0 =A0 if (ps3_get_ss_laid() !=3D PS3_SS_LAID_OTHEROS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> =A0 =A0 =A0 return ps3_system_bus_driver_register(&ps3flash);
>> =A0}
>>
>
> -Geoff
>
>
