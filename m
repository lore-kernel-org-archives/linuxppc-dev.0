Return-Path: <srs0=nd3i=7n=linux.vnet.ibm.com=arbab@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVmz6GLpzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:28:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xTVmz5qsFz8tB4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:28:35 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xTVmz1q2kz9t2h
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2017 02:28:35 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7BGNgNr016845
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 12:28:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c9c8j4ku9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 12:28:32 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Fri, 11 Aug 2017 12:28:32 -0400
Date: Fri, 11 Aug 2017 11:28:28 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 nfont@linux.vnet.ibm.com
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
 <20170810165019.unrvv6id2daqazju@arbab-laptop.localdomain>
 <87y3qqxzxc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87y3qqxzxc.fsf@linux.vnet.ibm.com>
Message-Id: <20170811162828.cdk6y4d7cz6pnp2a@arbab-laptop.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 02:07:51PM +0530, Aneesh Kumar K.V wrote:
>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>
>> On Thu, Aug 10, 2017 at 02:53:48PM +0530, Bharata B Rao wrote:
>>>diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>>index f830562..24ecf53 100644
>>>--- a/arch/powerpc/kernel/prom.c
>>>+++ b/arch/powerpc/kernel/prom.c
>>>@@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>>> 					size = 0x80000000ul - base;
>>> 			}
>>> 			memblock_add(base, size);
>>>+			memblock_mark_hotplug(base, size);
>>> 		} while (--rngs);
>>> 	}
>>> 	memblock_dump_all();
>>
>> Doing this has the effect of putting all the affected memory into
>> ZONE_MOVABLE. See find_zone_movable_pfns_for_nodes(). This means no
>> kernel allocations can occur there. Is that okay?
>>
>
>So the thinking here is any memory identified via ibm,dynamic-memory can
>be hot removed later. Hence the need to add them lmb size, because our
>hotplug framework remove them in lmb size. If we want to support
>hotunplug, then we will have to make sure kernel allocation doesn't
>happen in that region right ?

Yes, the net result is that this memory can now be hotremoved. I just 
wanted to point out that the patch doesn't only change the granularity 
of addition--it also causes the memory to end up in a different zone 
(when using movable_node).

>With the above i would consider not marking it hotplug was a bug before
>?

Sure, that's reasonable.

-- 
Reza Arbab
