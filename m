Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407C4b0J2PzF1b4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 05:39:26 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2NIdJVj016135
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 14:39:24 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gw4fvf1gs-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 14:39:21 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Fri, 23 Mar 2018 12:39:13 -0600
Subject: Re: [PATCH] powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT CPU
 features
To: "Li Yi (Adam)" <liyiadam@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <CAN7W-Tbai=VjA6HBVM-2tQwdgk1ebiSZ_d-D2o42Yhz=bJOo-Q@mail.gmail.com>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 15:39:09 -0300
MIME-Version: 1.0
In-Reply-To: <CAN7W-Tbai=VjA6HBVM-2tQwdgk1ebiSZ_d-D2o42Yhz=bJOo-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <20ef5811-6fbf-19ca-a083-395deb84fd5e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Yi,

On 03/14/2018 05:34 AM, Li Yi (Adam) wrote:
>> So set it in the DT CPU features code also.
>>
>> This results in eg:
>>    $ LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
>>    AT_PLATFORM:     power9
>>    AT_BASE_PLATFORM:power9
>>
> 
> Is this issue related with DD2.2 CPU?
> I tested on a Boston system with DD2.1 CPU, with kernel 4.14.23,
> AT_BASE_PLATFORM value is correct:
> 
> [root@boston-sh-04 ~]# LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
> AT_PLATFORM:     power9
> AT_BASE_PLATFORM:power9
> [root@boston-sh-04 ~]# uname -a
> Linux boston-sh-04 4.14.23 #1 SMP Sat Mar 3 12:14:56 CST 2018 ppc64le
> ppc64le ppc64le GNU/Linux

It's not related to the processor version, rather it's related to if you
are under a VM or running on baremetal. The issue happens on baremetal
when you are using DT to get the CPU features. So I guess the test you
performed above is on a VM? On DD2.1 baremetal AT_BASE_PLATFORM is
missing as on a DD2.2 baremetal (if mpe's patch is not applied):

root@r222l:~# LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
AT_PLATFORM:     power9
root@r222l:~# lscpu | fgrep Model
Model:               2.1 (pvr 004e 1201)
Model name:          POWER9, altivec supported
root@r222l:~# uname -a
Linux r222l 4.13.0-32-generic #35-Ubuntu SMP Thu Jan 25 09:05:20 UTC 2018 ppc64le ppc64le ppc64le GNU/Linux
   

Regards,
Gustavo

> 
> Thanks,
> -Yi
> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   arch/powerpc/kernel/dt_cpu_ftrs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> index 945e2c29ad2d..0bcfb0f256e1 100644
>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> @@ -720,6 +720,9 @@ static void __init cpufeatures_setup_finished(void)
>>                  cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
>>          }
>>
>> +       /* Make sure powerpc_base_platform is non-NULL */
>> +       powerpc_base_platform = cur_cpu_spec->platform;
>> +
>>          system_registers.lpcr = mfspr(SPRN_LPCR);
>>          system_registers.hfscr = mfspr(SPRN_HFSCR);
>>          system_registers.fscr = mfspr(SPRN_FSCR);
>> --
>> 2.14.1
> 
