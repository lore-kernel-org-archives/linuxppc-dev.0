Return-Path: <mickael.royer@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id D34B6679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2005 08:05:55 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so843297rnf
	for <linuxppc-dev@ozlabs.org>; Mon, 30 May 2005 15:05:54 -0700 (PDT)
Message-ID: <3db27390050530145939d260e4@mail.gmail.com>
Date: Mon, 30 May 2005 23:59:14 +0200
From: Mickael Royer <mickael.royer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1117424155.5228.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1117424155.5228.28.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: ppc32: Rework power management take #3
Reply-To: Mickael Royer <mickael.royer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben

> Ok, the patch is now getting "good enough" for wider testing. It applies
> on current "git" tree (or 2.6.12-rc6 when/if that is ever released).

I have just tested your patch with the 2.5.12-rc5-git5 on the new powerbook=
 12".
And yes, the suspend to disk works very well, even if X is running (I
report my problem with X and the suspend to disk with a 2.6.12-rc4 in
another discussion).
It is really good.=20

Thanks for your good job Ben.=20

Mickael

On 5/30/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Ok, the patch is now getting "good enough" for wider testing. It applies
> on current "git" tree (or 2.6.12-rc6 when/if that is ever released). It
> requires one other patch to be applied first:
>=20
> http://gate.crashing.org/~benh/ppc32-remove-macserial.diff
>=20
> The PM patch itself can be found at:
>=20
> http://gate.crashing.org/~benh/ppc32-rework-pm.diff
>=20
> This patch completely reworks both suspend-to-ram and suspend-to-disk
> support on PowerMac:
>=20
>  - suspend-to-ram code is moved away from the via-pmu.c driver
>  - both suspend-to-disk & to-ram consolidated to use the same
> infrastructure and code base in a new pmac_pm.c file
>  - significants fixes & improvements to suspend-to-disk
>  - for now (may change), use the "refrigerator" with suspend-to-ram as
> well as suspend-to-disk. This may help make it a bit more robust vs.
> userland activity during the sleep process
>  - CONFIG_PMAC_PBOOK is gone. CONFIG_PMAC_MEDIABAY is new and controls
> wether the powerbook hostwap bay driver is included. The rest of bits
> formerly under CONFIG_PMAC_PBOOK control are now either always on
> (like /dev/pmu interface on PMU based machines) or dependent on other
> config options (like CONFIG_PM, CONFIG_PPC_PMAC, ...)
>=20
> The patch will not be in 2.6.12 (though will probably apply on top of
> it). I aim for a 2.6.13 release, knowing that the patch changes a bunch
> of non-ppc-specific power management bits, and thus may need some time
> to be fully merged upstream.
>=20
>=20
>=20
>=20
> --=20
> To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact
> listmaster@lists.debian.org
>=20
>
