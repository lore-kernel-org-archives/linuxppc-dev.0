Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A6981A0CF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 15:02:56 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E122C140157
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2015 15:02:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 24 Apr 2015 15:02:54 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F912357804F
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2015 15:02:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3O52hCB11469244
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2015 15:02:51 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3O52H5x028402
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2015 15:02:18 +1000
Message-ID: <5539CE40.100@linux.vnet.ibm.com>
Date: Fri, 24 Apr 2015 10:31:52 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] powerpc, tm: Drop tm_orig_msr from thread_struct
References: <1429517754-7988-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1429517754-7988-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2015 01:45 PM, Anshuman Khandual wrote:
> Currently tm_orig_msr is getting used during process context switch only.
> Then there is ckpt_regs which saves the checkpointed userspace context
> The MSR slot contained in ckpt_regs structure can be used during process
> context switch instead of tm_orig_msr, thus allowing us to drop it from
> thread_struct structure. This patch does that change.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> This issue came up in the discussion regarding ptrace interface for TM
> specific registers https://lkml.org/lkml/2015/4/20/100, so just wanted
> to give this a try. The basic TM tests still pass after this change.

Hey Michael/Mikey,

Whats your thoughts on this ? Can we drop tm_orig_msr ?
