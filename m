Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 2173ADDEF7
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 15:22:38 +1100 (EST)
Received: by gxk22 with SMTP id 22so1987537gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 20:22:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49B1A47F.8040005@embeddedarm.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com> <49B1A47F.8040005@embeddedarm.com>
Date: Fri, 6 Mar 2009 21:22:36 -0700
Message-ID: <fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
Subject: Re: [PATCH, RFC]
From: Grant Likely <grant.likely@secretlab.ca>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2009 at 3:32 PM, Eddie Dawydiuk <eddie@embeddedarm.com> wrot=
e:
> Hello,
>
> Let's try this one more time. The last patch was using the clocks for a
> custom board based on the Yosemite board and was referencing a non-existe=
nt
> ethNadr( I forgot to pull out this code out).

But the question remains: Why do you need simpleboot support for
Yosemite when you can use a uImage or cuImage with u-boot?

g.

>
> Signed-off-by: Eddie Dawydiuk <eddie@embeddedarm.com>
>
> diff -urN linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c
> linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c
> --- linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c =A0 1969-12=
-31
> 17:00:00.000000000 -0700
> +++ linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c =A0 =A0 =A0 =A02=
009-03-06
> 15:33:24.000000000 -0700
> @@ -0,0 +1,23 @@
> +#include "ops.h"
> +#include "stdio.h"
> +#include "4xx.h"
> +#include "44x.h"
> +
> +#define TARGET_4xx
> +#define TARGET_44x
> +#include "ppcboot.h"
> +
> +static void yosemite_fixups(void)
> +{
> + =A0 =A0 =A0 unsigned long sysclk =3D 66666666;
> +
> + =A0 =A0 =A0 ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
> + =A0 =A0 =A0 ibm4xx_sdram_fixup_memsize();
> +}
> +
> +void platform_specific_init(void)
> +{
> + =A0 =A0 =A0 platform_ops.fixups =3D yosemite_fixups;
> + =A0 =A0 =A0 platform_ops.exit =3D ibm44x_dbcr_reset;
> +}
>
>> diff -urN linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c
>> linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c
>> --- linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c =A0 1969-1=
2-31
>> 17:00:00.000000000 -0700
>> +++ linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c =A0 =A0 =A0 =A0=
2009-03-06
>> 14:55:46.000000000 -0700
>> @@ -0,0 +1,24 @@
>> +#include "ops.h"
>> +#include "stdio.h"
>> +#include "4xx.h"
>> +#include "44x.h"
>> +
>> +#define TARGET_4xx
>> +#define TARGET_44x
>> +#include "ppcboot.h"
>> +
>> +static void yosemite_fixups(void)
>> +{
>> + =A0 =A0 =A0 unsigned long sysclk =3D 50000000;
>> +
>> + =A0 =A0 =A0 ibm440ep_fixup_clocks(sysclk, 11059200, 400000000);
>> + =A0 =A0 =A0 ibm4xx_sdram_fixup_memsize();
>> + =A0 =A0 =A0 dt_fixup_mac_address_by_alias("ethernet0", eth0adr);
>> + =A0 =A0 =A0 dt_fixup_mac_address_by_alias("ethernet1", eth1adr);
>> +}
>> +
>> +void platform_specific_init(void)
>> +{
>> + =A0 =A0 =A0 platform_ops.fixups =3D yosemite_fixups;
>> + =A0 =A0 =A0 platform_ops.exit =3D ibm44x_dbcr_reset;
>> +}
>>
>
>
> --
> Best Regards,
> ________________________________________________________________
> =A0Eddie Dawydiuk, Technologic Systems | voice: =A0(480) 837-5200
> =A016525 East Laser Drive =A0 =A0 =A0 =A0 =A0 =A0 =A0| fax: =A0 =A0(480) =
837-5300
> =A0Fountain Hills, AZ 85268 =A0 =A0 =A0 =A0 =A0 =A0| web: www.embeddedARM=
.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
