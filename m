Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E873F1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 16:15:05 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FA3F14012A
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2014 16:15:03 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 11 Sep 2014 11:44:57 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B8B033940045
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2014 11:44:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8B6FKgq57868314
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2014 11:45:21 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8B6ErnC029274
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2014 11:44:54 +0530
Message-ID: <54113DDD.1030804@linux.vnet.ibm.com>
Date: Thu, 11 Sep 2014 11:44:53 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, palves@redhat.com, oleg@redhat.com,
 dhowells@redhat.com, davej@redhat.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, davem@davemloft.net,
 Sam Bobroff <sam.bobroff@au1.ibm.com>
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

Hey Sam and Suka,

Thanks for reviewing this patch series. I was busy with some other work
for last couple of months. Went through your comments, will get back to
this patch series in some time and work on the comments.

Thanks again.

Regards
Anshuman
