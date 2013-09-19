Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A54422C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 02:51:06 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 19 Sep 2013 10:51:02 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5FAA01FF001A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 10:50:55 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8JGoxcP323818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 10:50:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8JGoutt032060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 10:50:58 -0600
Date: Thu, 19 Sep 2013 09:50:35 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Does iommu_init_table need to use GFP_ATOMIC allocations?
Message-ID: <20130919165035.GA20144@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Under heavy (DLPAR?) stress, we tripped this panic() in
arch/powerpc/kernel/iommu.c::iommu_init_table():

        page = alloc_pages_node(nid, GFP_ATOMIC, get_order(sz));
        if (!page)
                panic("iommu_init_table: Can't allocate %ld bytes\n",
sz);

Before the panic() we got a page allocation failure for an order-2
allocation. There appears to be memory free, but perhaps not in the
ATOMIC context. I looked through all the call-sites of
iommu_init_table() and didn't see any obvious reason to need an ATOMIC
allocation. Most call-sites in fact have an explicit GFP_KERNEL
allocation shortly before the call to iommu_init_table(), indicating we
are not in an atomic context. There is some indirection for some paths,
but I didn't see any locks indicating that GFP_KERNEL is inappropriate.
Does anyone know if/why ATOMIC allocations are necessary here?

Thanks,
Nish
