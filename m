Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31A581007D3
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 12:27:46 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329394210-1014-1-git-send-email-leoli@freescale.com>
Date: Thu, 16 Feb 2012 19:27:41 -0600
Message-Id: <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2012, at 6:10 AM, Li Yang wrote:

> Fix the problem that large physical address support cannot be
> disabled when some platforms which only provides 36-bit support
> are selected.  According to the philosophy of kernel config
> enabling a platform support doesn't mean the kernel is only
> running on that platform.  Remove the auto selection of PHYS_64BIT
> option for these platforms.  They will need to use a 36bit default
> config that selects PHYS_64BIT explicitly.
>=20
> The reason why we need to keep PHYS_64BIT option configurable is
> that enabling it cause negative performance impact on various
> aspects like TLB miss and physical address manipulating.  We should
> not enable it unless really needed, e.g. use large memory of 4GB
> or bigger.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig |    6 ------
> 1 files changed, 0 insertions(+), 6 deletions(-)

Nak, this isn't correct.

For some of these platforms like P2041RDB, P3041DS, P3060QDS, P4080DS, & =
P5020DS only a 36-bit physical address map is supported by u-boot and =
the device tree.  This was a decision that was made to NOT support =
32-bit address map for these boards and accept the performance =
implication of it to reduce the # of builds, etc.

Additionally, outside of maybe P2041RDB I believe the majority of these =
boards ship with 4G of DDR (but that off the top of my head) and thus =
require the 36-bit / PHYS_64BIT support to be enabled.

- k
