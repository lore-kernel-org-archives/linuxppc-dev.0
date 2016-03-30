Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZv4R5Pp8zDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 03:59:03 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qZv4R0rPkz9t0s
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 03:59:02 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 02:59:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5B3DB2CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 03:58:55 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2UGwfAX56819772
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 03:58:55 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2UGwG7B019656
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 03:58:17 +1100
Subject: Re: [v2] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3qZT2T1R7fz9sDC@ozlabs.org> <56FB7CB8.1010801@linux.vnet.ibm.com>
 <56FB83C1.7070306@linux.vnet.ibm.com>
 <1459336643.23987.6.camel@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <56FC0596.5030200@linux.vnet.ibm.com>
Date: Wed, 30 Mar 2016 22:27:58 +0530
MIME-Version: 1.0
In-Reply-To: <1459336643.23987.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/30/2016 04:47 PM, Michael Ellerman wrote:
> On Wed, 2016-03-30 at 13:14 +0530, Hari Bathini wrote:
>> Alternatively, how about moving the OOLs handlers that can't be branched with
>> LOAD_HANDLER under __end_interrupts. This way we won't be copying more than a
>> few absolutely needed handlers.
>>
>> STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
>> .
>> .
>> STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
>>
>>
>> We can leave __end_handlers marker to indicate code that should be part
>> of the first 64K of kernel image.
> That might work. But I suspect you will run into issues with ".org backwards",
> ie. running out of space in head_64.S
>
> But try it and let me know if it works.

It worked. Doing some sanity testing.
Will post v3 soon with this approach.

> I think we also need to write a script or little C program which looks at the
> vmlinux and checks that nothing below __end_whatever does a direct branch. So
> that we don't break it again in future.

Yep. That would make life easy..
Let me see if I can do something about it.

Thanks
Hari
