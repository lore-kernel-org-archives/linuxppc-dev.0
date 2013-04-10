Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AFC62C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:55:25 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 13:20:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DC6013940057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 13:25:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A7tGHY61800698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 13:25:16 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A7tHpT020149
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:55:18 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH -V5 06/25] powerpc: Reduce PTE table memory wastage
In-Reply-To: <20130410071453.GB24786@concordia>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130410071453.GB24786@concordia>
Date: Wed, 10 Apr 2013 13:24:59 +0530
Message-ID: <87obdmom5o.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> On Thu, Apr 04, 2013 at 11:27:44AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We allocate one page for the last level of linux page table. With THP and
>> large page size of 16MB, that would mean we are wasting large part
>> of that page. To map 16MB area, we only need a PTE space of 2K with 64K
>> page size. This patch reduce the space wastage by sharing the page
>> allocated for the last level of linux page table with multiple pmd
>> entries. We call these smaller chunks PTE page fragments and allocated
>> page, PTE page.
>
> This is not compiling for me:
>
> arch/powerpc/mm/mmu_context_hash64.c:118:3: error: implicit declaration of function 'reset_page_mapcount'
>

can you share the .config ? I have the git tree at 

git://github.com/kvaneesh/linux.git ppc64-thp-7

-aneesh
