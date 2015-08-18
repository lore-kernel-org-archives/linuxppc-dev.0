Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 123E91A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:36:32 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 11:06:30 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 330E83940061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 11:06:28 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I5aRAv14417942
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 11:06:27 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I5aQGi018000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 11:06:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 7/8] powerpc/mm: kasan: Add kasan support for ppc64
In-Reply-To: <CAPAsAGxSpA7XYWzL9R=uewwgF7-wN9ihbXQto-csd=RBWbPZqw@mail.gmail.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <55D1CFE7.2070801@gmail.com>
 <CAPAsAGxSpA7XYWzL9R=uewwgF7-wN9ihbXQto-csd=RBWbPZqw@mail.gmail.com>
Date: Tue, 18 Aug 2015 11:06:26 +0530
Message-ID: <874mjxp38l.fsf@linux.vnet.ibm.com>
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

Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:

> 2015-08-17 15:13 GMT+03:00 Andrey Ryabinin <ryabinin.a.a@gmail.com>:
>>
>> Did you disable stack instrumentation (in scripts/Makefile.kasa),
>> or you version of gcc doesn't support it (e.g. like 4.9.x on x86) ?
>>
>> Because this can't work with stack instrumentation as you don't have shadow for stack in early code.
>>
>> But this should be doable, as I think. All you need is to setup shadow for init task's
>> stack before executing any instrumented function.
>
> And you also need to define CONFIG_KASAN_SHADOW_OFFSET, so it will be
> passed to GCC
> via -fasan-shadow-offset= option.

I am using KASAN minimal config. Hence this was not needed. Do we need
to pass that option for outline instrumentation ? If not it would be a
good idea to split that out and make it depend on KASAN_INLINE

-aneesh
