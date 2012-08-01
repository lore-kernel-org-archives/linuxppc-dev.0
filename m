Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EE302C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 20:02:02 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 1 Aug 2012 15:31:59 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q71A1tdR23724144
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 15:31:56 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q71A1tqV027709
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 20:01:55 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V5 13/13] arch/powerpc: Update VSID allocation
 documentation
In-Reply-To: <20120801053505.GG24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120801053505.GG24014@drongo>
Date: Wed, 01 Aug 2012 15:31:47 +0530
Message-ID: <87k3xjhqwk.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 30, 2012 at 04:52:19PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This update the proto-VSID and VSID scramble related information
>> to be more generic by using names instead of current values.
>
> Comments below...
>
>> - * VSID allocation
>> + * VSID allocation (256MB segment)
>>   *
>> - * We first generate a 36-bit "proto-VSID".  For kernel addresses this
>> - * is equal to the ESID, for user addresses it is:
>> - *	(context << 15) | (esid & 0x7fff)
>> + * We first generate a 38-bit "proto-VSID".  For kernel addresses this
>> + * is equal to the ESID | 1 << 37, for user addresses it is:
>> + *	(context << USER_ESID_BITS) | (esid & (1U << USER_ESID_BITS))
> 					      ^^^^^^^^^^^^^^^^^^^^^^
> should be ((1U << USER_ESID_BITS) - 1)
>
>>   *
>> - * The two forms are distinguishable because the top bit is 0 for user
>> - * addresses, whereas the top two bits are 1 for kernel addresses.
>> - * Proto-VSIDs with the top two bits equal to 0b10 are reserved for
>> - * now.
>> + * This splits the proto-VSID into the below range
>> + *  0 - (2^(CONTEXT_BITS + USER_ESID_BITS) - 1) : User proto-VSID range
>> + *  2^(CONTEXT_BITS + USER_ESID_BITS) - 2^(VSID_BITS) : Kernel proto-VSID range
>
> Perhaps point out also that CONTEXT_BITS + USER_ESID_BITS == VSID_BITS - 1,
> that is, you have assigned half of the space to user processes and half
> to the kernel.
>

updated

>> -/*
>> - * WARNING - If you change these you must make sure the asm
>> - * implementations in slb_allocate (slb_low.S), do_stab_bolted
>> - * (head.S) and ASM_VSID_SCRAMBLE (below) are changed accordingly.
>> - */
>
> Are you absolutely sure that nothing in the assembly code would need
> to be changed if someone changed these definitions?
>

As a part of this patchset, i didn't touch any of these and the pathcset
do change these values. 

-aneesh
