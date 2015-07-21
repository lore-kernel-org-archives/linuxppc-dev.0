Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A13C1A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:45:47 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C32E5140DFC
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:45:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 17:15:44 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 74556E0054
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 17:19:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6LBjbR322413404
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 17:15:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6LBjaWx011015
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 17:15:36 +0530
Message-ID: <55AE30E0.6060002@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 17:15:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [RFC, 7/8] powerpc/xmon: Drop 'valid' from the condition inside
 'dump_segments'
References: <20150721100018.98F93140DBC@ozlabs.org>
In-Reply-To: <20150721100018.98F93140DBC@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 03:30 PM, Michael Ellerman wrote:
> On Tue, 2015-21-07 at 06:58:45 UTC, Anshuman Khandual wrote:
>> > From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
>> > 
>> > Value of 'valid' is zero when 'esid' is zero and it does not matter
>> > when 'esid' is non-zero. 
> Yes it does. It tells you whether the entry is valid?

Yeah but it does not change the outcome of the if condition check
here. Non-zero esid will make the condition test pass irrespective
of the value of 'valid'. Yes, valid will be checked inside the code
block to print details, the point was value of valid does not make
any difference to the 'if' condition check in the first place.
Unless I am getting tricked here some how :)

> 
> In practice maybe you only see invalid entries that are entirely zero, and so
> they get skipped anyway, but that's not guaranteed.
