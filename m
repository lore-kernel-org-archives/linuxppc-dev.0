Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C44741A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 18:39:00 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F08D140082
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 18:39:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 18:38:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8AAFB2CE805B
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 18:38:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7C8cnxP58917022
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 18:38:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7C8cO86000603
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 18:38:24 +1000
Message-ID: <55CB05EF.5060900@linux.vnet.ibm.com>
Date: Wed, 12 Aug 2015 14:08:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [V3] powerpc/irq: Enable some more exceptions in /proc/interrupts
 interface
References: <20150804095726.66D4A1402E2@ozlabs.org>
 <1439087233.3715.52.camel@kernel.crashing.org>
In-Reply-To: <1439087233.3715.52.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2015 07:57 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-08-04 at 19:57 +1000, Michael Ellerman wrote:
>> > On Mon, 2015-13-07 at 08:16:06 UTC, Anshuman Khandual wrote:
>>> > > This patch enables facility unavailable exceptions for generic facility,
>>> > > FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
>>> > > newly added IRQ statistical counters as and when these exceptions happen.
>>> > > This also adds couple of helper functions which will be called from within
>>> > > the interrupt handler context to update their statistics. Similarly this
>>> > > patch also enables alignment and program check exceptions as well.
>> > 
>> > ...
>> > 
>>> > > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>>> > > index 0a0399c2..a86180c 100644
>>> > > --- a/arch/powerpc/kernel/exceptions-64s.S
>>> > > +++ b/arch/powerpc/kernel/exceptions-64s.S
>>> > > @@ -1158,6 +1158,7 @@ BEGIN_FTR_SECTION
>>> > >  END_FTR_SECTION_IFSET(CPU_FTR_TM)
>>> > >  #endif
>>> > >  	bl	load_up_fpu
>>> > > +	bl	fpu_unav_exceptions_count
>> > 
>> > Is it safe to call C code here?
> Even if it was (at some stage it wasn't, I'd have to look very closely
> to see what's the situation now), we certainly don't want to add
> overhead to load_up_fpu.

As I had already mentioned in the V2 thread of this patch, the
FPU performance with this patch being applied is still very much
comparable to the kernel without this patch. Though I have not
verified whether this still holds true with the new changes being
proposed in exceptions-64s.S (earlier reply in this thread) to
make the C function call safer.

Average of 1000 iterations (context_switch2 --fp 0 0)

With    the patch : 322599.57  (Average of 1000 results)
Without the patch : 320464.924 (Average of 1000 results)

With standard deviation of the results.

6029.1407073288 (with patch ) 5941.7684079774 (without patch)

Wondering if the result above still does not convince us
that FPU performance might not be getting hit because of
this patch, let me know if we need to do more experiments.
