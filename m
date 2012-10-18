Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B54EF2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2012 12:47:32 +1100 (EST)
Message-ID: <507F5FA5.6070501@windriver.com>
Date: Thu, 18 Oct 2012 09:47:17 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] PPC_BOOK3E/KGDB: support kgdb kernel space
References: <1350471011-2478-1-git-send-email-tiejun.chen@windriver.com>
 <1350471011-2478-2-git-send-email-tiejun.chen__24766.2045098425$1350471081$gmane$org@windriver.com>
 <m28vb5s3o4.fsf@igel.home>
In-Reply-To: <m28vb5s3o4.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2012 08:07 PM, Andreas Schwab wrote:
> Tiejun Chen <tiejun.chen@windriver.com> writes:
>
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>> index 4684e33..ed5862d 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -539,11 +539,15 @@ kernel_dbg_exc:
>>   	rfdi
>>
>>   	/* Normal debug exception */
>> +#ifndef CONFIG_KGDB
>>   	/* XXX We only handle coming from userspace for now since we can't
>>   	 *     quite save properly an interrupted kernel state yet
>>   	 */
>>   1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
>>   	beq	kernel_dbg_exc;		/* if from kernel mode */
>> +#else
>> +1:
>> +#endif
>
> You could move the label before the conditional.

Okay.

diff --git a/arch/powerpc/kernel/exceptions-64e.S 
b/arch/powerpc/kernel/exceptions-64e.S
index 4684e33..73ce1a7 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -538,12 +538,15 @@ kernel_dbg_exc:
         mfspr   r13,SPRN_SPRG_DBG_SCRATCH
         rfdi

+1:
         /* Normal debug exception */
+#ifndef CONFIG_KGDB
         /* XXX We only handle coming from userspace for now since we can't
          *     quite save properly an interrupted kernel state yet
          */
-1:     andi.   r14,r11,MSR_PR;         /* check for userspace again */
+       andi.   r14,r11,MSR_PR;         /* check for userspace again */
         beq     kernel_dbg_exc;         /* if from kernel mode */
+#endif

         /* Now we mash up things to make it look like we are coming on a
          * normal exception
...

Tiejun
