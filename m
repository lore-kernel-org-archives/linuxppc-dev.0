Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76443B6F1C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 07:51:16 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl_pci: Fix P2P bridge handling for MPC83xx PCIe
	controllers
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091207225435.GA18485@oksana.dev.rtsoft.ru>
Date: Wed, 9 Dec 2009 14:51:05 -0600
Message-Id: <738EDEFC-DC2B-4E4D-AA9B-B7B620E76B8A@kernel.crashing.org>
References: <20091207225435.GA18485@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, "B.J. Buchalter" <bj@mhlabs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2009, at 4:54 PM, Anton Vorontsov wrote:

> It appears that we wrongly calculate dev_base for type1 config cycles.
> The thing is: we shouldn't subtract hose->first_busno because PCI core
> sets PCI primary, secondary and subordinate bus numbers, and PCIe
> controller actually takes the registers into account. So we should use
> just bus->number.
> 
> Also, according to MPC8315 reference manual, primary bus number should
> always remain 0. We have PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS quirk
> in indirect_pci.c, but since 83xx is somewhat special, it doesn't use
> indirect_pci.c routines, so we have to implement the quirk specifically
> for 83xx PCIe controllers.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

applied to next

- k
