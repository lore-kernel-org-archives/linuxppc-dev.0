Return-Path: <srs0=mktc=fr=linux.vnet.ibm.com=stewart@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znWwk2J5zzF1kR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 11:16:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znWwj2wQlz8tmn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 11:16:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znWwh3cDWz9sWk
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 11:16:20 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1N0EsVx137449
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 19:16:18 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga31wb6gd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 19:16:17 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 17:16:16 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Brian King <brking@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <87y3jkpt0p.fsf@concordia.ellerman.id.au>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
 <877exjud52.fsf@concordia.ellerman.id.au>
 <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
 <87mv6f56vl.fsf@concordia.ellerman.id.au> <87y3pvgyko.fsf@linux.vnet.ibm.com>
 <38f27cd0-7f1a-b3ca-d8f3-615bd97637be@linux.vnet.ibm.com>
 <87y3jkpt0p.fsf@concordia.ellerman.id.au>
Date: Fri, 23 Feb 2018 11:16:10 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87inaopnlh.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Brian King <brking@linux.vnet.ibm.com> writes:
>> On 09/03/2017 06:19 PM, Stewart Smith wrote:
>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>>> 2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
>>>>>    kernel, then we should also avoid resetting the ipr adapter, so ipr
>>>>>    init on the kernel being kexec booted from skiboot should be extremely fast. 
>>>>
>>>> OK, I didn't know that was an option, so that might help.
>>>>
>>>>> ...
>>>>> If you've got cases where ipr init is taking a long time, I'd be
>>>>> interested to know what scenarios are the most annoying to see if there
>>>>> is any opportunity to improve.
>>>>
>>>> Yeah booting bare metal is where I see it (not using ipr.fast_reboot).
>>> 
>>> Hrm... We should probably enable that by default for petitboot then.
>>> 
>>> It'd at least cut some time off booting straight through to OS.
>>
>> Agreed. I'd be interested to hear if that helps address the issue
>> Michael is seeing.
>>
>> You can easily test this by exiting to a petitboot shell:
>>
>> echo 1 > /sys/module/ipr/parameters/fast_reboot
>>
>> Then go back to petitboot and boot the OS.
>
> Just following up on this (!).
>
> This does work, and I've now been running it in my CI for about a month
> (~1000 boots) with no problems.
>
> You can also make it persistent by doing:
>
>   $ nvram -p ibm,skiboot --update-config bootargs="ipr.fast_reboot=1"

Okay, cool. https://github.com/open-power/op-build/pull/1900 will set it
in firmware - we may as well run with this and fix any bugs we find.

Any reason why it isn't the default behaviour?

-- 
Stewart Smith
OPAL Architect, IBM.
