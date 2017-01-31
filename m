Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCFYX0DZSzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:43:43 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0V5hWgK063559
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 00:43:41 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28aec3bbs9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 00:43:41 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 15:43:38 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ED2BC2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:43:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0V5hRvp26738936
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:43:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0V5h3rq006189
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:43:03 +1100
Date: Tue, 31 Jan 2017 16:42:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, hankmax0000@gmail.com,
 williel@supermicro.com.tw
Subject: Re: [PATCH 0/3] powerpc/powernv: PCI hotplug fixes and improvement
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <20170131054238.GB9937@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2017 at 11:50:05AM +1100, Gavin Shan wrote:
>This series fixes couple issues or improves its reliability:
>
>   * The PDC event is never detected inside the IRQ handler in surprise
>     hot-add path.
>   * The slot's initial state should be REGISTERED state if it's emtpy.
>     Otherwise, the PCI devices behind the slot won't be populated properly
>     in hot-add path.
>   * PDC isn't reliable for hot-add on some machines. Introduce another
>     device-tree property to disable it if required by (skiboot) firmware.
>
>Gavin Shan (3):
>  drivers/pci/hotplug: Handle presence detection change properly
>  drivers/pci/hotplug: Fix initial state for empty slot
>  drivers/pci/hotplug: Mask PDC interrupt if required
>

Michael, could you help to take a look when you have available time?
I hope those 3 patches can be merged in next merge window, which seems
to come pretty soon.

Thanks,
Gavin

> arch/powerpc/include/asm/pnv-pci.h |  2 ++
> drivers/pci/hotplug/pnv_php.c      | 49 +++++++++++++++++++++++++++++++-------
> 2 files changed, 43 insertions(+), 8 deletions(-)
>
>-- 
>2.7.4
>
