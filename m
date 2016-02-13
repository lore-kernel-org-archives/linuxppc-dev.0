Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7A211A0013
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 16:12:20 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 22:12:18 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 06969C40009
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 22:00:26 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1D5CG7G26017898
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 22:12:16 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1D5CFlA018994
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 22:12:15 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 02/29] powerpc/mm: Split pgtable types to separate
 header
In-Reply-To: <20160212025238.GC13831@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160212025238.GC13831@oak.ozlabs.ibm.com>
Date: Sat, 13 Feb 2016 10:42:11 +0530
Message-ID: <87ziv5qjmc.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Feb 08, 2016 at 02:50:14PM +0530, Aneesh Kumar K.V wrote:
>> We remove real_pte_t out of STRICT_MM_TYPESCHECK. We will later add
>> a radix variant that is big endian
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> It looks like most of what this patch does is move a bunch of
> definitions from page.h to a new pgtable-types.h.  What is the
> motivation for this?  Is the code identical (pure code movement) or do
> you make changes along the way, and if so, what and why?

The motivation is to assist in addition of a big endian page table format later. 

>
> What exactly are you doing with real_pte_t and why?

Want to avoint STRICT_MM_TYPESCHECK related #ifdef around real_pte_t. I
can split that into a separate patch and keep this patch strictly code
movement.

-aneesh
