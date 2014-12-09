Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35DF71A02F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 00:03:46 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 18:33:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8A683E005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 18:34:15 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9D41mm328120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 18:34:01 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9D3NLS012257
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 18:33:24 +0530
Message-ID: <5486F31B.4010800@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2014 18:33:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [4/5] powerpc, dscr: Added some in-code documentation
References: <20141209100307.ACBE41400DE@ozlabs.org>
In-Reply-To: <20141209100307.ACBE41400DE@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2014 03:33 PM, Michael Ellerman wrote:
> On Mon, 2014-08-12 at 06:30:11 UTC, Anshuman Khandual wrote:
>> This patch adds some in-code documentation to the DSCR related
>> code to make it more readable without having any functional
>> change to it.
> 
> Adding documentation is always good, but ...
> 
>> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
>> index dda7ac4..81c1aeb 100644
>> --- a/arch/powerpc/include/asm/processor.h
>> +++ b/arch/powerpc/include/asm/processor.h
>> @@ -295,6 +295,14 @@ struct thread_struct {
>>  #endif
>>  #ifdef CONFIG_PPC64
>>  	unsigned long	dscr;
>> +	/*
>> +	 * XXX: dscr_inherit indicates that the process has explicitly
> 
> Please don't use XXX as a matter of practice.
> 
> It should be saved for *really* tricky/complicated code, and this isn't that.

Sure, got it. Will remove them.

> 
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 67fd2fd..edde3f0 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -496,8 +496,21 @@ static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>>  static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>>  
>> +/*
>> + * XXX: This is the system wide DSCR register default value.
>> + * Any change to this value through the sysfs interface will
>> + * update all per-cpu DSCR default values across the system
>> + * stored in their respective PACA structures.
>> + */
>>  static unsigned long dscr_default;
> 
> Yeah it seems you're right, writing updates the values in all pacas, reading
> returns the value in the current cpu's paca. So why do we need this copy of the
> value?

My comment here might be little confusing. The read_dscr/write_dscr functions
are used for per-CPU PACA DSCR values which can read/update the per-CPU PACA
variable directly. The functions show_dscr_default/store_dscr_default are used
to read/update the system wide DSCR default which is the above 'dscr_default'
variable. Function store_dscr_default also calls write_dscr to update PACA on
every CPU present on the system. I will re-write the code comment to make more
sense.

> 
>> +/*
>> + * XXX: read_dscr and write_dscr are the functions for the
>> + * per-cpu DSCR default sysfs files present for each cpu.
>> + * Though updates to per-cpu DSCR value also gets called
>> + * for all the CPUs on the system when the system wide
>> + * global dscr_default gets changed.
>> + */
>>  static void read_dscr(void *val)
>>  {
> 
> Please make these proper kernel-doc comments. I've definitely asked you to do
> that at least once before on a different patch, to check you can do:

Yes you had. Thought that this function is too small but as you said if we
are writing documentation for it we should write kernel-doc format only.
Will make sure about this now onward.

> 
> $ ./scripts/kernel-doc -text arch/powerpc/kernel/sysfs.c
> 
> The comments for write_dscr() should be attached to that function.

Sure.
