Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcDxF1JGgzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 20:28:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Robert E. Cochran" <ppc@mindchasers.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix page table dump build on non-Book3S
In-Reply-To: <e0d44bac-65ff-fca4-437c-42872eff8842@mindchasers.com>
References: <1480582800-28597-1-git-send-email-mpe@ellerman.id.au>
 <e0d44bac-65ff-fca4-437c-42872eff8842@mindchasers.com>
Date: Mon, 06 Mar 2017 20:28:29 +1100
Message-ID: <87o9xepxdu.fsf@concordia.ellerman.id.au>
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

"Robert E. Cochran" <ppc@mindchasers.com> writes:

> On 12/01/2016 04:00 AM, Michael Ellerman wrote:
>> In the recent commit 1515ab932156 ("powerpc/mm: Dump hash table") we
>> added code to dump the hage page table. Currently this can be selected
>> to build on any platform. However it breaks the build if we're building
>> for a non-Book3S platform, because none of the hash page table related
>> defines and so on exist. So restrict it to building only on Book3S.
>>
>> Similarly in commit 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
>> we added code to dump the Linux page tables, which uses some constants
>> which are only defined on Book3S - so guard those with an #ifdef.
>
>
> Hello,
>
> I was just building the mainline 4.11-rc1 tonight on an NXP P1010 / 
> e500v2 with CONFIG_PPC_PTDUMP set.
>
> I received a bunch of errors from dump_linuxpagetables.c  (as you can 
> see below).
>
> I realize now that CONFIG_PPC_PTDUMP  isn't for the e500, but I thought 
> someone might want to know that enabling it causes the build of an 
> e500v2 to fail.

Thanks. It actually should work on that config, it's just dumping the
Linux page tables.

It looks like it's just that some of the "well known" address ranges
don't exist, or don't have the same names. So it should be fixable with
some #ifdefs.

I'll fix it at some point if no one beats me to it.

cheers
