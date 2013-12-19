Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A6582C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:03:19 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 Dec 2013 12:32:55 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 56AACE0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 12:35:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBJ72lUL54919326
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 12:32:48 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBJ72owg012601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 12:32:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
In-Reply-To: <0AB88010-F2B7-44A1-8FA9-2A40079706BB@suse.de>
References: <1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <0AB88010-F2B7-44A1-8FA9-2A40079706BB@suse.de>
Date: Thu, 19 Dec 2013 12:32:50 +0530
Message-ID: <87bo0d9vc5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 11.11.2013, at 15:02, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Don't try to compute these values.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> 
>> NOTE: I am not sure why we were originally computing dsisr and dar. So may be
>> we need a variant of this patch. But with this and the additional patch
>> "powerpc: book3s: PR: Enable Little Endian PR guest" I am able to get a Little Endian
>> PR guest to boot.
>
> It's quite easy to find out - git blame tells you all the history and points you to commit ca7f4203b.
>
> commit ca7f4203b9b66e12d0d9968ff7dfe781f3a9695a
> Author: Alexander Graf <agraf@suse.de>
> Date:   Wed Mar 24 21:48:28 2010 +0100
>
>     KVM: PPC: Implement alignment interrupt
>
>     Mac OS X has some applications - namely the Finder - that require alignment
>     interrupts to work properly. So we need to implement them.
>
>     But the spec for 970 and 750 also looks different. While 750 requires the
>     DSISR and DAR fields to reflect some instruction bits (DSISR) and the fault
>     address (DAR), the 970 declares this as an optional feature. So we need
>     to reconstruct DSISR and DAR manually.
>
>     Signed-off-by: Alexander Graf <agraf@suse.de>
>     Signed-off-by: Avi Kivity <avi@redhat.com>
>
> Read this as "on 970, alignment interrupts don't give us DSISR and DAR of the faulting instruction" as otherwise I wouldn't have implemented it.
>
> So this is clearly a nack on this patch :).

I can possibly do a if (cpu_has_feature(CPU_FTR_ARCH_201)). But do we need
to do that ? According to Paul we should always find DAR.

-aneesh
