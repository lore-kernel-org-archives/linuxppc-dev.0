Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgKlp15LCzDsly
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 14:15:33 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N4CqXN020286
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 00:15:32 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb4p75a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 00:15:31 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Fri, 23 Sep 2016 14:15:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D62EB2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 14:15:27 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N4FR5Z62259436
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 14:15:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N4FRMo009081
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 14:15:27 +1000
Subject: Re: [PATCH] Work around for enabling CONFIG_CMDLINE on ppc64le
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1474525245-10739-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87d1jw8cba.fsf@concordia.ellerman.id.au>
Cc: anton@samba.org
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Date: Fri, 23 Sep 2016 09:45:24 +0530
MIME-Version: 1.0
In-Reply-To: <87d1jw8cba.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57E4AC5C.5010803@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Anton found this bug and raised it against gcc v7.0 and a fix is available
  in upstream gcc.

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71709

Currently, gcc v5.4.0  and v6.1.1 shipped with Ubuntu 16.04 and 16.10  respectively,
  are hitting this problem.

I have also raised bug against Ubuntu for fixing gcc for 16.04.

https://bugzilla.linux.ibm.com/show_bug.cgi?id=146668


On 09/22/2016 03:51 PM, Michael Ellerman wrote:
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
>
>> Observed that boot arguments (passed as CONFIG_CMDLINE)  are not being
>> picked up by kernel while using gcc-ppc64-linux-gnu v5.4.0 and v6.1.1.
>> While it works as expected with v5.3.1 .
>>
>> Found that in init/main.c in  setup_command_line() the pointers passed to
>> strcpy() is messed up.
> Hi Akshay,
>
> Thanks for debugging this.
>
>> The problem goes away when compiler optimization is restricted to -O1.
>> diff --git a/init/main.c b/init/main.c
>> index a8a58e2..4259c42 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -358,7 +358,13 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
>>    * parsing is performed in place, and we should allow a component to
>>    * store reference of name/value for future reference.
>>    */
>> -static void __init setup_command_line(char *command_line)
>> +static void __init
>> +#ifdef CONFIG_PPC64
>> +	#if  GCC_VERSION > 50301
>> +		__attribute__((optimize("-O1")))
>> +	#endif
>> +#endif
>> +		setup_command_line(char *command_line)
>>   {
>>   	saved_command_line =
>>   		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
> But I can't merge that patch.
>
> Our options are one or both of:
>   - get GCC fixed and backport the fix to the compilers we care about.
>   - blacklist the broken compiler versions.
>
> Is there a GCC bug filed for this?
>
> cheers
>
