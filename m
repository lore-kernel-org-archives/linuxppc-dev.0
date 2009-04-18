Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 59DB6DE0DB
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 15:50:04 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so747697ywe.39
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 22:50:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090417170707.B6C95C4004F@mail150-wa4.bigfish.com>
References: <764365e7af2e476e43cd674738e51f13b306979b.1239874968.git.monstr@monstr.eu>
	<74c0088dfda1816c21914c0a8da0c42908526c5e.1239874968.git.monstr@monstr.eu>
	<20090417170707.B6C95C4004F@mail150-wa4.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 23:49:47 -0600
Message-ID: <fa686aa40904172249m5e261492w48c8d9d8446600e0@mail.gmail.com>
Subject: Re: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable
	drivers for Microblaze
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 11:06 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> Can we have XILINX_DRIVERS, please? =A0That way this can also be enabled
> on any architecture that has FPGA peripherals.

I've thought about this more, and I'd really rather not.  The list of
affected drivers is short and is not a large maintenance burden.  I
don't think a list of 2 or 3 architecture selects for each driver is
unreasonable.  A "XILINX_DRIVERS" config item doesn't really help much
anyway.  At any given time one of these drivers may be needed on
another platform.  ie. the SystemACE device is present on at least one
non-virtex, non-spartan platform.

g.

>
> Steve
>
>> -----Original Message-----
>> From: owner-microblaze-uclinux@itee.uq.edu.au
> [mailto:owner-microblaze-uclinux@itee.uq.edu.au] On
>> Behalf Of monstr@monstr.eu
>> Sent: Thursday, April 16, 2009 2:57 AM
>> To: linux-kernel@vger.kernel.org
>> Cc: microblaze-uclinux@itee.uq.edu.au; Michal Simek
>> Subject: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig:
> Enable drivers for Microblaze
>>
>> From: Michal Simek <monstr@monstr.eu>
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>> ---
>> =A0drivers/block/Kconfig | =A0 =A02 +-
>> =A0drivers/char/Kconfig =A0| =A0 =A02 +-
>> =A0drivers/gpio/Kconfig =A0| =A0 =A02 +-
>> =A0drivers/usb/Kconfig =A0 | =A0 =A01 +
>> =A04 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index ddea8e4..9f1665f 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -438,7 +438,7 @@ source "drivers/s390/block/Kconfig"
>>
>> =A0config XILINX_SYSACE
>> =A0 =A0 =A0 tristate "Xilinx SystemACE support"
>> - =A0 =A0 depends on 4xx
>> + =A0 =A0 depends on 4xx || MICROBLAZE
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Include support for the Xilinx SystemACE CompactFlash
> interface
>>
>> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>> index 735bbe2..bb1a071 100644
>> --- a/drivers/char/Kconfig
>> +++ b/drivers/char/Kconfig
>> @@ -893,7 +893,7 @@ config DTLK
>>
>> =A0config XILINX_HWICAP
>> =A0 =A0 =A0 tristate "Xilinx HWICAP Support"
>> - =A0 =A0 depends on XILINX_VIRTEX
>> + =A0 =A0 depends on XILINX_VIRTEX || MICROBLAZE
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 This option enables support for Xilinx Internal Configur=
ation
>> =A0 =A0 =A0 =A0 Access Port (ICAP) driver. =A0The ICAP is used on Xilinx=
 Virtex
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index edb0253..11f3739 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -69,7 +69,7 @@ comment "Memory mapped GPIO expanders:"
>>
>> =A0config GPIO_XILINX
>> =A0 =A0 =A0 bool "Xilinx GPIO support"
>> - =A0 =A0 depends on PPC_OF
>> + =A0 =A0 depends on PPC_OF || MICROBLAZE
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Say yes here to support the Xilinx FPGA GPIO device
>>
>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>> index c6c816b..5eee3f8 100644
>> --- a/drivers/usb/Kconfig
>> +++ b/drivers/usb/Kconfig
>> @@ -22,6 +22,7 @@ config USB_ARCH_HAS_HCD
>> =A0 =A0 =A0 default y if PCMCIA && !M32R =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0# sl811_cs
>> =A0 =A0 =A0 default y if ARM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0# SL-811
>> =A0 =A0 =A0 default y if SUPERH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 # r8a66597-hcd
>> + =A0 =A0 default y if MICROBLAZE
>> =A0 =A0 =A0 default PCI
>>
>> =A0# many non-PCI SOC chips embed OHCI
>> --
>> 1.5.5.1
>>
>> ___________________________
>> microblaze-uclinux mailing list
>> microblaze-uclinux@itee.uq.edu.au
>> Project Home Page :
> http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux
>> Mailing List Archive :
> http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/
>>
>
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
