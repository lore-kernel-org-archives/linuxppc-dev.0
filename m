Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3ndK41GgzDqVH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 06:20:37 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u72KEbvO023220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 16:20:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24k0bmctnh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 16:20:34 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:20:34 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 339CB1FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:20:13 -0600 (MDT)
Subject: Re: [PATCH v4 2/2] powerpc/pseries: Implement indexed-count hotplug
 memory remove
To: Sahil Mehta <smehta@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <437ead25-8938-a0e8-c7cf-8ead45e5ef3b@linux.vnet.ibm.com>
 <9576c930-a87e-1d0c-e56b-7745d0b32137@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 2 Aug 2016 15:20:28 -0500
MIME-Version: 1.0
In-Reply-To: <9576c930-a87e-1d0c-e56b-7745d0b32137@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <497a8795-ad32-1f18-2e55-2be2a33668d9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2016 12:23 PM, Sahil Mehta wrote:
> Indexed-count remove for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
> management, the removal of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count remove reduces
> this series into a single call.
> 
> Signed-off-by: Sahil Mehta <smehta@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> v2:	-use u32s drc_index and count instead of u32 ic[]
> 	 in dlpar_memory
> v3:	-add logic to handle invalid drc_index input
> v4:	-none
> 
>  arch/powerpc/platforms/pseries/hotplug-memory.c |   90 +++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
