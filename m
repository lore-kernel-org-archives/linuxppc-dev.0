Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5AA32C024B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 22:33:29 +1000 (EST)
Subject: Re: [PATCH] driver/mtd:IFC NAND:Initialise internal SRAM before any
 write
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1347526489-20186-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 27 Sep 2012 07:33:17 -0500
Message-Id: <35D2D92E-D6B7-46CB-A3F2-6DAE2134EA30@kernel.crashing.org>
References: <1347526489-20186-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 13, 2012, at 3:54 AM, Prabhakar Kushwaha wrote:

> IFC-1.1.0 uses 28nm techenology for SRAM. This tech has known =
limitaion for
> SRAM i.e. "byte select" is not supported. Hence Read Modify Write is
> implemented in IFC for any "system side write" into sram buffer. =
Reading an
> uninitialized memory results in ECC Error from sram wrapper.
>=20
> Hence we must initialize/prefill SRAM buffer by any data before =
writing
> anything in SRAM from system side. To initialize SRAM user can use =
"READID"
> NAND command with read bytes equal to SRAM size. It will be a one time
> activity post boot.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon git://git.infradead.org/linux-mtd.git branch master
> The compilation of this patch depends upon following patch.
> http://patchwork.ozlabs.org/patch/177893/
> This patch is currently applied on =
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git=20
> branch next and status is "Awaiting Upstream"
>=20
>=20
> drivers/mtd/nand/fsl_ifc_nand.c |   56 =
++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 55 insertions(+), 1 deletion(-)

applied to next

- k=
