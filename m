Return-Path: <srs0=t29/=fr=linux.vnet.ibm.com=brking@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zp1mg55wtzF0R7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 06:41:07 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zp1mg4Fhtz8t72
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 06:41:07 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zp1mf71b2z9s06
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2018 06:41:06 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1NJY8ok040656
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 14:41:04 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gapm4xp5j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 14:41:04 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 23 Feb 2018 12:41:03 -0700
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "dougmill@us.ibm.com" <dougmill@us.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
 <877exjud52.fsf@concordia.ellerman.id.au>
 <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
 <87mv6f56vl.fsf@concordia.ellerman.id.au> <87y3pvgyko.fsf@linux.vnet.ibm.com>
 <38f27cd0-7f1a-b3ca-d8f3-615bd97637be@linux.vnet.ibm.com>
 <87y3jkpt0p.fsf@concordia.ellerman.id.au> <87inaopnlh.fsf@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 13:41:00 -0600
MIME-Version: 1.0
In-Reply-To: <87inaopnlh.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f7060a3e-9a86-8c90-f102-c3b5b49b4ea3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2018 06:16 PM, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Brian King <brking@linux.vnet.ibm.com> writes:
>>> On 09/03/2017 06:19 PM, Stewart Smith wrote:
>>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>>>> 2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
>>>>>>    kernel, then we should also avoid resetting the ipr adapter, so ipr
>>>>>>    init on the kernel being kexec booted from skiboot should be extremely fast. 
>>>>>
>>>>> OK, I didn't know that was an option, so that might help.
>>>>>
>>>>>> ...
>>>>>> If you've got cases where ipr init is taking a long time, I'd be
>>>>>> interested to know what scenarios are the most annoying to see if there
>>>>>> is any opportunity to improve.
>>>>>
>>>>> Yeah booting bare metal is where I see it (not using ipr.fast_reboot).
>>>>
>>>> Hrm... We should probably enable that by default for petitboot then.
>>>>
>>>> It'd at least cut some time off booting straight through to OS.
>>>
>>> Agreed. I'd be interested to hear if that helps address the issue
>>> Michael is seeing.
>>>
>>> You can easily test this by exiting to a petitboot shell:
>>>
>>> echo 1 > /sys/module/ipr/parameters/fast_reboot
>>>
>>> Then go back to petitboot and boot the OS.
>>
>> Just following up on this (!).
>>
>> This does work, and I've now been running it in my CI for about a month
>> (~1000 boots) with no problems.
>>
>> You can also make it persistent by doing:
>>
>>   $ nvram -p ibm,skiboot --update-config bootargs="ipr.fast_reboot=1"
> 
> Okay, cool. https://github.com/open-power/op-build/pull/1900 will set it
> in firmware - we may as well run with this and fix any bugs we find.
> 
> Any reason why it isn't the default behaviour?

The primary reason this isn't the default setting is because it would cause
undesired behavior on system reboots. On a kexec reboot, since the PCIe slots
don't get power cycled or even hit with PERST, we can simply quiesce devices
and pick them up at the other side of the kexec. On a real reboot where the
firmware or hardware may end up doing a PERST or power cycle, we need to tell the ipr
adapters that is coming and let them shutdown gracefully. If we don't,
we will likely be OK in the single adapter configuration in most scenarios,
but for a dual ipr adapter configuration, we can then end up with undesired
adapter failovers occurring due to the unexpected power offs / resets, which
can then end up extending the next boot.

-Brian 

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
