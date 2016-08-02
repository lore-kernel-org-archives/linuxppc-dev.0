Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3ncf0Sg3zDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 06:20:01 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u72KEWJU025043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 16:19:59 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24k0bmn0s6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 16:19:59 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 16:19:58 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C838F38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 16:19:55 -0400 (EDT)
Subject: Re: [PATCH v4 1/2] powerpc/pseries: Implement indexed-count hotplug
 memory add
To: Sahil Mehta <smehta@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <437ead25-8938-a0e8-c7cf-8ead45e5ef3b@linux.vnet.ibm.com>
 <c8065de6-0f59-44a1-0e18-fc2dbb115839@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 2 Aug 2016 15:19:53 -0500
MIME-Version: 1.0
In-Reply-To: <c8065de6-0f59-44a1-0e18-fc2dbb115839@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <74a59ac8-7e81-694c-2b49-366518e58e7c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2016 12:21 PM, Sahil Mehta wrote:
> Indexed-count add for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be assigned (NOT
> that <count> lmbs will be added). Because of Qemu's per-DIMM memory
> management, the addition of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count add reduces
> this series into a single call.
> 
> Signed-off-by: Sahil Mehta <smehta@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> v2:	-remove potential memory leak when parsing command
> 	-use u32s drc_index and count instead of u32 ic[]
> 	 in dlpar_memory
> v3:	-add logic to handle invalid drc_index input
> 	-update indexed-count trigger to follow naming convention
> 	-update dlpar_memory to follow kernel if-else style
> v4: 	-add logic to handle kstrdup failure
> 	-add logic to handle invalid command format
> 
>  arch/powerpc/include/asm/rtas.h                 |    2
>  arch/powerpc/platforms/pseries/dlpar.c          |   46 +++++++++-
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  110 +++++++++++++++++++++--
>  3 files changed, 146 insertions(+), 12 deletions(-)
