Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjGly1kpxzF1FG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 13:09:01 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1G28iRf103371
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 21:08:59 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5kea51nu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 21:08:59 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Feb 2018 02:08:55 -0000
Subject: Re: [PATCH v2] cxl: Check if PSL data-cache is available before issue
 flush request
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
References: <20180215154924.22005-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 16 Feb 2018 13:08:51 +1100
MIME-Version: 1.0
In-Reply-To: <20180215154924.22005-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8804fac8-3a7b-b053-8050-aa09667f537f@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/18 02:49, Vaibhav Jain wrote:
> PSL9D doesn't have a data-cache that needs to be flushed before
> resetting the card. However when cxl tries to flush data-cache on such
> a card, it times-out as PSL_Control register never indicates flush
> operation complete due to missing data-cache. This is usually
> indicated in the kernel logs with this message:
> 
> "WARNING: cache flush timed out"
> 
> To fix this the patch checks PSL_Debug register CDC-Field(BIT:27)
> which indicates the absence of a data-cache and sets a flag
> 'no_data_cache' in 'struct cxl_native' to indicate this. When
> cxl_data_cache_flush() is called it checks the flag and if set bails
> out early without requesting a data-cache flush operation to the PSL.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

LGTM

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
