Return-Path: <haren@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E37612C0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2012 12:20:44 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Thu, 1 Nov 2012 19:20:42 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E199319D8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2012 19:20:19 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA21KJsZ262436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2012 19:20:19 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA21KIJJ010573
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2012 19:20:19 -0600
Message-ID: <50931FD1.6040905@linux.vnet.ibm.com>
Date: Thu, 01 Nov 2012 18:20:17 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
References: <1351666171.32304.10.camel@hbabu-laptop>
 <25370.1351730689@neuling.org>
In-Reply-To: <25370.1351730689@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, anton@au1.ibm.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2012 05:44 PM, Michael Neuling wrote:
> Haren Myneni <haren@linux.vnet.ibm.com> wrote:
> 
>> [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
>>
>> On P7 systems, users can define SMT priority levels 2,3 and 4 for
>> processes so that some can run higher priority than the other ones.
>> In the current kernel, the default priority is set to 4 which prohibits
>> processes for using higher priority. Also the kernel boosts the priority to
>> 4 during exceptions without saving the user defined priorities when
>> the task enters the kernel. So we will be loosing the process PPR value
>> and can not be restored it back when the task exits the kernel.
>>
>> This patchset implements saving and restore the user defined PPR value
>> for all tasks.
>>
>> With null_syscall testcase (http://ozlabs.org/~anton/junkcode/null_syscall.c),
>> this feature takes around extra 10 CPU cycles on average for 25 samples. 
> 
> Haren,
> 
> This version doesn't do PPR save/restore over syscall, so is this above
> statement still true?  null_syscall shouldn't be effected at all, right?
> 
> Mikey
> 

Mikey,

Yes this version does not save/ restore for syscall entries. But we set
default priority 3 for each syscall exit -  set HMT_MEDIUM_LOW for
normal return, and set 3 in thread.ppr so that this value will be set
for fast return path.

So I was using null_syscall test case to find out the performance
overhead with this patch-set.

Thanks
Haren


>>
>> Haren Myneni (6):
>>   powerpc: Move branch instruction from ACCOUNT_CPU_USER_ENTRY to caller
>>   powerpc: Define CPU_FTR_HAS_PPR
>>   powerpc: Increase exceptions arrays in paca struct to save PPR
>>   powerpc: Define ppr in thread_struct
>>   powerpc: Macros for saving/restore PPR
>>   powerpc: Implement PPR save/restore
>>
>>  arch/powerpc/include/asm/cputable.h      |    6 ++-
>>  arch/powerpc/include/asm/exception-64s.h |   45 ++++++++++++++++++++++++++----
>>  arch/powerpc/include/asm/paca.h          |    6 ++--
>>  arch/powerpc/include/asm/ppc_asm.h       |   27 ++++++++++++++++-
>>  arch/powerpc/include/asm/processor.h     |    6 ++++
>>  arch/powerpc/include/asm/reg.h           |    1 +
>>  arch/powerpc/kernel/asm-offsets.c        |    1 +
>>  arch/powerpc/kernel/entry_64.S           |    6 +++-
>>  arch/powerpc/kernel/exceptions-64e.S     |    3 +-
>>  arch/powerpc/kernel/exceptions-64s.S     |   15 +++++----
>>  arch/powerpc/kernel/process.c            |    2 +
>>  11 files changed, 96 insertions(+), 22 deletions(-)
>>
>>
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
