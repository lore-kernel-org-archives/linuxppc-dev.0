Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMs9K5nW0zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:56:05 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E5nNHY029884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 00:56:03 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kjasvrd3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 00:56:03 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 22:56:02 -0700
Subject: Re: [PATCH V2 1/2] mm/autonuma: Let architecture override how the
 write bit should be stashed in a protnone pte.
To: Michael Ellerman <michaele@au1.ibm.com>, akpm@linux-foundation.org,
 Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87poilmien.fsf@concordia.ellerman.id.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 11:25:48 +0530
MIME-Version: 1.0
In-Reply-To: <87poilmien.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <abd9d231-c380-95b0-0722-8df7be626968@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 14 February 2017 11:19 AM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> Autonuma preserves the write permission across numa fault to avoid taking
>> a writefault after a numa fault (Commit: b191f9b106ea " mm: numa: preserve PTE
>> write permissions across a NUMA hinting fault"). Architecture can implement
>> protnone in different ways and some may choose to implement that by clearing Read/
>> Write/Exec bit of pte. Setting the write bit on such pte can result in wrong
>> behaviour. Fix this up by allowing arch to override how to save the write bit
>> on a protnone pte.
> This is pretty obviously a nop on arches that don't implement the new
> hooks, but it'd still be good to get an ack from someone in mm land
> before I merge it.


To get it apply cleanly you may need
http://ozlabs.org/~akpm/mmots/broken-out/mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes.patch
http://ozlabs.org/~akpm/mmots/broken-out/mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes-fix.patch

They are strictly not needed after the saved write patch. But I didn't 
request to drop them, because the patch helps us
to get closer to the goal of no ste_pte_at() call on present ptes.

-aneesh
