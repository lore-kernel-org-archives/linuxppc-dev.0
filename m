Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rhDs70FbCzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 10:38:02 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u620Xjqj053188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 20:38:01 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23whjd1527-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 20:38:00 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 2 Jul 2016 10:37:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 235D72BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 10:37:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u620bu1254788276
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Jul 2016 10:37:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u620btkk032064
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Jul 2016 10:37:55 +1000
Date: Sat, 2 Jul 2016 10:37:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com,
 alex.williamson@redhat.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, corbet@lwn.net,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com
Subject: Re: [PATCH v3 5/7] PCI: Do not use IORESOURCE_STARTALIGN to identify
 bridge resources
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160701023423.GB6739@gwshan>
 <c97584a0-b5b1-8660-1e16-04c43570eca6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c97584a0-b5b1-8660-1e16-04c43570eca6@linux.vnet.ibm.com>
Message-Id: <20160702003754.GB7582@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 01, 2016 at 03:04:10PM +0800, Yongji Xie wrote:
>Hi Gavin,
>
>On 2016/7/1 10:34, Gavin Shan wrote:
>
>>On Thu, Jun 30, 2016 at 06:53:11PM +0800, Yongji Xie wrote:
>>>Now we use the IORESOURCE_STARTALIGN to identify bridge resources
>>>in __assign_resources_sorted(). That's quite fragile. We may also
>>>set flag IORESOURCE_STARTALIGN for SR-IOV resources in some cases,
>>>for example, using the option "noresize" of parameter
>>>"pci=resource_alignment".
>>>
>>>In this patch, we try to use a more robust way to identify
>>>bridge resources.
>>>
>>>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>Yongji, I think this doesn't have to be part of this series, meaning
>>it can be sent or merged separately.
>>
>
>Seems like I give a wrong example in my changelog.  The
>parameter "pci=resource_alignment" would not set flag
>IORESOURCE_STARTALIGN for SR-IOV resources as I replied
>to you in previous patch. So this patch has nothing to do
>with this series now, I will remove it as you suggested.
>

Thanks, please refine the changelog as it's not related to the
enforced alignment as you claimed when resending it separately.

Thanks,
Gavin
