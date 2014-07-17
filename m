Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BEB61A02C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 20:27:18 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8237714007D
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 20:27:17 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 15:57:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 826D5125805C
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 15:56:57 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6HASoSs52166900
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 15:58:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6HAR7mL005511
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 15:57:08 +0530
Message-ID: <53C7A4FA.4030600@linux.vnet.ibm.com>
Date: Thu, 17 Jul 2014 15:57:06 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <53996E41.4070309@linux.vnet.ibm.com>
In-Reply-To: <53996E41.4070309@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
 davej@redhat.com, akpm@linux-foundation.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2014 02:39 PM, Anshuman Khandual wrote:
> On 05/23/2014 08:45 PM, Anshuman Khandual wrote:
>> 	This patch series adds five new ELF core note sections which can be
>> used with existing ptrace request PTRACE_GETREGSET/SETREGSET for accessing
>> various transactional memory and miscellaneous register sets on PowerPC
>> platform. Please find a test program exploiting these new ELF core note
>> types on a POWER8 system.
>>
>> RFC: https://lkml.org/lkml/2014/4/1/292
>> V1:  https://lkml.org/lkml/2014/4/2/43
>> V2:  https://lkml.org/lkml/2014/5/5/88
>>
>> Changes in V3
>> =============
>> (1) Added two new error paths in every TM related get/set functions when regset
>>     support is not present on the system (ENODEV) or when the process does not
>>     have any transaction active (ENODATA) in the context
>>
>> (2) Installed the active hooks for all the newly added regset core note types
>>
>> Changes in V2
>> =============
>> (1) Removed all the power specific ptrace requests corresponding to new NT_PPC_*
>>     elf core note types. Now all the register sets can be accessed from ptrace
>>     through PTRACE_GETREGSET/PTRACE_SETREGSET using the individual NT_PPC* core
>>     note type instead
>> (2) Fixed couple of attribute values for REGSET_TM_CGPR register set
>> (3) Renamed flush_tmreg_to_thread as flush_tmregs_to_thread
>> (4) Fixed 32 bit checkpointed GPR support
>> (5) Changed commit messages accordingly
>>
>> Outstanding Issues
>> ==================
>> (1) Running DSCR register value inside a transaction does not seem to be saved
>>     at thread.dscr when the process stops for ptrace examination.
> 
> Hey Ben,
> 
> Any updates on this patch series ?

Ben,

Any updates on this patch series ?
