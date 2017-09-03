Return-Path: <srs0=ikvj=ae=linux.vnet.ibm.com=stewart@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlppd61H4zDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 09:19:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xlppd434lz8tDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 09:19:37 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xlppd10klz9s8J
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2017 09:19:36 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v83NJOFk050195
 for <linuxppc-dev@ozlabs.org>; Sun, 3 Sep 2017 19:19:35 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2crnwt1qgw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 03 Sep 2017 19:19:34 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 3 Sep 2017 19:19:33 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Brian King <brking@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <87mv6f56vl.fsf@concordia.ellerman.id.au>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
 <877exjud52.fsf@concordia.ellerman.id.au>
 <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
 <87mv6f56vl.fsf@concordia.ellerman.id.au>
Date: Mon, 04 Sep 2017 09:19:19 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3pvgyko.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
>> 2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
>>    kernel, then we should also avoid resetting the ipr adapter, so ipr
>>    init on the kernel being kexec booted from skiboot should be extremely fast. 
>
> OK, I didn't know that was an option, so that might help.
>
>> ...
>> If you've got cases where ipr init is taking a long time, I'd be
>> interested to know what scenarios are the most annoying to see if there
>> is any opportunity to improve.
>
> Yeah booting bare metal is where I see it (not using ipr.fast_reboot).

Hrm... We should probably enable that by default for petitboot then.

It'd at least cut some time off booting straight through to OS.

-- 
Stewart Smith
OPAL Architect, IBM.
