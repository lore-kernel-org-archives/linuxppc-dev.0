Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkB7r3JgYzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:42:16 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 19:12:12 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3BDg89h5898294
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 19:12:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3BDg5HY021025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 19:12:07 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
In-Reply-To: <1460373271.17837.3.camel@ellerman.id.au>
References: <3qWf364wYxz9sDG@ozlabs.org> <8737rau3b7.fsf@linux.vnet.ibm.com>
 <570B23CD.3090203@au1.ibm.com> <1460348865.3444.0.camel@ellerman.id.au>
 <878u0kahqn.fsf@linux.vnet.ibm.com> <1460373271.17837.3.camel@ellerman.id.au>
Date: Mon, 11 Apr 2016 19:12:01 +0530
Message-ID: <87y48kfeja.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Mon, 2016-04-11 at 10:01 +0530, Aneesh Kumar K.V wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > On Mon, 2016-04-11 at 14:10 +1000, Andrew Donnellan wrote:
>> > > On 29/03/16 00:42, Aneesh Kumar K.V wrote:
>> > > > I noticed this when doing radix support and have a variant posted at
>> > > > 
>> > > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-March/141036.html
>> > > 
>> > > I'm happy for this to be fixed in your radix series.
>> > 
>> > I'm not :)
>> > 
>> > This needs a stand-alone fix that we can backport.
>> 
>> It is done as an independent patch 
>> 
>> http://mid.gmane.org/1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com
>
> Sure, but that's still not a *fix*.
>
> A fix is a single commit, preferably with a subject that literally contains the
> word "fix" or "bug", which fixes just the bug and nothing else. It should also
> have a Fixes: line, if possible, and a Cc stable if appropriate.
>
> It should also describe clearly what the bug is, why it's serious or just
> annoying or whatever.
>
> In this case it *looks* like we have a giant hole in the mm handling for CAPI
> contexts, which would let userspace create mappings of kernel memory with
> _PAGE_USER set. I think I agree with Ian that in fact that's not true, but it's
> not clear from the diff that is the case. So I'd really like someone to write a
> good commit message demonstrating that we understand what the bug is and why
> it's not a big deal, despite the patch looking scary at first glance.
>

That confused me. Do you agree that the current code won't allow 
"userspace create mappings of kernel memory with  _PAGE_USER set" ?
Or are you suggesting that we do and this need to be documented ?

If it is later, that is not true. The current code will set _PAGE_USER
to the access flags for any fault address. ie, because ~ operation will
be true for all address we take fault on. But setting _PAGE_USER also means
that the fault will be handled only if the page table have _PAGE_USER
set.

Now if it is an user space access, then the change really don't have an
impact because we have (!ctx->kernel) true for that case and we take
that if condition true.

Now if kernel is faulting, which I am not sure capi can result such a
fault and it is faulting on a adress in the kernel range, then the
current code will result in a loop fault, because we will not insert
hash pte due to access and pte permission mismatch. So there is
no security hole in the fault handling AFAIU.

Are you suggesting that the above should be documented in the commit
message ?

-aneesh
