Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcVQ6664gzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 20:36:14 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UAXdi5085743
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 06:36:06 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2as5p53muh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 06:36:06 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 30 May 2017 04:36:05 -0600
Date: Tue, 30 May 2017 16:05:58 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] powernv:idle: Restore LPCR on wakeup from deep-stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <147a42823bae78b98b76b91f736c620b886213ae.1494585671.git.ego@linux.vnet.ibm.com>
 <20170530161731.33fec50d@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170530161731.33fec50d@roar.ozlabs.ibm.com>
Message-Id: <20170530103558.GC8563@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 30, 2017 at 04:17:31PM +1000, Nicholas Piggin wrote:
> On Tue, 16 May 2017 14:19:45 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On wakeup from a deep stop state which is supposed to lose the
> > hypervisor state, we don't restore the LPCR to the old value but set
> > it to a "sane" value via cur_cpu_spec->cpu_restore().
> > 
> > The problem is that the "sane" value doesn't include UPRT and the HR
> > bits which are required to run correctly in Radix mode.
> > 
> > Fix this on POWER9 onwards by restoring the LPCR value whatever it was
> > before executing the stop instruction.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> Yes I think we need this. I have a plan to rework some of
> that cpu_restore and early CPU init stuff, but for now we
> need this.
> 
> Does the OCC restore LPCR properly then we just trash it
> with ->cpu_restore(), or is it always junk?

The microcode restores LPCR to the value that the kernel asks it to
set to in pnv_save_sprs_for_deep_states() via the opal_slw_set_reg. So
it would be some sane state.

However when we return from stop to either the cpuidle or cpuhotplug,
we want LPCR to be restored to the value it hand when it entered stop.


> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
>

Thanks for the review.

--
Thanks and Regards
gautham.
