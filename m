Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM2LS1RcczF0St
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:47:12 +1100 (AEDT)
Subject: Re: [PATCH 1/3] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <876081by7g.fsf@linux.vnet.ibm.com>
 <b5e34a5b-94b8-9405-929d-d35dde3fcb3b@c-s.fr>
 <945affcd-b25c-bc6e-68e5-8bbbcd31c0fd@linux.vnet.ibm.com>
 <7341aef1-f2ac-6e9b-8279-93b0f0649b81@c-s.fr>
 <87y3kxrrc2.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0e4e058e-db76-629c-c004-27e63b2cf9ab@c-s.fr>
Date: Wed, 17 Jan 2018 10:47:07 +0100
MIME-Version: 1.0
In-Reply-To: <87y3kxrrc2.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/01/2018 à 06:23, Aneesh Kumar K.V a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>>>
>>>> How should I split in separate patches ? Something like ?
>>>> 1/ Slice support for PPC32 > 2/ Activate slice for 8xx
>>>
>>> Yes something like that. Will you  be able to avoid that
>>>    if (SLICE_NUM_HIGH) from the code? That makes the code ugly. Right now
>>> i don't have definite suggestion on what we could do though.
>>>
>>
>> Could use #ifdefs instead, but in my mind it would be even more ugly.
>>
>> I would have liked just doing nothing, but the issue is that at the
>> moment bitmap_xxx() functions are not prepared to handle bitmaps of size
>> zero. Should we try to change that ? Any chance to succeed ?
>>
> 
> How much code duplication it is to do slice_32.c?

Most functions use both .low_slices and .high_slices, so if your thought 
is to copy slice.c to slice_32.c and then remove all code handling 
.high_slices, we will at least duplicate 50% of the code

In v2 that I have just submitted, I have embedded this ugly test in 
macros called slice_bitmap_xxx() which handles the 0 nbits case. Tell me 
if it looks better that way.

Christophe

> 
> Michael,
> 
> What do you suggest here?
> 
> -aneesh
> 
