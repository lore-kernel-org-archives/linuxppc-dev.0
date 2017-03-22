Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnz8P4RxdzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:41:57 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M5dBdj128817
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:41:48 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vk0bmw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:41:48 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 01:41:47 -0400
Date: Wed, 22 Mar 2017 11:11:40 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/4] powernv: Move CPU-Offline idle state invocation
 from smp.c to idle.c
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <358fc68275a4986d2e112418aea447f49f644f7e.1490024477.git.ego@linux.vnet.ibm.com>
 <20170321023517.4cb27add@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321023517.4cb27add@roar.ozlabs.ibm.com>
Message-Id: <20170322054140.GA30295@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Tue, Mar 21, 2017 at 02:35:17AM +1000, Nicholas Piggin wrote:
> On Mon, 20 Mar 2017 21:24:15 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Move the piece of code in powernv/smp.c::pnv_smp_cpu_kill_self() which
> > transitions the CPU to the deepest available platform idle state to a
> > new function named pnv_cpu_offline() in powernv/idle.c. The rationale
> > behind this code movement is that the data required to determine the
> > deepest available platform state resides in powernv/idle.c.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> Looks good. As a nitpick, possibly one or two variables in idle.c could
> become static (pnv_deepest_stop_psscr_*).
>

I changed that, but it ended up being in the next patch.

> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

Thanks!

--
Thanks and Regards
gautham.
