Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMzwb2nn1zDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:00:30 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EAwiEO053391
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 06:00:28 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kgdkw5ce-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 06:00:27 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Tue, 14 Feb 2017 21:00:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 56A203578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:00:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1EB0F7t31719564
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:00:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1EAxo1p017792
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 21:59:51 +1100
From: Michael Ellerman <michaele@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mm/autonuma: Let architecture override how the
 write bit should be stashed in a protnone pte.
In-Reply-To: <abd9d231-c380-95b0-0722-8df7be626968@linux.vnet.ibm.com>
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87poilmien.fsf@concordia.ellerman.id.au>
 <abd9d231-c380-95b0-0722-8df7be626968@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 21:59:23 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lzxm41g.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> On Tuesday 14 February 2017 11:19 AM, Michael Ellerman wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>
>>> Autonuma preserves the write permission across numa fault to avoid taking
>>> a writefault after a numa fault (Commit: b191f9b106ea " mm: numa: preserve PTE
>>> write permissions across a NUMA hinting fault"). Architecture can implement
>>> protnone in different ways and some may choose to implement that by clearing Read/
>>> Write/Exec bit of pte. Setting the write bit on such pte can result in wrong
>>> behaviour. Fix this up by allowing arch to override how to save the write bit
>>> on a protnone pte.
>> This is pretty obviously a nop on arches that don't implement the new
>> hooks, but it'd still be good to get an ack from someone in mm land
>> before I merge it.
>
>
> To get it apply cleanly you may need
> http://ozlabs.org/~akpm/mmots/broken-out/mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes.patch
> http://ozlabs.org/~akpm/mmots/broken-out/mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes-fix.patch

Ah OK, I missed those.

In that case these two should probably go via Andrew's tree.

cheers
