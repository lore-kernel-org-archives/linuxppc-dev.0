Return-Path: <apopple@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0bG16gD0zDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:23:05 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L6IVJT096497
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 02:23:03 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2675yg7vd3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 02:23:03 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <apopple@au1.ibm.com>;
 Fri, 21 Oct 2016 16:23:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3EB822BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:22:58 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L6MwFs7864708
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:22:58 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L6MuPb016833
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:22:58 +1100
From: Alistair Popple <apopple@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>,
 linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/5] drivers/of: do not add memory for unavailable nodes
Date: Fri, 21 Oct 2016 17:22:54 +1100
In-Reply-To: <1475778995-1420-3-git-send-email-arbab@linux.vnet.ibm.com>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-3-git-send-email-arbab@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2344394.NlaWgtFOqB@new-mexico>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Reza,

On Thu, 6 Oct 2016 01:36:32 PM Reza Arbab wrote:
> Respect the standard dt "status" property when scanning memory nodes in
> early_init_dt_scan_memory(), so that if the node is unavailable, no
> memory will be added.

What happens if a kernel without this patch is booted on a system with some 
status="disabled" device-nodes? Do older kernels just ignore this memory or do 
they try to use it?

>From what I can tell it seems that kernels without this patch will try and use 
this memory even if it is marked in the device-tree as status="disabled" which 
could lead to problems for older kernels when we start exporting this property 
from firmware.

Arguably this might not be such a problem in practice as we probably don't 
have many (if any) existing kernels that will boot on hardware exporting these 
properties. However given this patch seems fairly independent perhaps it is 
worth sending as a separate fix if it is not going to make it into this 
release?

Regards,

Alistair

> The use case at hand is accelerator or device memory, which may be
> unusable until post-boot initialization of the memory link. Such a node
> can be described in the dt as any other, given its status is "disabled".
> Per the device tree specification,
> 
> "disabled"
> 	Indicates that the device is not presently operational, but it
> 	might become operational in the future (for example, something
> 	is not plugged in, or switched off).
> 
> Once such memory is made operational, it can then be hotplugged.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index b138efb..08e5d94 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1056,6 +1056,9 @@ int __init early_init_dt_scan_memory(unsigned long 
node, const char *uname,
>  	} else if (strcmp(type, "memory") != 0)
>  		return 0;
>  
> +	if (!of_flat_dt_device_is_available(node))
> +		return 0;
> +
>  	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
>  	if (reg == NULL)
>  		reg = of_get_flat_dt_prop(node, "reg", &l);
> 
