Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmc5w1hPGzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 01:20:20 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v18so14536120pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 08:20:20 -0700 (PDT)
Date: Tue, 13 Jun 2017 01:20:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/14] powerpc/64s: cpuidle set polling before enabling
 irqs
Message-ID: <20170613012006.387e19d5@roar.ozlabs.ibm.com>
In-Reply-To: <20170612151025.GG10921@in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-11-npiggin@gmail.com>
 <20170612151025.GG10921@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Jun 2017 20:40:25 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> On Mon, Jun 12, 2017 at 09:58:31AM +1000, Nicholas Piggin wrote:
> > local_irq_enable can cause interrupts to be taken which could
> > take significant amount of processing time. The idle process
> > should set its polling flag before this, so another process that
> > wakes it during this time will not have to send an IPI.
> > 
> > Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Looks good. Were you able to see this make a difference in any of the
> tests ?

No I didn't measure a difference or have a test case where this was
noticable. I think on a workload with some IO interrupts as well as
cross-CPU wakeups, then statistically we should see some improvement
in IPI rates with this patch.

Thanks,
Nick
