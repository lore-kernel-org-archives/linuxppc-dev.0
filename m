Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21FA1A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:05:35 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 826A61402AC
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 16:05:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 15:05:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9960E2CE805B
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 16:05:31 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB255VZb5636248
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 16:05:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB255UUJ018392
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 16:05:31 +1100
Message-ID: <547D488E.6080606@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 10:35:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [V4] powerpc, xmon: Enable HW instruction breakpoint on POWER8
References: <20141201054020.2E47A140160@ozlabs.org>
In-Reply-To: <20141201054020.2E47A140160@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 11:10 AM, Michael Ellerman wrote:
> On Fri, 2014-28-11 at 04:36:42 UTC, Anshuman Khandual wrote:
>> This patch enables support for hardware instruction breakpoint in
>> xmon on POWER8 platform with the help of a new register called the
>> CIABR (Completed Instruction Address Breakpoint Register). With this
>> patch, a single hardware instruction breakpoint can be added and
>> cleared during any active xmon debug session. The hardware based
>> instruction breakpoint mechanism works correctly with the existing
>> TRAP based instruction breakpoint available on xmon.
>>
>> There are no powerpc CPU with CPU_FTR_IABR feature any more. This
>> patch has re-purposed all the existing IABR related code to work
>> with CIABR register based HW instruction breakpoint.
> 
> OK I think I'm happy with this, I am going to add this to the changelog though:
> 
>     This has one odd feature, which is that when we hit a breakpoint xmon
>     doesn't tell us we have hit the breakpoint. This is because xmon is
>     expecting bp->address == regs->nip. Because CIABR fires on completition
>     regs->nip points to the instruction after the breakpoint. We could fix
>     that, but it would then confuse other parts of the xmon code which think
>     we need to emulate the instruction. [mpe]

Sounds good. Thanks Michael.
