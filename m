Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcV7V0x1YzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 20:23:33 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UAImrI011634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 06:23:31 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2as0syn35c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 06:23:31 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 30 May 2017 06:23:30 -0400
Date: Tue, 30 May 2017 15:53:24 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powernv:idle: Correctly initialize core_idle_state_ptr
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <f6c49fcf42b78c0b8bdad17d6e659679c0288cd9.1494585671.git.ego@linux.vnet.ibm.com>
 <20170530155612.701ca6fc@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170530155612.701ca6fc@roar.ozlabs.ibm.com>
Message-Id: <20170530102324.GA8563@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

On Tue, May 30, 2017 at 03:56:12PM +1000, Nicholas Piggin wrote:
> On Tue, 16 May 2017 14:19:43 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > The lower 8 bits of core_idle_state_ptr tracks the number of non-idle
> > threads in the core. This is supposed to be initialized to bit-map
> > corresponding to the threads_per_core. However, currently it is
> > initialized to PNV_CORE_IDLE_THREAD_BITS (0xFF). This is correct for
> > POWER8 which has 8 threads per core, but not for POWER9 which has 4
> > threads per core.
> > 
> > As a result, on POWER9, core_idle_state_ptr gets initialized to
> > 0xFF. In case when all the threads of the core are idle, the bits
> > corresponding tracking the idle-threads are non-zero. As a result, the
> > idle entry/exit code fails to save/restore per-core hypervisor state
> > since it assumes that there are threads in the cores which are still
> > active.
> > 
> > Fix this by correctly initializing the lower bits of the
> > core_idle_state_ptr on the basis of threads_per_core.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> This looks good to me.
> 
> Until this patch series, we can't enable HV state loss idle modes
> on POWER9, is that correct? And after your series does it work?

Yes, that is correct.

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>

Thanks for reviewing the patch!

--
Thanks and Regards
gautham.
