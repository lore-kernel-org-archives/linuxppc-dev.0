Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 534091A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 04:20:43 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 22:50:40 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AC182E005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 22:51:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3HLCTb62324912
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 22:51:12 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3HKZDV005080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 22:50:36 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
In-Reply-To: <20141203155242.GE6043@suse.de>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-4-git-send-email-mgorman@suse.de>
 <1417473762.7182.8.camel@kernel.crashing.org>
 <87k32ah5q3.fsf@linux.vnet.ibm.com>
 <1417551115.27448.7.camel@kernel.crashing.org>
 <87lhmobvuu.fsf@linux.vnet.ibm.com> <20141203155242.GE6043@suse.de>
Date: Wed, 03 Dec 2014 22:50:35 +0530
Message-ID: <87d280bqfw.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Rik van Riel <riel@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, Hugh Dickins <hughd@google.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Dave Jones <davej@redhat.com>, Sasha Levin <sasha.levin@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Dec 03, 2014 at 08:53:37PM +0530, Aneesh Kumar K.V wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> 
>> > On Tue, 2014-12-02 at 12:57 +0530, Aneesh Kumar K.V wrote:
>> >> Now, hash_preload can possibly insert an hpte in hash page table even if
>> >> the access is not allowed by the pte permissions. But i guess even that
>> >> is ok. because we will fault again, end-up calling hash_page_mm where we
>> >> handle that part correctly.
>> >
>> > I think we need a test case...
>> >
>> 
>> I ran the subpageprot test that Paul had written. I modified it to ran
>> with selftest. 
>> 
>
> It's implied but can I assume it passed? 

Yes.

-bash-4.2# ./subpage_prot 
test: subpage_prot
tags: git_version:v3.17-rc3-13511-g0cd3756
allocated malloc block of 0x4000000 bytes at 0x0x3fffb0d10000
testing malloc block...
OK
success: subpage_prot
-bash-4.2# 
