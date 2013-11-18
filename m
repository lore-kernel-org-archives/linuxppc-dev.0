Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 935EA2C033B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:35 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Nov 2013 19:28:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5D5CE3578050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAI9AclP7799090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:10:38 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAI9SM6Q019627
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:22 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64
Date: Mon, 18 Nov 2013 14:58:08 +0530
Message-Id: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series add support for numa faults on ppc64 architecture. We steal the
_PAGE_COHERENCE bit and use that for indicating _PAGE_NUMA. We clear the _PAGE_PRESENT bit
and also invalidate the hpte entry on setting _PAGE_NUMA. The next fault on that
page will be considered a numa fault.

Changes from V1:
* Dropped few patches related pmd update because batch handling of pmd pages got dropped from core code
   0f19c17929c952c6f0966d93ab05558e7bf814cc "mm: numa: Do not batch handle PMD pages"
   This also avoided the large lock contention on page_table_lock that we observed with the previous series.

 -aneesh
 
