Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B74D9B6F10
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 02:15:52 +1000 (EST)
Subject: Re: [PATCH 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100806014351.a3bddf08.sfr@canb.auug.org.au>
Date: Thu, 5 Aug 2010 11:14:48 -0500
Message-Id: <2F334348-411C-450A-AEC9-5DF3916E9BBC@kernel.crashing.org>
References: <1281021347-1278-1-git-send-email-galak@kernel.crashing.org>
	<1281021347-1278-2-git-send-email-galak@kernel.crashing.org>
	<20100806014351.a3bddf08.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2010, at 10:43 AM, Stephen Rothwell wrote:

> Hi Kumar,
>=20
> On Thu,  5 Aug 2010 10:15:45 -0500 Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -19,6 +19,7 @@
>> #include <linux/err.h>
>> #include <linux/slab.h>
>> #include <linux/pm_runtime.h>
>> +#include <asm/platform_device.h>
>>=20
>> #include "base.h"
>>=20
>> @@ -170,6 +171,9 @@ struct platform_device =
*platform_device_alloc(const char *name, int id)
>> 		pa->pdev.id =3D id;
>> 		device_initialize(&pa->pdev.dev);
>> 		pa->pdev.dev.release =3D platform_device_release;
>> +#ifdef ARCH_HAS_PDEV_ARCHDATA_SETUP
>> +		arch_setup_pdev_archdata(&pa->pdev);
>> +#endif
>> 	}
>>=20
>> 	return pa ? &pa->pdev : NULL;
>> diff --git a/include/asm-generic/platform_device.h =
b/include/asm-generic/platform_device.h
>> new file mode 100644
>> index 0000000..64806dc
>> --- /dev/null
>> +++ b/include/asm-generic/platform_device.h
>> @@ -0,0 +1,7 @@
>> +#ifndef __ASM_GENERIC_PLATFORM_DEVICE_H_
>> +#define __ASM_GENERIC_PLATFORM_DEVICE_H_
>> +/*
>> + * an architecture can override to define arch_setup_pdev_archdata
>> + */
>> +
>> +#endif /* __ASM_GENERIC_PLATFORM_DEVICE_H_ */
>=20
> Why not do:
>=20
> #include <linux/platform_device.h>
>=20
> #ifndef arch_setup_pdev_archdata
> static inline void arch_setup_pdev_archdata(struct platform_device =
*pdev) { }
> #endif
>=20
> in asm-generic/platform-device.h
>=20
> and the the call in platform_device_alloc() can be unconditional.  If =
the arch wants to override arch_setup_pdev_archdata, it defines the =
function and then does
>=20
> #define arch_setup_pdev_archdata arch_setup_pdev_archdata
>=20
> before still including asm-generic/platform_device.h

I've got no issues with the style change.

- k=
