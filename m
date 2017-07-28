Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJZyZ1Qf2zDrMC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 14:05:58 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6S43kXr085869
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 00:05:55 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byw119txe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 00:05:55 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 14:05:53 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6S45f6U30736630
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 14:05:49 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6S45EVb015984
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 14:05:17 +1000
Subject: Re: [PATCH V8 1/3] powernv: powercap: Add support for powercap
 framework
To: Cyril Bur <cyrilbur@gmail.com>, stewart@linux.vnet.ibm.com
References: <1501045509-21732-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1501045509-21732-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1501205974.3324.1.camel@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Fri, 28 Jul 2017 09:34:53 +0530
MIME-Version: 1.0
In-Reply-To: <1501205974.3324.1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <9b884a27-0b1e-f8b0-c2c5-3246432c6853@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On 07/28/2017 07:09 AM, Cyril Bur wrote:
> Is there any reason that pcap_attrs needs to be contiguous? If not, I
> feel like you could eliminate the entire loop below (and the last one
> as well maybe) and just do the assignment of pattr_groups[].attrs[] up
> there.
> 
> In fact do you even need to store pcap_attrs? If you kcalloc them as
> you need them (in the loop above), you can always free them again on
> error by freeing pattr_groups[].attrs[] right?
> 
> I'll admit I've become quite confused as to the layout of the sysfs dir
>  that you're creating here - would you mind showing what the expected
> layout will be?
> 
> I'll take more of a look once thats more clear in my head
> 
> Thanks,
> 
> Cyril

The sysfs layout looks as below:
# ls /sys/firmware/opal/powercap/
system-powercap

# ls /sys/firmware/opal/powercap/system-powercap/
powercap-current  powercap-max  powercap-min

# grep .  /sys/firmware/opal/powercap/system-powercap/*
/sys/firmware/opal/powercap/system-powercap/powercap-current:2375
/sys/firmware/opal/powercap/system-powercap/powercap-max:2375
/sys/firmware/opal/powercap/system-powercap/powercap-min:1945

Thanks and Regards,
Shilpa
