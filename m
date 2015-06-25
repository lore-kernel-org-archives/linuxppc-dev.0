Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C38D41A0BB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 23:42:44 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 115CF1402C3
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 23:42:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 19:12:41 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1C5FE1258059
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 19:15:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PDgd9e9044314
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 19:12:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PDgcpN017822
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 19:12:38 +0530
Message-ID: <558C054E.7000609@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 19:12:38 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, paulus@samba.org
Subject: Re: [RFC] powerpc, tm: Drop tm_orig_msr from thread_struct
References: <1429517754-7988-1-git-send-email-khandual@linux.vnet.ibm.com>
 <5539CE40.100@linux.vnet.ibm.com>
In-Reply-To: <5539CE40.100@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2015 10:31 AM, Anshuman Khandual wrote:
> On 04/20/2015 01:45 PM, Anshuman Khandual wrote:
>> Currently tm_orig_msr is getting used during process context switch only.
>> Then there is ckpt_regs which saves the checkpointed userspace context
>> The MSR slot contained in ckpt_regs structure can be used during process
>> context switch instead of tm_orig_msr, thus allowing us to drop it from
>> thread_struct structure. This patch does that change.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> This issue came up in the discussion regarding ptrace interface for TM
>> specific registers https://lkml.org/lkml/2015/4/20/100, so just wanted
>> to give this a try. The basic TM tests still pass after this change.
> 
> Hey Michael/Mikey,
> 
> Whats your thoughts on this ? Can we drop tm_orig_msr ?

Just wanted some inputs/suggestions/thoughts on this idea. Did not hear
from any one on this. Will it create any problem any where if we drop
this variable.
