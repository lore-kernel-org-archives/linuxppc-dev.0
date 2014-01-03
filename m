Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F10022C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2014 16:28:33 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 3 Jan 2014 15:28:30 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2554B2BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2014 16:28:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s035SDbw1769738
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jan 2014 16:28:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s035SP8Q022512
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jan 2014 16:28:25 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V2] powerpc: thp: Fix crash on mremap
In-Reply-To: <1388665786.4373.48.camel@pasglop>
References: <1388654266-5195-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140102094124.04D76E0090@blue.fi.intel.com>
 <87zjneodtw.fsf@linux.vnet.ibm.com> <1388665786.4373.48.camel@pasglop>
Date: Fri, 03 Jan 2014 10:58:14 +0530
Message-ID: <87wqihocr5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aarcange@redhat.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2014-01-02 at 16:22 +0530, Aneesh Kumar K.V wrote:
>> > Just use config option directly:
>> >
>> >       if (new_ptl != old_ptl ||
>> >               IS_ENABLED(CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW))
>> 
>> 
>> I didn't like that. I found the earlier one easier for reading.
>> If you and others strongly feel about this, I can redo the patch.
>> Please let me know
>
> Yes, use IS_ENABLED, no need to have two indirections of #define's
>
> Another option is to have
>
> 	if (pmd_move_must_withdraw(new,old)) {
> 	}
>
> With in a generic header:
>
> #ifndef pmd_move_must_withdraw
> static inline bool pmd_move_must_withdraw(spinlock_t *new_ptl, ...)
> {
> 	return new_ptl != old_ptl;
> }
> #endif
>
> And in powerpc:
>
> static inline bool pmd_move_must_withdraw(spinlock_t *new_ptl, ...)
> {
> 	return true;
> }
> #define pmd_move_must_withdraw pmd_move_must_withdraw

This is better i guess. It is also in-line with rest of transparent
hugepage functions. I will do this.

-aneesh
