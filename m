Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88D392C0246
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Sep 2013 01:39:29 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 26 Sep 2013 11:39:26 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 241266E8044
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 11:39:23 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8QFdNZ345809810
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 15:39:23 GMT
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8QFdJp7027448
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 09:39:19 -0600
Date: Thu, 26 Sep 2013 23:39:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/pseries: CONFIG_PSERIES_MSI should depend on
 PPC_PSERIES
Message-ID: <20130926153916.GA11159@shangw.(null)>
References: <1380181937-15156-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380181937-15156-1-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 05:52:16PM +1000, Michael Ellerman wrote:
>Previously PSERIES_MSI depended on PPC_PSERIES via EEH. However in
>commit 317f06d "powerpc/eeh: Move common part to kernel directory" we
>made CONFIG_EEH selectable on POWERNV. That leaves us with PSERIES_MSI
>being live even when PSERIES=n. Fix it by making PSERIES_MSI depend
>directly on PPC_PSERIES.
>
>Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/pseries/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>index 62b4f80..e666432 100644
>--- a/arch/powerpc/platforms/pseries/Kconfig
>+++ b/arch/powerpc/platforms/pseries/Kconfig
>@@ -34,7 +34,7 @@ config PPC_SPLPAR
>
> config PSERIES_MSI
>        bool
>-       depends on PCI_MSI && EEH
>+       depends on PCI_MSI && PPC_PSERIES && EEH
>        default y
>
> config PSERIES_ENERGY

Thanks,
Gavin
