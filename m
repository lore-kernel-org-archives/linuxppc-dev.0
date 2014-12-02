Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5CC51A013C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 18:27:18 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 12:57:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 733551258056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 12:57:28 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB27RjoV66781430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 12:57:46 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB27R876029494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 12:57:09 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
In-Reply-To: <1417473762.7182.8.camel@kernel.crashing.org>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-4-git-send-email-mgorman@suse.de>
 <1417473762.7182.8.camel@kernel.crashing.org>
Date: Tue, 02 Dec 2014 12:57:00 +0530
Message-ID: <87k32ah5q3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Sasha Levin <sasha.levin@oracle.com>,
 Dave Jones <davej@redhat.com>, LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2014-11-21 at 13:57 +0000, Mel Gorman wrote:
>> Convert existing users of pte_numa and friends to the new helper. Note
>> that the kernel is broken after this patch is applied until the other
>> page table modifiers are also altered. This patch layout is to make
>> review easier.
>
> Aneesh, the removal of the DSISR_PROTFAULT checks, I wonder if we might
> break something here ... (I know, I asked for them to be removed :-)
>

That is the reason I converted that to a WARN_ON in later patch. 

> IE, we basically bounce all protection checks to the "normal" VMA
> protection checking, so far so good...
>
> But what about the subpage protection stuff ? Will that still work ?
>

I did look at that before. So if we had subpage access limitted, when we
take a fault for that subpage, we bail out early in hash_page_mm. (with
rc = 2). low_hash_fault handle that case directly. We will not end up
calling do_page_fault.

Now, hash_preload can possibly insert an hpte in hash page table even if
the access is not allowed by the pte permissions. But i guess even that
is ok. because we will fault again, end-up calling hash_page_mm where we
handle that part correctly.

-aneesh
