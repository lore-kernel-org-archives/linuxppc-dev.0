Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D6C02C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 17:26:59 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 3 Jun 2013 04:23:59 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B13CF2CE8023
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 17:26:56 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r527QmZP24707294
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 17:26:48 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r527Qtd8011873
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 17:26:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Always invalidate tlb on hpte invalidate and
 update
In-Reply-To: <20130601111908.GA16571@concordia>
References: <1369998204-31490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130601111908.GA16571@concordia>
Date: Sun, 02 Jun 2013 12:56:54 +0530
Message-ID: <87zjv9as75.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> On Fri, May 31, 2013 at 04:33:24PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> If a hash bucket gets full, we "evict" a more/less random entry from it.
>> When we do that we don't invalidate the TLB (hpte_remove) because we assume
>> the old translation is still technically "valid". This implies that when
>> we are invalidating or updating pte, even if HPTE entry is not valid
>> we should do a tlb invalidate.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Has this always been a bug? I assume not.
>
> I'm asking because I have a kernel that's crashing and I'm wondering if
> I might need this commit.

Which config are you seeing the issue ? The changes should not impact
lpar. Can you share more info on crashes. There is a high chance that any crashes
that we are seeing in ppc64 can be the result of THP related changes,
because that did touch some subtle areas like tlb flushing,page table format etc.

-aneesh
