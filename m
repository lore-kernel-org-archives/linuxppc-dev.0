Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNP1V0hYpzDvrr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:50:53 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMBmr6J041986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 06:50:52 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vkwsqyms-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 06:50:51 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 06:50:48 -0500
Subject: Re: [PATCH] powerpc/xmon: Fix data-breakpoint
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <87eg23vjds.fsf@concordia.ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 22 Nov 2016 17:20:38 +0530
MIME-Version: 1.0
In-Reply-To: <87eg23vjds.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5834310E.1050107@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Michael,

On Tuesday 22 November 2016 05:03 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> Xmon data-breakpoint feature is broken.
>>
>> Whenever there is a watchpoint match occurs, hw_breakpoint_handler will
>> be called by do_break via notifier chains mechanism. If watchpoint is
>> registered by xmon, hw_breakpoint_handler won't find any associated
>> perf_event and returns immediately with NOTIFY_STOP. Similarly, do_break
>> also returns without notifying to xmon.
>>
>> Solve this by returning NOTIFY_DONE when hw_breakpoint_handler does not
>> find any perf_event associated with matched watchpoint.
> .. rather than NOTIFY_STOP, which tells the core code to continue
> calling the other breakpoint handlers including the xmon one.
>
> Right?

Yes.

> Also any idea when we broke this?

Hmm, not sure exactly. The code is same since it was merged in 2010 when
support for hw_breakpoint was added for server processor.

-Ravi

> cheers
>
