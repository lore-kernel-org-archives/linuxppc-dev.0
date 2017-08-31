Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjc9y6PhSzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:13:42 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7V9AkAr013857
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:13:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cpa7cud96-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:13:40 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 10:13:38 +0100
Subject: Re: [PATCH v2 1/3] powerpc/mm: Export flush_all_mm()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 andrew.donnellan@au1.ibm.com, clombard@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
 <87inh519fl.fsf@concordia.ellerman.id.au>
 <77b082b9-0e6e-ed38-3a4e-af7797990ef3@linux.vnet.ibm.com>
 <1504126871.4974.23.camel@kernel.crashing.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 11:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <1504126871.4974.23.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <67e02113-1e61-9561-5208-939c3dde5888@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/08/2017 à 23:01, Benjamin Herrenschmidt a écrit :
> On Wed, 2017-08-30 at 15:59 +0200, Frederic Barrat wrote:
>>> It's not clear why it makes sense for these to be empty. Either for the
>>> general idea of the "flush_all_mm()" API, or for your intended use by
>>> CXL.
>>
>> I was not too sure what to do for hash, but the idea is that the new
>> flush_all_mm() is really the equivalent of the old flush_tlb_mm() from
>> before Ben's optimizations for radix, and that was/still is an empty
>> operation on hash, so I kept it that way.
>>
>> We don't support hash for capi2 yet. Adding it will definitely require
>> some work in that area, as the current approach (use count on the driver
>> and all TLBIs becoming global when the driver is in use) won't hold much
>> longer.
> 
> Why not ? It would work fine on hash, but you do need a way to flush
> the TLB when decreasing the count indeed and that's missing for hash.

For the future support of hash, the problem is actually not for capi2, 
but for opencapi, where we can have more than one driver. So the driver 
use count approach would need to be reworked (today the use count is in 
the driver itself). What we do for radix is better, since we make the 
TLBI global only when required, per context. But it is not trivial to do 
the same for hash, as we typically don't have the context handy when we 
send the TLBI. So we'll have to do *something* when we add support for hash.

For my more pressing needs, I'll look into triggering a LPID flush for 
the time being. It's too much but safe, and can be re-assess later when 
we add hash support.

   Fred
