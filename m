Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 992FBDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 22:56:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 02/10] sdhci: Add support for bus-specific IO memory
	accessors
Date: Thu, 22 Jan 2009 12:55:48 +0100
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
	<20090122020019.GB11492@oksana.dev.rtsoft.ru>
In-Reply-To: <20090122020019.GB11492@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901221255.49724.arnd@arndb.de>
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
	Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <drzeus-sdhci@drzeus.cx>,
	Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 January 2009, Anton Vorontsov wrote:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * These accessors duplicate s=
dhci_ops, but there are two reasons for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1. sdhci_ops are const, so =
the sdhci driver won't able to assign
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =C2=A0 =C2=A0default ops;

You could assign the pointer to a const default_sdhci_ops structure,
which IMHO would be cleaner than copying the function pointers
separately.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 2. Using host->X instead of=
 host->ops->X saves us one dereference.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =C2=A0 =C2=A0This can be us=
eful in PIO mode. (Though the benefit of this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =C2=A0 =C2=A0is negligibly =
small).
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */

I doubt that this is even measurable. If it was, you could still use a copy
of that structure, like

struct sdhci_host {
	...
	struct sdhci_ops ops; /* not struct sdhci_ops *ops */
	...
};

and do an assignment of the structure, like

static void assign_ops(struct sdhci_host *host, struct sdhci_ops *ops)
{
	host->ops =3D *ops;
}

	Arnd <><
