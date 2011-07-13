Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C5FBB6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 07:50:46 +1000 (EST)
Date: Wed, 13 Jul 2011 16:50:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCb0Y/RgdC40L0=?=
	<alexander.lyasin@gmail.com>
Subject: Re: Can't request irq
Message-ID: <20110713165036.209d24cd@schlenkerla.am.freescale.net>
In-Reply-To: <CA+tvTZsMwAYswu=1+0FHLxMAF2354mFnvbxmRVjw3Z=Mp+gFYw@mail.gmail.com>
References: <CA+tvTZsMwAYswu=1+0FHLxMAF2354mFnvbxmRVjw3Z=Mp+gFYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Jul 2011 03:02:40 +0600
=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=9B=D1=8F=D1=81=
=D0=B8=D0=BD <alexander.lyasin@gmail.com> wrote:

> I'm writing module for "falc" device.
> During loading of the module the probe function is called.
> But request_irq(48, falc_irq_handler, IRQF_DISABLED, "falc",
> falc_staff) function return -38. I see, interrupt 48 (irq_chip) absent
> in system.
> -ENOSYS returned from __setup_irq function from manage.c:
>=20
>=20
> if (desc->chip =3D=3D &no_irq_chip)
>        return -ENOSYS;
>=20
>=20
> Help me please, how can I to create it in system?

request_irq() takes virtual interrupt numbers, not the numbers of some
arbitrary interrupt controller in the system (sometimes there's more than
one).  Use irq_of_parse_and_map() on your device tree node to establish
a mapping and get the virtual interrupt number.

-Scott
