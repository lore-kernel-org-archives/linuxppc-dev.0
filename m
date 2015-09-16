Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E47B31A0343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 15:58:04 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 11:28:01 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CC3C2E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 11:27:28 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8G5vu0149348612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 11:27:56 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8G5vtuX004513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 11:27:55 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Recompute hash value after a failed update
In-Reply-To: <1442378949.21531.1.camel@ellerman.id.au>
References: <1442300408-26490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87vbbbdp3g.fsf@linux.vnet.ibm.com> <1442378949.21531.1.camel@ellerman.id.au>
Date: Wed, 16 Sep 2015 11:27:54 +0530
Message-ID: <87r3lyewil.fsf@linux.vnet.ibm.com>
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

> On Wed, 2015-09-16 at 08:53 +0530, Aneesh Kumar K.V wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> 
>> > If we had secondary hash flag set, we ended up modifying hash value in
>> > the updatepp code path. Hence with a failed updatepp we will be using
>> > a wrong hash value for the following hash insert. Fix this by
>> > recomputing hash before insert.
>> 
>> Without this patch we can end up with using wrong slot number in linux
>> pte. That can result in us missing an hash pte update or invalidate
>> which can cause memory corruption or even machine check ?
>
> Thanks. When did this break? Always? If so this should go to stable?
>

IIUC we have this issue with initial support for THP (6d492ecc6489113968ec269be1cf88942d4a5d29)
" powerpc/THP: Add code to handle HPTE faults for hugepages". So yes
this should got to stable.

-aneesh
