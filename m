Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 369CDB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:32:26 +1100 (EST)
Subject: Re: [PATCH] powerpc/dts: Added aliased MSIIR register address to MSI
 node in dts
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328111434-564-1-git-send-email-diana.craciun@freescale.com>
Date: Fri, 16 Mar 2012 14:32:20 -0500
Message-Id: <9D3E9651-1D03-4079-98D9-B08D46306879@kernel.crashing.org>
References: <1328111434-564-1-git-send-email-diana.craciun@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 1, 2012, at 9:50 AM, Diana Craciun wrote:

> From: Diana CRACIUN <Diana.Craciun@freescale.com>
>=20
> The MSIIR register for each MSI bank is aliased to a different
> address. The MSI node reg property was updated to contain this
> address:
>=20
> e.g. reg =3D <0x41600 0x200 0x44140 4>;
>=20
> The first region contains the address and length of the MSI
> register set and the second region contains the address of
> the aliased MSIIR register at 0x44140.
>=20
> Signed-off-by: Diana CRACIUN <Diana.Craciun@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |    6 ++++--
> arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi          |    6 +++---
> 2 files changed, 7 insertions(+), 5 deletions(-)

Why, we should only use one of the register regions.  The second region =
was added to allow for 4k separation and thus PAMU protection.  Not sure =
what listed both regions gets us.

- k=
