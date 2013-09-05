Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B084C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:48:23 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 17:10:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B2F26E004F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 17:18:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r85Bm9Yr40173660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 17:18:10 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r85BmBQj007132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 17:18:12 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix possible deadlock on page fault
In-Reply-To: <20130905095316.GA18222@iris.ozlabs.ibm.com>
References: <1378365422-25203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130905095316.GA18222@iris.ozlabs.ibm.com>
Date: Thu, 05 Sep 2013 17:18:11 +0530
Message-ID: <87a9jrwkuc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Thu, Sep 05, 2013 at 12:47:02PM +0530, Aneesh Kumar K.V wrote:
>
>> @@ -280,6 +280,13 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>>  
>>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>>  
>> +	/*
>> +	 * We want to do this outside mmap_sem, because reading code around nip
>> +	 * can result in fault, which will cause a deadlock when called with
>> +	 * mmap_sem held
>> +	 */
>> +	store_update = store_updates_sp(regs);
>
> We should only call store_updates_sp() if user_mode(regs); that was
> the previous behaviour.

Updated to 

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8726779..fad7af6 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -206,7 +206,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
 	int fault;
-	int rc = 0;
+	int rc = 0, store_update = 0;
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -280,6 +280,14 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * We want to do this outside mmap_sem, because reading code around nip
+	 * can result in fault, which will cause a deadlock when called with
+	 * mmap_sem held
+	 */
+	if (user_mode(regs))
+		store_update = store_updates_sp(regs);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -345,8 +353,7 @@ retry:
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1]
-		    && (!user_mode(regs) || !store_updates_sp(regs)))
+		if (address + 2048 < uregs->gpr[1] && !store_update)
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))
