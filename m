Return-Path: <srs0=tuhh=ah=linux.vnet.ibm.com=brking@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnPsq5XrVzDrKf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 23:42:55 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xnPsq4dfLz8t3H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 23:42:55 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xnPsq0xB0z9sNV
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2017 23:42:54 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v86DgRXO128812
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2017 09:42:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ctckutdc9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Sep 2017 09:42:53 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 6 Sep 2017 09:42:52 -0400
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
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 08:42:50 -0500
MIME-Version: 1.0
In-Reply-To: <87y3pvgyko.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <38f27cd0-7f1a-b3ca-d8f3-615bd97637be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/2017 06:19 PM, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> 2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
>>>    kernel, then we should also avoid resetting the ipr adapter, so ipr
>>>    init on the kernel being kexec booted from skiboot should be extremely fast. 
>>
>> OK, I didn't know that was an option, so that might help.
>>
>>> ...
>>> If you've got cases where ipr init is taking a long time, I'd be
>>> interested to know what scenarios are the most annoying to see if there
>>> is any opportunity to improve.
>>
>> Yeah booting bare metal is where I see it (not using ipr.fast_reboot).
> 
> Hrm... We should probably enable that by default for petitboot then.
> 
> It'd at least cut some time off booting straight through to OS.

Agreed. I'd be interested to hear if that helps address the issue
Michael is seeing.

You can easily test this by exiting to a petitboot shell:

echo 1 > /sys/module/ipr/parameters/fast_reboot

Then go back to petitboot and boot the OS.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
