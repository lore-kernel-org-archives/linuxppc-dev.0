Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2pm5LFYzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 20:14:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, ben@codiert.org,
 sjitindarsingh@gmail.com
Subject: Re: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
In-Reply-To: <7929ae2c-1b34-18b4-127a-ed0e438c751d@linux.vnet.ibm.com>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
 <8760e4q9bd.fsf@concordia.ellerman.id.au>
 <7929ae2c-1b34-18b4-127a-ed0e438c751d@linux.vnet.ibm.com>
Date: Fri, 04 Aug 2017 20:14:39 +1000
Message-ID: <87y3qzprlc.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> On Friday 04 August 2017 09:21 AM, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>
>>> As linux,memory-limit node is set and also later used by the kernel,
>>> avoid endian conversions for this property.
>>>
>>> Fixes: 493adffcb43f ("powerpc: Make prom_init.c endian safe")
>>> Cc: stable@vger.kernel.org # 3.12+
>>> Cc: Anton Blanchard <anton@ozlabs.org>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/kernel/prom_init.c |    3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>> As Ben said, this is not OK. The flat device tree is a data
>> structure with a specified format[1], we don't violate the spec just to
>> avoid an endian swap.
>>
>> Is there an actual bug you're trying to solve?
>
> Yep. While retrieving this property in prom.c, no endian conversion is 
> being done.
> It was broken for a while. Let me do the endian swap in prom.c while 
> retrieving..

Does it actually not work though, mem=x on the command line?

I think that code in prom.c is basically dead code, it's still there
because we were afraid removing it would break something. These days we
parse the command line early enough that we don't need those properties.

cheers
