Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryPTK24CWzDqMc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:55:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P1rgRm055172
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:54:58 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c26nv5ye-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:54:58 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Sun, 24 Jul 2016 22:54:56 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 51C7D352005F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:54:34 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P1sr3Z26018288
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:54:53 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P1srOL032115
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:54:53 -0300
Subject: Re: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87fuqy1r3i.fsf@concordia.ellerman.id.au> <20160725014641.GA21781@gwshan>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Sun, 24 Jul 2016 22:54:51 -0300
MIME-Version: 1.0
In-Reply-To: <20160725014641.GA21781@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5795716B.8030306@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2016 10:46 PM, Gavin Shan wrote:
> On Mon, Jul 25, 2016 at 10:47:13AM +1000, Michael Ellerman wrote:
>> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>>
>>> This is a very minor/trivial fix for the output of PCI address on EEH logs.
>>> The PCI address on "OF node" field currently is using ":" as a separator
>>> for the function, but the usual separator is ".". This patch changes the
>>> separator for dot, so the PCI address is printed as usual.
>>>
>>> No functional changes were introduced.
>>
>> What consumes the log? Can it cope with us changing the formatting?
>>
>
> The log is printed by pr_warn() as part of the EEH kernel log. Also,
> it's argument passed to RTAS call "ibm,slot-error-detail" and it's
> put into the user data section of the RTAS call's output, which is
> used by RTAS daemon (rtasd) then. I don't see anyone expects fixed
> format for it in the user data section.
>
> The format was ever adjusted in commit 0ed352dddbfc ("powerpc/eeh:
> Reduce lines of log dump") on Jul 17 2014. No complains received
> against it so far. I guess nobody cares about the format or there
> is a alarm isn't raised yet :)

Thanks very much for the details Gavin.

You can "discard" my last reply then, since this explains the use of 
"ibm,slot-error-detail" correctly.

Cheers,


Guilherme


>
> Thanks,
> Gavin
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
