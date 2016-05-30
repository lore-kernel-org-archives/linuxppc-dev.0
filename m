Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJMR5251jzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 02:25:05 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UGOQ0v039392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 12:25:03 -0400
Message-Id: <201605301625.u4UGOQ0v039392@mx0a-001b2d01.pphosted.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238jhvsj88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 12:25:02 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 31 May 2016 02:24:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6887A3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 02:24:55 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UGOlAB52166856
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 02:24:55 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UGOMmn008195
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 02:24:23 +1000
Date: Mon, 30 May 2016 21:54:04 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: mpe@ellerman.id.au, ego@linux.vnet.ibm.com, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 08/10] powerpc/powernv: Add platform support for stop
 instruction
References: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464095714-48772-9-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160528000646.GA5658@ram.oc3035372033.ibm.com>
In-Reply-To: <20160528000646.GA5658@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ram,

On 05/28/2016 05:36 AM, Ram Pai wrote:
> On Tue, May 24, 2016 at 06:45:12PM +0530, Shreyas B. Prabhu wrote:
[snip]
>> @@ -230,11 +236,18 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
>>  			show_fastsleep_workaround_applyonce,
>>  			store_fastsleep_workaround_applyonce);
>>  
>> +/*
>> + * First deep stop state. Used to figure out when to save/restore
>> + * hypervisor context.
>> + */
>> +u64 pnv_first_deep_stop_state;
> 
> maybe this has to be intialized to some correct default value?
> 
> It there a gaurantee that OPAL_PM_STOP_INST_FAST is set only when
> CPU_FTR_ARCH_300 is supported?
> 

Stop instruction is newly introduced in POWER ISA v3.0. So it is
guaranteed that OPAL_PM_STOP_INST_FAST is set only when CPU_FTR_ARCH_300
is supported. So the scenario you've described below will not arise.

> if cpu_has_feature(CPU_FTR_ARCH_300) is not true, than
> pnv_first_deep_stop_state will be not be initialized.  
> 
> And if supported_cpuidle_states
> has OPAL_PM_STOP_INST_FAST flag set, than power_stop0 is called which
> will blindly use pnv_first_deep_stop_state thinking it is initialized to
> something sane.
> 

Thanks,
Shreyas
