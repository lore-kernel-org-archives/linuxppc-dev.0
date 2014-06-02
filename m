Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9168F1A0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 18:50:06 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 75F261400AB
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2014 18:50:06 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 2 Jun 2014 18:50:05 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AAEA72BB004A
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2014 18:50:03 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s528SLpL62783572
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Jun 2014 18:28:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s528o2mP024627
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Jun 2014 18:50:02 +1000
Message-ID: <538C3A49.8030601@linux.vnet.ibm.com>
Date: Mon, 02 Jun 2014 14:18:09 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc, xmon: Enable hardware instruction breakpoint
 support on POWER8
References: <1401451823-25547-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1401603491.13479.11.camel@ale.ozlabs.ibm.com>
In-Reply-To: <1401603491.13479.11.camel@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2014 11:48 AM, Michael Neuling wrote:
> On Fri, 2014-05-30 at 17:40 +0530, Anshuman Khandual wrote:
>> This patch enables support for hardware instruction breakpoints on POWER8 with
>> the help of a new register called CIABR (Completed Instruction Address Breakpoint
>> Register). With this patch, single hardware instruction breakpoint can be added
>> and cleared during any active xmon debug session. This hardware based instruction
>> breakpoint mechanism works correctly along with the existing TRAP based instruction
>> breakpoints available on xmon. Example usage as follows.
> 
> Have you actually tried this on a guest?
> 

Yeah on a guest which runs on PVM.

> Please also compile with a range of configs.  It doesn't compile with
> ppc64e_defconfig.

Yeah. Need to change the way we get the "plapr_set_ciabr" function from plpar_wrappers.h
header file. Will add this hunk of code in "xmon.h" header and remove the CONFIG_PPC64 ifdef
code from the function write_ciabr.

+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/plpar_wrappers.h>
+#else
+static inline long plapr_set_ciabr(unsigned long ciabr) {return 0;};
+#endif

> 
> In file included from /scratch/mikey/src/linux-ozlabs/arch/powerpc/xmon/xmon.c:51:0:
> /scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h: In function 'get_cede_latency_hint':
> /scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h:26:9: error: 'struct paca_struct' has no member named 'lppaca_ptr'
> /scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h: In function 'set_cede_latency_hint':
> /scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h:31:2: error: 'struct paca_struct' has no member named 'lppaca_ptr'
> /scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h: In function 'plpar_page_set_loaned':
> /scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h:98:2: error: implicit declaration of function 'cmo_get_page_size' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> 
>> -				    (bp->enabled & BP_IABR)? "inst": "trap");
>> +					(bp->enabled & (BP_IABR | BP_CIABR))?
>> +				       				"inst": "trap");
> 
> Git complains about whitespace issues here.  Spaces before tabs.

Will take care of this next version.
