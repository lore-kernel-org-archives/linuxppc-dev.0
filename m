Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rX3hn2jHjzDqjj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jun 2016 03:17:29 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5IHED80026594
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 13:17:26 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n29u9q37-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 13:17:26 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 18 Jun 2016 11:17:25 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
In-Reply-To: <1466127964.12899.5.camel@ellerman.id.au>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
 <1466078830.19127.0.camel@ellerman.id.au>
 <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
 <1466116390.24271.27.camel@kernel.crashing.org>
 <1466127964.12899.5.camel@ellerman.id.au>
Date: Sat, 18 Jun 2016 22:47:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87eg7u8li9.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Fri, 2016-06-17 at 08:33 +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2016-06-16 at 22:49 +0300, Denis Kirjanov wrote:
>> > -
>> > +BEGIN_MMU_FTR_SECTION
>> > +       b       2f
>> > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
>> >         andi.   r10,r12,MSR_RI  /* check for unrecoverable exception
>> > */
>> >         beq-    2f
>> 
>> Are we taking an SLB miss before we do the fixup maybe ?
>
> Yeah that's the only explanation that makes any sense.
>
> I think instead of patching down this low we should instead be redirecting SLB
> misses to unknown_exception() when radix is enabled. Aneesh?
>

The 2f branch ends up doing unrecoverable exception. Or are you
suggesting something else ?

-aneesh
