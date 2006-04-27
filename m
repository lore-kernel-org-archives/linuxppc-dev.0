Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0CEF67A00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 21:07:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3RB7cM4009488
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 07:07:38 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3RB7cfm240512
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 07:07:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3RB7b2N028588
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 07:07:38 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/16] ehca: integration in Linux
	=?iso-8859-1?q?kernel=09build?= system
Date: Thu, 27 Apr 2006 13:07:36 +0200
References: <4450B384.4020601@de.ibm.com>
In-Reply-To: <4450B384.4020601@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604271307.36987.arnd.bergmann@de.ibm.com>
Cc: schickhj@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 April 2006 14:05, Heiko J Schick wrote:
> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 

Missing any description whatsoever.

> 
>   Kconfig  |    6 ++++++
>   Makefile |   29 +++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 

It would be more practical to put this patch last instead of
first so you don't break the build system with partial applies.

> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Kconfig    1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Kconfig 2006-01-04 16:29:05.000000000 +0100
> @@ -0,0 +1,6 @@
> +config INFINIBAND_EHCA
> +       tristate "eHCA support"
> +       depends on IBMEBUS && INFINIBAND
> +       ---help---
> +       This is a low level device driver for the IBM
> +       GX based Host channel adapters (HCAs)
> \ No newline at end of file
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Makefile   1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Makefile        2006-03-06 12:26:36.000000000 +0100
> @@ -0,0 +1,29 @@
> +#  Authors: Heiko J Schick <schickhj@de.ibm.com>
> +#           Christoph Raisch <raisch@de.ibm.com>
> +#
> +#  Copyright (c) 2005 IBM Corporation
> +#
> +#  All rights reserved.
> +#
> +#  This source code is distributed under a dual license of GPL v2.0 and OpenIB BSD.
> +
> +obj-$(CONFIG_INFINIBAND_EHCA) += hcad_mod.o
> +
> +hcad_mod-objs = ehca_main.o   \
> +               ehca_hca.o    \
> +               ehca_mcast.o  \
> +               ehca_pd.o     \
> +               ehca_av.o     \
> +               ehca_eq.o     \
> +               ehca_cq.o     \
> +               ehca_qp.o     \
> +               ehca_sqp.o    \
> +               ehca_mrmw.o   \
> +               ehca_reqs.o   \
> +               ehca_irq.o    \
> +               ehca_uverbs.o \
> +               hcp_if.o      \
> +               hcp_phyp.o    \
> +               ipz_pt_fn.o
> +
> +CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
> 
Do these need to be on the command line? If you always set them
anyways, you can probably get rid of the #ifdef checking for them.
If you want to keep the code for some reason, it might be better
to have a CONFIG_EHCA_USE_HCALL symbol that is set unconditionally
from Kconfig.

	Arnd <><
