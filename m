Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27C411A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 22:05:35 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E96D3140BB3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 22:05:34 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 21:05:33 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 887922CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 22:05:31 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SB5OIp48300168
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 22:05:33 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SB4w8x005508
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 22:04:58 +1100
Message-ID: <56A9F5C8.3090409@linux.vnet.ibm.com>
Date: Thu, 28 Jan 2016 16:34:40 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] powerpc/mm: Enable HugeTLB page migration
References: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2016 02:41 PM, Anshuman Khandual wrote:
> This enables HugeTLB page migration for PPC64_BOOK3S systems which implement
> HugeTLB page at the PMD level. It enables the kernel configuration option

As mentioned above, it works only for 16MB HugeTLB page migration on 64K base
pages implemented right on the PMD as a single PTE but not for the 16MB HugeTLB
page on 4K base pages implemented through huge page directory. As generic
VM migrate code does not look into the page table structure when initiating
migration of 16MB on 4K it will just fail without stating the reason which
might be some times confusing. I can edit the commit message to capture this
point if needed.
