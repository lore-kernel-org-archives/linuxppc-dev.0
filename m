Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 70E972C012B
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 23:46:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: p1022ds: disable the NAND flash node if
 video is enabled
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342207722-2315-1-git-send-email-timur@freescale.com>
Date: Tue, 17 Jul 2012 08:38:29 -0500
Message-Id: <6BA882F5-C78C-4316-9882-C4DAA4F03460@kernel.crashing.org>
References: <1342207722-2315-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 13, 2012, at 2:28 PM, Timur Tabi wrote:

> The Freescale P1022 has a unique pin muxing "feature" where the DIU =
video
> controller's video signals are muxed with 24 of the local bus address =
signals.
> When the DIU is enabled, the bulk of the local bus is disabled, =
preventing
> access to memory-mapped devices like NAND flash and the pixis FPGA.
>=20
> Therefore, if the DIU is going to be enabled, then memory-mapped =
devices on
> the localbus, like NAND flash, need to be disabled.
>=20
> This patch is similar to "powerpc/85xx: p1022ds: disable the NOR flash =
node
> if video is enabled", except that it disables the NAND flash node =
instead.
> This PIXIS node needs to remain enabled because it is used by platform =
code
> to switch into indirect mode.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |   58 =
+++++++++++++++++++++-----------
> 1 files changed, 38 insertions(+), 20 deletions(-)

applied to next

- k=
