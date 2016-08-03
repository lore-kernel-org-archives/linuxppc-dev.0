Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4DxS1cQtzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 23:51:08 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73DnN30086005
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 09:51:06 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24k0bmyamf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 09:51:06 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 10:51:03 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 609041DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 09:50:52 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u73Dp19Y4485178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 10:51:01 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u73Dp068013117
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 10:51:00 -0300
Subject: Re: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87fuqy1r3i.fsf@concordia.ellerman.id.au> <20160725014641.GA21781@gwshan>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 3 Aug 2016 10:50:58 -0300
MIME-Version: 1.0
In-Reply-To: <20160725014641.GA21781@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57A1F6C2.7080109@linux.vnet.ibm.com>
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
>
> Thanks,
> Gavin

Quick follow-up on this: RTAS daemon stores the information captured via 
ibm,slot-error-detail in a log file, which can be accessed using the 
command "rtas_dump -f /var/log/platform". More information on this can 
be found in 
https://www.ibm.com/support/knowledgecenter/linuxonibm/liaau/liaau-diagnosing-rtas-events.htm 
.

I was able to check this log and the EEH PCI address output was there, 
in ascii text format.

Thanks,

Guilherme


>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
