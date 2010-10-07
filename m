Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B8E6B6F07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:01:54 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-pci: Fix MSI support on 83xx platforms
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1280995347-6550-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 7 Oct 2010 01:01:41 -0500
Message-Id: <F1C3CEE8-3439-41D4-8BD5-4C61BC183D51@kernel.crashing.org>
References: <1280995347-6550-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2010, at 3:02 AM, Kumar Gala wrote:

> The following commit broke 83xx because it assumed the 83xx platforms
> exposed the "IMMR" address in BAR0 like the 85xx/86xx/QoriQ devices =
do:
>=20
> commit 3da34aae03d498ee62f75aa7467de93cce3030fd
> Author: Kumar Gala <galak@kernel.crashing.org>
> Date:   Tue May 12 15:51:56 2009 -0500
>=20
>    powerpc/fsl: Support unique MSI addresses per PCIe Root Complex
>=20
> However that is not true, so we have to search through the inbound
> window settings on 83xx to find which one matches the IMMR address to
> determine its PCI address.
>=20
> Reported-by: Ilya Yanok <yanok@emcraft.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/sysdev/fsl_msi.c |    9 +++----
> arch/powerpc/sysdev/fsl_pci.c |   43 =
++++++++++++++++++++++++++++++++++++++++-
> arch/powerpc/sysdev/fsl_pci.h |    1 +
> 3 files changed, 47 insertions(+), 6 deletions(-)

applied to next

- k=
