Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 907682C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 13:52:25 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 12:52:09 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5DDE62BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 13:52:08 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C2WdwL57081964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 13:32:40 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C2q6aH027402
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 13:52:06 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH V2] powerpc: thp: Fix crash on mremap
In-Reply-To: <20140211173129.GB30336@kroah.com>
References: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211173129.GB30336@kroah.com>
Date: Wed, 12 Feb 2014 08:22:02 +0530
Message-ID: <87ioslt54d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Fri, Feb 07, 2014 at 07:21:57PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This patch fix the below crash
>> 
>> NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
>> LR [c0000000000439ac] .hash_page+0x18c/0x5e0
>> ...
>> Call Trace:
>> [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
>> [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
>> [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
>> 
>> On ppc64 we use the pgtable for storing the hpte slot information and
>> store address to the pgtable at a constant offset (PTRS_PER_PMD) from
>> pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
>> the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
>> from new pmd.
>> 
>> We also want to move the withdraw and deposit before the set_pmd so
>> that, when page fault find the pmd as trans huge we can be sure that
>> pgtable can be located at the offset.
>> 
>> variant of upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
>> for 3.12 stable series
>
> This doesn't look like a "variant", it looks totally different.  Why
> can't I just take the b3084f4db3aeb991c507ca774337c7e7893ed04f patch
> (and follow-on fix) for 3.12?

Because the code in that function changed in 3.13. Kirill added split
ptl locks for huge pte, and we decide whether to withdraw and
deposit again based on the ptl locks in 3.13. In 3.12 we do that only
for ppc64 using #ifdef


>
> I _REALLY_ dislike patches that are totally different from Linus's tree
> in stable trees, it has caused nothing but problems in the past.
>

-aneesh
