Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BB76B6F7F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 00:40:27 +1100 (EST)
Subject: Re: [RFC PATCH 08/17] powerpc/e500: Remove conditional "lwsync"
 substitution
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 10 Nov 2011 07:40:04 -0600
Message-Id: <3937191C-A735-4668-8E80-9FB4B35E2F63@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 9, 2011, at 6:07 PM, Kyle Moffett wrote:

> As FreeScale e500 systems have different cacheline sizes from e500mc, =
it
> is basically impossible for the kernel to support both in a single
> system image at present.
>=20
> Given that one is SPE-float and the other is classic-float, they are =
not
> generally userspace-compatible either.
>=20
> This patch updates the conditional to depend on whether the system is
> actually targetting an "e500" or "e500mc" core and entirely removes =
the
> unused sync-to-lwsync-replacement on e500v1/e500v2 systems.
>=20
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
> arch/powerpc/include/asm/synch.h |   16 ++++------------
> 1 files changed, 4 insertions(+), 12 deletions(-)

Nak, we can run an e500mc in a mode that is compatible with e500v1/v2.  =
I see no reason to change the support we have there.

- k=
