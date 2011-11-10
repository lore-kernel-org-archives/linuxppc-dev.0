Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 11AADB6F87
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 00:59:18 +1100 (EST)
Subject: Re: [RFC PATCH 00/17] powerpc/e500: separate e500 from e500mc
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320883399-15911-1-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 10 Nov 2011 07:59:08 -0600
Message-Id: <FF2BF3F3-1158-4747-AEEC-03D6A7C462D9@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883399-15911-1-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Scott Wood <scottwood@freescale.com>, Timur Tabi <B04825@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 9, 2011, at 6:03 PM, Kyle Moffett wrote:

> Hello,
>=20
> I saw Baruch Siach's patch:
>  powerpc: 85xx: separate e500 from e500mc
>=20
> Unfortunately, that patch breaks the dependencies for the P5020DS
> platform and does not fix the underlying code which does not
> understand what the ambiguous "CONFIG_E500" means.
>=20
> In order to fix the issue at the fundamental level, I created the
> following 17-patch series loosely based on Baruch's patch.
>=20
> =3D=3D=3D High-Level Summary =3D=3D=3D
>=20
> The e500v1/v2 and e500mc/e5500 CPU families are not compatible with
> each other, yet they share the same "CONFIG_E500" Kconfig option.
>=20
> The following patch series splits the 32-bit CPU support into two
> separate options: "CONFIG_FSL_E500_V1_V2" and "CONFIG_FSL_E500MC".
> Additionally, the 64-bit e5500 support is separated to its own config
> option ("CONFIG_FSL_E5500") which is automatically combined with
> either 32-bit e500MC or 64-bit Book-3E when the P5020DS board support
> is enabled.

So its clear from the community that there is confusion here and we need =
to clean this up.  I guess my attempt to support an kernel that ran on =
both E500v2 and E500mc isn't worth it.  However I don't want to =
completely remove the ability to do this.

Towards the cleanup I'd ask for a proposal on what exactly the CONFIG_ =
options we'd end up with would be and their meaning.

So today we have:

CONFIG_E500
CONFIG_PPC_E500MC

What do we want to move to?  I want to keep the builds such that we have =
only 2 classes:  e500V1/V2 and e500mc/e5500/e6500/.../eX500.  I see no =
reason to hyper-optimize e500mc vs e5500 vs e6500.

- k=
