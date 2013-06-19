Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFABD2C0343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 13:30:15 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 08:51:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6AC0EE0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 08:59:33 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J3UEmB25231488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 09:00:14 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J3U6ti016796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 13:30:07 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
In-Reply-To: <1371593004.21896.199.camel@pasglop>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1371348007.21896.62.camel@pasglop> <1371353865.21896.94.camel@pasglop>
 <1371355567.21896.101.camel@pasglop> <8738sfi7er.fsf@linux.vnet.ibm.com>
 <1371593004.21896.199.camel@pasglop>
Date: Wed, 19 Jun 2013 09:00:05 +0530
Message-ID: <87zjumhj5u.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2013-06-19 at 00:16 +0530, Aneesh Kumar K.V wrote:
>
>> But will that by anonymous memory ? ie, will we find them suitable for
>> THP allocation ?
>
> The 4k pages themselves with 4k_PFN no, but the segment yes. A single of
> these will demote the whole segment, ie 256M or 1T.
>
>> >   * If you find a THP in hash_page and the segment size is 4k, fault
>> >
>> >   * In do_page_fault, re-check for that condition (or maybe we can make
>> > hash_page return a specific bit that gets ORed into the error_code into
>> > do_page_fault ?) and split huge pages there.
>> >
>> > But that's just an idea off the top of my mind, there might be a better
>> > way. Of course this needs to be tested.
>> >
>> > BTW. For the subpage protection, similarily, you need to make sure you
>> > properly map the entire segment as "no THP", not just the range
>> > passed-in by the user.
>> 
>> Can you explain that more, why should the entire segment be marked no THP ?
>> The segment can work with 4K base page size and we still be able to
>> allocate a hugepage in that segment.
>
> Will we be able to track all the possible hashings of the huge page on a
> 4k segment ?

Yes. The comment above hpte_valid explains that 

 * The linux hugepage PMD now include the pmd entries followed by the address
 * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
 * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
 * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
 * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.


-aneesh
