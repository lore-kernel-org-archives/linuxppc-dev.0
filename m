Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LgpL1QbLzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 11:52:09 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w651mncK031338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 21:52:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k15p676ud-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 21:52:06 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 5 Jul 2018 02:52:04 +0100
Subject: Re: [PATCH] cxl: Fix wrong comparison in cxl_adapter_context_get()
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Cc: Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>, stable@vger.kernel.org
References: <20180704152833.2288-1-vaibhav@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 5 Jul 2018 11:51:58 +1000
MIME-Version: 1.0
In-Reply-To: <20180704152833.2288-1-vaibhav@linux.ibm.com>
Message-Id: <8ee7ba2c-3de4-5659-0be0-e41aa8aaec80@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/18 01:28, Vaibhav Jain wrote:
> Function atomic_inc_unless_negative() returns a bool to indicate
> success/failure. However cxl_adapter_context_get() wrongly compares
> the return value against '>=0' which will always be true. The patch
> fixes this comparison to '==0' there by also fixing this compile time
> warning:
> 
> 	drivers/misc/cxl/main.c:290 cxl_adapter_context_get()
> 	warn: 'atomic_inc_unless_negative(&adapter->contexts_num)' is unsigned
> 
> Cc: stable@vger.kernel.org
> Fixes: 70b565bbdb91 ("cxl: Prevent adapter reset if an active context exists")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
