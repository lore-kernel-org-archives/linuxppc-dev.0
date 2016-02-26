Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (unknown [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE1831A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 21:01:05 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 05:01:01 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0F6ECC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 05:00:55 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1QA0vEx23592996
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 10:00:57 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QA0svo019611
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 05:00:57 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <oss@buserror.net>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 15/18] powerpc/mm: Move hash page table related
 functions to pgtable-hash64.c
In-Reply-To: <1456374775.5360.32.camel@buserror.net>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456374775.5360.32.camel@buserror.net>
Date: Fri, 26 Feb 2016 15:30:47 +0530
Message-ID: <87ziuniyeo.fsf@linux.vnet.ibm.com>
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

Scott Wood <oss@buserror.net> writes:

Hi Scott,


Thanks for testing this series.

> On Tue, 2016-02-23 at 10:18 +0530, Aneesh Kumar K.V wrote:
>> 
>> diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable
>> -book3e.c
>> new file mode 100644
>> index 000000000000..bdaa4376f838
>> --- /dev/null
>> +++ b/arch/powerpc/mm/pgtable-book3e.c
>> @@ -0,0 +1,163 @@
>> +
>> +/*
>> + * Copyright IBM Corporation, 2015
>> + * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of version 2 of the GNU Lesser General Public License
>> + * as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + */
>> +
>> +/*
>> + * PPC64 THP Support for hash based MMUs
>> + */
>
> This comment doesn't match the filename.
>
> Regarding the rest of the file's contents, why is this being code being
> copied?  The very terse changelog doesn't cover it.
>

While doing the cleanup/code movement, I was trying to keep nonhash code
as much closer to as it is now, because there is no way for me to test
it and I wanted to avoid any regression. I agree that in some case it is
creating confusion like above.

If we agree that some of these cleanup/code movement are helping, then I
can redo the series making sure changes like above are taken care of.

-aneesh
