Return-Path: <B11780@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E984B2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 23:22:44 +1000 (EST)
Received: from mail44-am1 (localhost [127.0.0.1])	by mail44-am1-R.bigfish.com
 (Postfix) with ESMTP id C92F518019A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2012 13:22:38 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.254])	by
 mail44-am1.bigfish.com (Postfix) with ESMTP id 2DADC1A004E	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 13:22:36 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Lan Chunhe-B25806 <B25806@freescale.com>
Subject: Re: [PATCH 1/3] edac: Use ccsr_pci structure instead of hardcoded
 define
Date: Wed, 3 Oct 2012 13:22:32 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D5EC176@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 27, 2012, at 2:02 PM, Chunhe Lan wrote:

> There are some differences of register offset and definition between
> pci and pcie error management registers. While, some other pci/pcie
> error management registers are nearly the same.
>=20
> To merge pci and pcie edac code into one, it is easier to use ccsr_pci
> structure than the hardcoded define. So remove the hardcoded define and
> add pci/pcie error management register in ccsr_pci structure.
>=20
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.h |   46 +++++++++++++++++++++++++++++++++---=
----
> drivers/edac/mpc85xx_edac.h   |   12 +---------
> 2 files changed, 40 insertions(+), 18 deletions(-)

This patch breaks building the kernel.  You can't remove the defines MPC85X=
X_PCI_ERR_* and not change the code that uses them

- k=
