Return-Path: <srs0=nhj8=fc=linux.vnet.ibm.com=bryantly@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zchN249pJzF18p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 02:05:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zchN23YZFz8tDv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 02:05:54 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zchN20DmBz9s7v
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2018 02:05:53 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w18F4OaM109302
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2018 10:05:52 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g0rs48fjh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Feb 2018 10:05:51 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Thu, 8 Feb 2018 10:05:50 -0500
Subject: Re: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
To: Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
 torvalds@linux-foundation.org, ruscur@russell.cc,
 jjalvare@linux.vnet.ibm.com
References: <20180208122035.9305-1-mpe@ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 09:05:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180208122035.9305-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <dcfc6411-20cf-5b3f-20c5-14167de54700@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2/8/18 6:20 AM, Michael Ellerman wrote:

> There's no reason pci_uevent_ers() needs to be inline in pci.h, so
> move it out to a C file.
>
> Given it's used by AER the obvious location would be somewhere in
> drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
> unfortunately that doesn't work in the case where EEH is enabled but
> PCIEPORTBUS is not.
>
> So for now put it in pci-driver.c, next to pci_uevent(), with an
> appropriate #ifdef so it's not built if AER and EEH are both disabled.
>
> While we're moving it also fix up the kernel doc comment for @pdev to
> be accurate.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/pci/pci-driver.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h      | 38 +++-----------------------------------
>  2 files changed, 39 insertions(+), 35 deletions(-)

Looks good, thanks for fixing it!

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>

-Bryant
