Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E8301A02E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 19:11:32 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 423391400A6
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 19:11:32 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 12 Jun 2014 19:11:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 26F782CE8040
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 19:11:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5C8tHNX33357872
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 18:55:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5C9BMxh030641
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 19:11:23 +1000
Message-ID: <53996E41.4070309@linux.vnet.ibm.com>
Date: Thu, 12 Jun 2014 14:39:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, davem@davemloft.net,
 peterz@infradead.org, palves@redhat.com, linux-kernel@vger.kernel.org,
 oleg@redhat.com, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 davej@redhat.com, akpm@linux-foundation.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/23/2014 08:45 PM, Anshuman Khandual wrote:
> 	This patch series adds five new ELF core note sections which can be
> used with existing ptrace request PTRACE_GETREGSET/SETREGSET for accessing
> various transactional memory and miscellaneous register sets on PowerPC
> platform. Please find a test program exploiting these new ELF core note
> types on a POWER8 system.
> 
> RFC: https://lkml.org/lkml/2014/4/1/292
> V1:  https://lkml.org/lkml/2014/4/2/43
> V2:  https://lkml.org/lkml/2014/5/5/88
> 
> Changes in V3
> =============
> (1) Added two new error paths in every TM related get/set functions when regset
>     support is not present on the system (ENODEV) or when the process does not
>     have any transaction active (ENODATA) in the context
> 
> (2) Installed the active hooks for all the newly added regset core note types
> 
> Changes in V2
> =============
> (1) Removed all the power specific ptrace requests corresponding to new NT_PPC_*
>     elf core note types. Now all the register sets can be accessed from ptrace
>     through PTRACE_GETREGSET/PTRACE_SETREGSET using the individual NT_PPC* core
>     note type instead
> (2) Fixed couple of attribute values for REGSET_TM_CGPR register set
> (3) Renamed flush_tmreg_to_thread as flush_tmregs_to_thread
> (4) Fixed 32 bit checkpointed GPR support
> (5) Changed commit messages accordingly
> 
> Outstanding Issues
> ==================
> (1) Running DSCR register value inside a transaction does not seem to be saved
>     at thread.dscr when the process stops for ptrace examination.

Hey Ben,

Any updates on this patch series ?
