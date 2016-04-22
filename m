Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrkN13C8QzDqgC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:29 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 22 Apr 2016 15:15:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E2C9B2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:12 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3M5F46T12517750
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:12 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3M5EdMm012841
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:14:40 +1000
Subject: Re: [PATCH 1/2] cxl: Keep IRQ mappings on context teardown
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <1461301069-12331-1-git-send-email-mikey@neuling.org>
Cc: Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, imunsie@au1.ibm.com,
 Frank Haverkamp <HAVERKAM@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5719B326.7030500@au1.ibm.com>
Date: Fri, 22 Apr 2016 15:14:14 +1000
MIME-Version: 1.0
In-Reply-To: <1461301069-12331-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/04/16 14:57, Michael Neuling wrote:
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

Tested on top of 4.6-rc3 using the genwqe-echo test utility[0].

Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

[0] 
https://github.com/ibm-genwqe/genwqe-user/blob/master/tools/genwqe_echo.c

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
