Return-Path: <pasha.tatashin@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RNdK2wtvzDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 03:45:40 +1000 (AEST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CHhsVK033050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:45:38 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2130.oracle.com with ESMTP id 2k2p76cv1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:45:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6CHjaj4027994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:45:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6CHja69030850
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:45:36 GMT
Received: by mail-oi0-f54.google.com with SMTP id d189-v6so57321316oib.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 10:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <1531416305.6480.24.camel@abdul.in.ibm.com>
In-Reply-To: <1531416305.6480.24.camel@abdul.in.ibm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 12 Jul 2018 13:44:59 -0400
Message-ID: <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
Subject: Re: [next-20180711][Oops] linux-next kernel boot is broken on powerpc
To: abdhalee@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, mpe@ellerman.id.au,
 sachinp@linux.vnet.ibm.com, venkatb3@in.ibm.com,
 manvanth@linux.vnet.ibm.com, sim@linux.vnet.ibm.com,
 Michal Hocko <mhocko@suse.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 aneesh.kumar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Related commit could be one of below ? I see lots of patches related to mm and could not bisect
>
> 5479976fda7d3ab23ba0a4eb4d60b296eb88b866 mm: page_alloc: restore memblock_next_valid_pfn() on arm/arm64
> 41619b27b5696e7e5ef76d9c692dd7342c1ad7eb mm-drop-vm_bug_on-from-__get_free_pages-fix
> 531bbe6bd2721f4b66cdb0f5cf5ac14612fa1419 mm: drop VM_BUG_ON from __get_free_pages
> 479350dd1a35f8bfb2534697e5ca68ee8a6e8dea mm, page_alloc: actually ignore mempolicies for high priority allocations
> 088018f6fe571444caaeb16e84c9f24f22dfc8b0 mm: skip invalid pages block at a time in zero_resv_unresv()

Looks like:
0ba29a108979 mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER

This patch is going to be reverted from linux-next. Abdul, please
verify that issue is gone once  you revert this patch.

Thank you,
Pavel
