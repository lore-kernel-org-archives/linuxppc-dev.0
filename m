Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5DD2DE373
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:28:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GCSJ2m003950
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:28:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GCSItJ182492
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 06:28:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GCSIGF001129
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 06:28:18 -0600
Date: Wed, 16 Apr 2008 07:24:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: 4xx build failure
Message-ID: <20080416072453.59858204@zod.rchland.ibm.com>
In-Reply-To: <20080416194227.1e5e1a9a.sfr@canb.auug.org.au>
References: <20080416194227.1e5e1a9a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Apr 2008 19:42:27 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Josh,
>=20
> Today's linux-next build (powerpc allyesconfig) failed like this:
>=20
> drivers/net/ibm_newemac/core.c: In function =E2=80=98emac_rx_clk_tx=E2=80=
=99:
> drivers/net/ibm_newemac/core.c:146: error: implicit declaration of functi=
on =E2=80=98dcri_clrset=E2=80=99
> drivers/net/ibm_newemac/core.c:146: error: =E2=80=98SDR0=E2=80=99 undecla=
red (first use in this function)
> drivers/net/ibm_newemac/core.c:146: error: (Each undeclared identifier is=
 reported only once
> drivers/net/ibm_newemac/core.c:146: error: for each function it appears i=
n.)
> drivers/net/ibm_newemac/core.c: In function =E2=80=98emac_rx_clk_default=
=E2=80=99:
> drivers/net/ibm_newemac/core.c:152: error: =E2=80=98SDR0=E2=80=99 undecla=
red (first use in this function)
> drivers/net/ibm_newemac/core.c: In function =E2=80=98emac_init_phy=E2=80=
=99:
> drivers/net/ibm_newemac/core.c:2361: error: =E2=80=98SDR0=E2=80=99 undecl=
ared (first use in this function)
>=20
> I have reverted commit 863a1175e22cb108f596a5aa55b1e535a77e7cce
> ("[POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround")
> and commit 4b2d72f5035764cd2e89f5a13ab35c11a27c557b ("[POWERPC]
> ibm_newemac: PowerPC 440GX EMAC PHY clock workaround").

Grr.  Yes, that's probably the right solution for now.  I had forgotten
about Axon.

Sorry for the trouble.  I'll revert those commits locally and repush.

josh
