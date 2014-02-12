Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF6A82C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 13:54:15 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 08:24:12 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3DD86E0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 08:27:29 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C2s4PL28508388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 08:24:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C2s9HG032533
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 08:24:09 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] powerpc: thp: Fix crash on mremap
In-Reply-To: <1392144772.23418.11.camel@pasglop>
References: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211173129.GB30336@kroah.com> <1392144772.23418.11.camel@pasglop>
Date: Wed, 12 Feb 2014 08:24:08 +0530
Message-ID: <87fvnpt50v.fsf@linux.vnet.ibm.com>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2014-02-11 at 09:31 -0800, Greg KH wrote:
>> On Fri, Feb 07, 2014 at 07:21:57PM +0530, Aneesh Kumar K.V wrote:
>> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> > 
>> > This patch fix the below crash
>> > 
>> > NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
>> > LR [c0000000000439ac] .hash_page+0x18c/0x5e0
>> > ...
>> > Call Trace:
>> > [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
>> > [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
>> > [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
>> > 
>> > On ppc64 we use the pgtable for storing the hpte slot information and
>> > store address to the pgtable at a constant offset (PTRS_PER_PMD) from
>> > pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
>> > the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
>> > from new pmd.
>> > 
>> > We also want to move the withdraw and deposit before the set_pmd so
>> > that, when page fault find the pmd as trans huge we can be sure that
>> > pgtable can be located at the offset.
>> > 
>> > variant of upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
>> > for 3.12 stable series
>> 
>> This doesn't look like a "variant", it looks totally different.  Why
>> can't I just take the b3084f4db3aeb991c507ca774337c7e7893ed04f patch
>> (and follow-on fix) for 3.12?
>> 
>> I _REALLY_ dislike patches that are totally different from Linus's tree
>> in stable trees, it has caused nothing but problems in the past.
>
> I don't think it applies... (I tried on an internal tree) but the
> affected function changed in 3.13 in various ways. Aneesh, please
> provide a more details explanation and whether we should backport those
> other changes too or whether this is not necessary

Yes the affected function added support for split ptl locks for huge
pte. I don't think that is a stable material.

.
>
> BTW. Aneesh, we need a 3.11.x one too
>

3.11.x it is already applied.

-aneesh
