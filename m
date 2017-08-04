Return-Path: <srs0=da+p=7g=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPG0h56QYzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 04:39:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xPG0h3yvXz8tCV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 04:39:00 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xPG0g6tNjz9s7m
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2017 04:38:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v74IccFQ051783
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 14:38:56 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c4t82nfyr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Aug 2017 14:38:56 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 5 Aug 2017 04:38:54 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v74Icpbj12386464
 for <linuxppc-dev@ozlabs.org>; Sat, 5 Aug 2017 04:38:51 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v74Icffx021739
 for <linuxppc-dev@ozlabs.org>; Sat, 5 Aug 2017 04:38:42 +1000
Subject: Re: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, sjitindarsingh@gmail.com,
 ben@codiert.org
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
 <8760e4q9bd.fsf@concordia.ellerman.id.au>
 <7929ae2c-1b34-18b4-127a-ed0e438c751d@linux.vnet.ibm.com>
 <87y3qzprlc.fsf@concordia.ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Sat, 5 Aug 2017 00:08:42 +0530
MIME-Version: 1.0
In-Reply-To: <87y3qzprlc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <30c461a6-8cef-cad2-d4a1-cda068c1c2dc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 04 August 2017 03:44 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> On Friday 04 August 2017 09:21 AM, Michael Ellerman wrote:
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>>
>>>> As linux,memory-limit node is set and also later used by the kernel,
>>>> avoid endian conversions for this property.
>>>>
>>>> Fixes: 493adffcb43f ("powerpc: Make prom_init.c endian safe")
>>>> Cc: stable@vger.kernel.org # 3.12+
>>>> Cc: Anton Blanchard <anton@ozlabs.org>
>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>>> ---
>>>>    arch/powerpc/kernel/prom_init.c |    3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>> As Ben said, this is not OK. The flat device tree is a data
>>> structure with a specified format[1], we don't violate the spec just to
>>> avoid an endian swap.
>>>
>>> Is there an actual bug you're trying to solve?
>> Yep. While retrieving this property in prom.c, no endian conversion is
>> being done.
>> It was broken for a while. Let me do the endian swap in prom.c while
>> retrieving..
> Does it actually not work though, mem=x on the command line?

mem=X works fine. The problem is with the early cmdline parsing of
'mem=' in prom_init, which is treating fadump_reserve_mem=X as
mem=X. So, when fadump_reserve_mem=X is passed, endian swapped
version of X is set to memory_limit as early parser takes it for mem=X
and linux,memory-limit read is not endian safe currently. This bug
was not hit so far as prom_memory_limit is set only when X is
< ram_top && > alloc_bottom which is not the case generally.

> I think that code in prom.c is basically dead code, it's still there
> because we were afraid removing it would break something. These days we
> parse the command line early enough that we don't need those properties.
>
>

This problem is not seen with mem=X as memory_limit is overwritten
with the right value as soon as parse_early_param() is called in prom.

Should I just get rid of linux,memory-limit node and mem=X handling
from early_cmdline_parse() in prom_init as this has been broken for
a while and nobody seem to have had a problem with that?

Thanks
Hari
