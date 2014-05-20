Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF04D1A084F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 17:53:16 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 20 May 2014 13:23:12 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 54FAB394004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 13:23:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K7rIEg2097586
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 13:23:18 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K7r6O7005316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 13:23:07 +0530
Message-ID: <537B09DF.1090906@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 13:23:03 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au>	<53797511.1050409@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
 <20140519164301.eafd3dd288ccb88361ddcfc7@linux-foundation.org>
 <20140520004429.E660AE009B@blue.fi.intel.com>
 <87oaythsvk.fsf@rustcorp.com.au>
 <20140520003201.a2360d5d.akpm@linux-foundation.org>
In-Reply-To: <20140520003201.a2360d5d.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, ak@linux.intel.com,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, paulus@samba.org, mgorman@suse.de,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 20 May 2014 01:02 PM, Andrew Morton wrote:
> On Tue, 20 May 2014 15:52:07 +0930 Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
>> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
>>> Andrew Morton wrote:
>>>> On Mon, 19 May 2014 16:23:07 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
>>>>
>>>>> Shouldn't FAULT_AROUND_ORDER and fault_around_order be changed to be
>>>>> the order of the fault-around size in bytes, and fault_around_pages()
>>>>> use 1UL << (fault_around_order - PAGE_SHIFT)
>>>>
>>>> Yes.  And shame on me for missing it (this time!) at review.
>>>>
>>>> There's still time to fix this.  Patches, please.
>>>
>>> Here it is. Made at 3.30 AM, build tested only.
>>
>> Prefer on top of Maddy's patch which makes it always a variable, rather
>> than CONFIG_DEBUG_FS.  It's got enough hair as it is.
>>
> 
> We're at 3.15-rc5 and this interface should be finalised for 3.16.  So
> Kirrill's patch is pretty urgent and should come first.
> 
> Well.  It's only a debugfs interface at this stage so we are allowed to
> change it later, but it's better not to.
>
My patchset does not change the interface, but uses the current fault
around order variable from CONFIG_DEBUG_FS block to allow changes at
runtime, instead of having a constant and some cleanup.

Thanks for review
Regards
--Maddy
