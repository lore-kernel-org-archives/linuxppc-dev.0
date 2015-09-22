Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8484A1A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:47:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 16:47:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2082E2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:46:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8M6klwB24838318
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:46:55 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8M6kQ0j019887
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:46:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/31] powerpc/mm: Don't use pmd_val,
 pud_val and pgd_val as lvalue
In-Reply-To: <20150922022341.GB12728@home.buserror.net>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150922022341.GB12728@home.buserror.net>
Date: Tue, 22 Sep 2015 12:15:58 +0530
Message-ID: <87a8sf3qah.fsf@linux.vnet.ibm.com>
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

Scott Wood <scottwood@freescale.com> writes:

> On Mon, Sep 21, 2015 at 12:10:37PM +0530, Aneesh Kumar K.V wrote:
>>  /* PUD level exusts only on 4k pages */
>>  #ifndef CONFIG_PPC_64K_PAGES
>>  typedef struct { unsigned long pud; } pud_t;
>> -#define pud_val(x)	((x).pud)
>>  #define __pud(x)	((pud_t) { (x) })
>> +static inline unsigned long pud_val(pud_t pud)
>> +{
>> +	return x.pud;
>> +}
>>  #endif /* !CONFIG_PPC_64K_PAGES */
>
> Where does "x" come from in this inline function?
>
> This breaks the build with CONFIG_MM_STRICT_TYPECHECKS.


That should be

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e555f273716d..31835988c12a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -311,7 +311,7 @@ static inline unsigned long pmd_val(pmd_t x)
 #ifndef CONFIG_PPC_64K_PAGES
 typedef struct { unsigned long pud; } pud_t;
 #define __pud(x)	((pud_t) { (x) })
-static inline unsigned long pud_val(pud_t pud)
+static inline unsigned long pud_val(pud_t x)
 {
 	return x.pud;
 }


-aneesh
