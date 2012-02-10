Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1012BB6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Feb 2012 06:14:26 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Fri, 10 Feb 2012 12:14:23 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 67103C90063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 14:14:20 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1AJEIdE304700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 14:14:18 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1AJEE5d032734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 12:14:14 -0700
Message-ID: <4F356C7E.3070608@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2012 13:14:06 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: tlb flushing on Power
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F32B354.7030306@linux.vnet.ibm.com> <1328735054.2903.29.camel@pasglop>
In-Reply-To: <1328735054.2903.29.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/08/2012 03:04 PM, Benjamin Herrenschmidt wrote:
> 
>> You can look at https://lkml.org/lkml/2012/1/9/389 in zsmalloc-main.c,
>> zs_[un]map_object() functions for the currently uses of set_pte() and
>> __flush_tlb_one().
>>
>>> set_pte() is long gone on all archs really (or if it's still there it's
>>> not meant to be used as is), use set_pte_at().
>>
>> Problem with set_pte_at() for us is that we don't have an mm_struct to pass
>> because the mapping is not for a userspace process but for the kernel itself.
> 
> Then use init_mm

Thanks, that's what I was looking for.

>> However, I do think this is the portable function we need to be using. Just
>> need to figure out what to pass in for the mm_struct param.
>>
>>> __flush_tlb_one() doesn't mean anything as an arch independent
>>> functionality. We have a local_flush_tlb_page() that -might- do what you
>>> want but why in hell is that patch not using proper existing
>>> interfaces ?
>>
>> flush_tlb_page() is the portable function we should be using.  However,
>> again, it requires a vma_area_struct.  I'm not sure what we should be
>> passing there.
> 
> Do you need this to be CPU local flush or global ? In the later, 
> flush_tlb_kernel_range() is the right API.
> 
> If you want per-cpu, we'll have to add a new arch hook.

We have interrupts disabled, due to the get_cpu_var() on the percpu variable
zs_map_area in zs_map_object(), while the allocation is mapped.  So a CPU local
would be what we need.

--
Seth
