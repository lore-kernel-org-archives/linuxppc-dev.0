Return-Path: <srs0=mrla=7n=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTJL76fVbzDr2v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 18:38:07 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xTJL74kbvz8sww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 18:38:07 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xTJL70R6Lz9s81
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 18:38:06 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7B8brlc144675
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 04:38:04 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c95k797uj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 04:38:04 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 11 Aug 2017 18:38:01 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
In-Reply-To: <20170810165019.unrvv6id2daqazju@arbab-laptop.localdomain>
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
 <20170810165019.unrvv6id2daqazju@arbab-laptop.localdomain>
Date: Fri, 11 Aug 2017 14:07:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3qqxzxc.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> On Thu, Aug 10, 2017 at 02:53:48PM +0530, Bharata B Rao wrote:
>>diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>index f830562..24ecf53 100644
>>--- a/arch/powerpc/kernel/prom.c
>>+++ b/arch/powerpc/kernel/prom.c
>>@@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>> 					size = 0x80000000ul - base;
>> 			}
>> 			memblock_add(base, size);
>>+			memblock_mark_hotplug(base, size);
>> 		} while (--rngs);
>> 	}
>> 	memblock_dump_all();
>
> Doing this has the effect of putting all the affected memory into 
> ZONE_MOVABLE. See find_zone_movable_pfns_for_nodes(). This means no 
> kernel allocations can occur there. Is that okay?
>

So the thinking here is any memory identified via ibm,dynamic-memory can
be hot removed later. Hence the need to add them lmb size, because our
hotplug framework remove them in lmb size. If we want to support
hotunplug, then we will have to make sure kernel allocation doesn't
happen in that region right ?

With the above i would consider not marking it hotplug was a bug before
?

-aneesh
