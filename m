Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E0811A08F6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 01:33:12 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 07:33:10 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AA0911FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 07:21:14 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1KEX4Sq34668604
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 07:33:04 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1KEX3t1021995
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 07:33:04 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Clear the invalid slot information
 correctly
In-Reply-To: <1455878263.6506.4.camel@ellerman.id.au>
References: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56C6ADC6.5000603@linux.vnet.ibm.com>
 <1455878263.6506.4.camel@ellerman.id.au>
Date: Sat, 20 Feb 2016 20:02:58 +0530
Message-ID: <8760xje9k5.fsf@linux.vnet.ibm.com>
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

> On Fri, 2016-02-19 at 11:23 +0530, Anshuman Khandual wrote:
>> On 02/18/2016 10:14 PM, Aneesh Kumar K.V wrote:
>> > We can get a hash pte fault with 4k base page size and find the pte
>> > already inserted with 64K base page size. In that case we need to clear
> ...
>>
>> > diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
>> > index e7c04542ba62..e3e76b929f33 100644
>> > --- a/arch/powerpc/mm/hash64_4k.c
>> > +++ b/arch/powerpc/mm/hash64_4k.c
>> > @@ -106,7 +106,7 @@ repeat:
>> >  			}
>> >  		}
>> >  		/*
>> > -		 * Hypervisor failure. Restore old pmd and return -1
>> > +		 * Hypervisor failure. Restore old pte and return -1
>>
>> This change is not relevant here. Should be a separate patch.
>
> Yeah.
>
> If it was -rc1 then I would probably let it go, but this will land in rc6 so
> the fixes need to be tight.
>

You want me to do an upate with those changes dropped ?.

-aneesh
