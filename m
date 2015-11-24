Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 093CB1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:32:33 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 09:02:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5144E125805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:02:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAO3VLCn53084284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:01:22 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAO3VJo5010379
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:01:21 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 00/31] powerpc/mm: Update page table format for book3s
 64
In-Reply-To: <1448321325.4574.19.camel@kernel.crashing.org>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448321325.4574.19.camel@kernel.crashing.org>
Date: Tue, 24 Nov 2015 09:01:15 +0530
Message-ID: <8737vwul8c.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2015-11-23 at 15:52 +0530, Aneesh Kumar K.V wrote:
>> This patch series attempt to update book3s 64 linux page table format to
>> make it more flexible. Our current pte format is very restrictive and we
>> overload multiple pte bits. This is due to the non-availability of free bits
>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>> lower half of PTE page. The pte format is updated such that we have a
>> better method for identifying a pte entry at pmd level. This will also enable
>> us to implement hugetlb migration(not yet done in this series).
>> 
>> Before making the changes to the pte format, I am splitting the
>> pte header definition such that we now have the below layout for headers
>
> This series actually completely removes the tracking of the subages,
> right ? IE, it also halves the memory footprint of page tables, doesn't
> it ?
>

No, that is done in the next series.

http://mid.gmane.org/1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

-aneesh
