Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJjss3cg7zDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 14:16:49 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1939QAP097770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 22:16:47 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28gcrj6ufc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 22:16:46 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 9 Feb 2017 08:46:43 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EC0A1E005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 08:48:07 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v193GeF529032506
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Feb 2017 08:46:40 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v193GdIj021602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Feb 2017 08:46:40 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] mm/autonuma: Let architecture override how the write
 bit should be stashed in a protnone pte.
In-Reply-To: <1486609259-6796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609259-6796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 09 Feb 2017 08:46:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737foqcj2.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Autonuma preserves the write permission across numa fault to avoid taking
> a writefault after a numa fault (Commit: b191f9b106ea " mm: numa: preserve PTE
> write permissions across a NUMA hinting fault"). Architecture can implement
> protnone in different ways and some may choose to implement that by clearing Read/
> Write/Exec bit of pte. Setting the write bit on such pte can result in wrong
> behaviour. Fix this up by allowing arch to override how to save the write bit
> on a protnone pte.
>

The problem we are trying to fix here is w.r.t autnuma related thp
migration. migrate_misplaced_transhuge_page() cannot deal with
concurrent modification of the page. It does a page copy without
following the migration pte sequence. IIUC, this was done to keep the
migration simpler and at the time of implemenation we didn't had THP
page cache which would have required a more elaborate migration scheme.
[1]. That means thp autonuma migration expect the protnone
with saved write to be done such that both kernel and user cannot update
the page content. This patch series enables archs like ppc64 to do that.
We are good with the hash translation mode with the current code,
because we never create a hardware page table entry for a protnone pte. 


-aneesh
