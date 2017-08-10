Return-Path: <srs0=wkuz=7m=linux.vnet.ibm.com=arbab@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xT0NL0YQFzDr0G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 06:38:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xT0NK6Ycsz8t0Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 06:38:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xT0NK1vJJz9rxl
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 06:38:56 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7AKYJ5f058883
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 16:38:54 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c8qtpn9e9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 16:38:54 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 14:38:54 -0600
Date: Thu, 10 Aug 2017 15:38:48 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
 <20170810165019.unrvv6id2daqazju@arbab-laptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170810165019.unrvv6id2daqazju@arbab-laptop.localdomain>
Message-Id: <20170810203847.oaobnhwogf4cjo7b@arbab-laptop.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2017 at 11:50:19AM -0500, Reza Arbab wrote:
>On Thu, Aug 10, 2017 at 02:53:48PM +0530, Bharata B Rao wrote:
>>diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>index f830562..24ecf53 100644
>>--- a/arch/powerpc/kernel/prom.c
>>+++ b/arch/powerpc/kernel/prom.c
>>@@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>>					size = 0x80000000ul - base;
>>			}
>>			memblock_add(base, size);
>>+			memblock_mark_hotplug(base, size);
>>		} while (--rngs);
>>	}
>>	memblock_dump_all();
>
>Doing this has the effect of putting all the affected memory into 
>ZONE_MOVABLE. See find_zone_movable_pfns_for_nodes(). This means no 
>kernel allocations can occur there. Is that okay?

I should clarify. The behavior change I mention applies when 
movable_node_is_enabled().

-- 
Reza Arbab
