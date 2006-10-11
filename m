Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id C832367B55
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 19:25:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
Date: Wed, 11 Oct 2006 11:25:09 +0200
References: <20061010204946.GW4381@austin.ibm.com>
	<452C2AAA.5070001@austin.ibm.com> <452C4CE0.5010607@am.sony.com>
In-Reply-To: <452C4CE0.5010607@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610111125.10902.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 October 2006 03:46, Geoff Levand wrote:
> >=20
> > The others look good, but this one complicates the code and doesn't hav=
e any benefit. =C2=A020=20
> > for 21 isn't bad.
>=20
> Is the motivation for this change to improve performance by reducing the =
overhead
> of the mapping calls? =C2=A0If so, there may be some benefit for some sys=
tems. =C2=A0Could
> you please elaborate?
>=20

=46rom what I understand, this patch drastically reduces the number of
I/O PTEs that are needed in the iommu. With the current static IOMMU
mapping, it should only make a difference during initialization, but
any platform that uses a dynamic mapping of iommu entries will benefit
a lot from it, because:

=2D the card can do better prefetching of consecutive memory
=2D there are more I/O ptes available for other drivers.

	Arnd <><
