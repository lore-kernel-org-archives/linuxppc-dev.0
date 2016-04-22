Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrlRG4JyvzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:03:22 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 11:33:19 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3M63FBQ56754400
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 11:33:16 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3M63BQ9011330
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 11:33:13 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: mikey@neuling.org, Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, Frank Haverkamp <HAVERKAM@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] cxl: Keep IRQ mappings on context teardown
In-Reply-To: <1461301069-12331-1-git-send-email-mikey@neuling.org>
References: <1461301069-12331-1-git-send-email-mikey@neuling.org>
Date: Fri, 22 Apr 2016 11:33:05 +0530
Message-ID: <87y4866uzq.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Keep IRQ mappings on context teardown.  This won't leak IRQs as if we
> allocate the mapping again, the generic code will give the same
> mapping used last time.
>
> Doing this works around a race in the generic code. Masking the
> interrupt introduces a race which can crash the kernel or result in
> IRQ that is never EOIed. The lost of EOI results in all subsequent
> mappings to the same HW IRQ never receiving an interrupt.
>
> We've seen this race with cxl test cases which are doing heavy context
> startup and teardown at the same time as heavy interrupt load.
>
> A fix to the generic code is being investigated also.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> cc: stable@vger.kernel.org # 3.8

Tested on top of following skiboot patches that fix potential races in
phb.

http://patchwork.ozlabs.org/patch/581764/
http://patchwork.ozlabs.org/patch/581765/

Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
