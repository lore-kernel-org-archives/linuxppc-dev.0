Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58293B71BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 04:40:42 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Wed, 8 Feb 2012 10:40:38 -0700
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AF1B9C90053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 12:39:51 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q18HdpfU230728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2012 12:39:51 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q18HdlhC030255
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2012 10:39:48 -0700
Message-ID: <4F32B354.7030306@linux.vnet.ibm.com>
Date: Wed, 08 Feb 2012 11:39:32 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: tlb flushing on Power
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
In-Reply-To: <1327613953.24487.9.camel@pasglop>
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

Hey Ben,

Thanks for responding.

On 01/26/2012 03:39 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2012-01-26 at 08:41 -0600, Brian King wrote:
>> CC'ing linuxppc-dev...
>>
>>
>> On 01/26/2012 08:18 AM, Seth Jennings wrote:
>>> Hey Dave,
>>>
>>> So I submitted the zsmalloc patches to lkml at the beginning
>>> of the year
>>>
>>> https://lkml.org/lkml/2012/1/9/389
>>>
>>> I found there are two functions Nitin used in the mapping
>>> functions that are not supported in the powerpc arch:
>>> set_pte() and __flush_tlb_one().
> 
>  .../...
> 
> The arch management of page tables can be tricky indeed :-) I need to
> have a better understanding of what you are doing to see how I can try
> to adapt it to power.

You can look at https://lkml.org/lkml/2012/1/9/389 in zsmalloc-main.c,
zs_[un]map_object() functions for the currently uses of set_pte() and
__flush_tlb_one().

> set_pte() is long gone on all archs really (or if it's still there it's
> not meant to be used as is), use set_pte_at().

Problem with set_pte_at() for us is that we don't have an mm_struct to pass
because the mapping is not for a userspace process but for the kernel itself.

However, I do think this is the portable function we need to be using. Just
need to figure out what to pass in for the mm_struct param.

> __flush_tlb_one() doesn't mean anything as an arch independent
> functionality. We have a local_flush_tlb_page() that -might- do what you
> want but why in hell is that patch not using proper existing
> interfaces ?

flush_tlb_page() is the portable function we should be using.  However,
again, it requires a vma_area_struct.  I'm not sure what we should be
passing there.

--
Seth
