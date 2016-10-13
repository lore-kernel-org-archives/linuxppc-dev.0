Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svpK52ftVzDsyf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:24:09 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9DBIm0L096454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 07:24:06 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26269p9r2p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 07:24:06 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 13 Oct 2016 07:24:05 -0400
Date: Thu, 13 Oct 2016 16:53:57 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "skiboot@lists.ozlabs.org" <skiboot@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] powernv: Pass PSSCR value and mask to power9_idle_stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1475130107.git.ego@linux.vnet.ibm.com>
 <21e080ffa52f432b40750028a624aee1baebbaf7.1475130107.git.ego@linux.vnet.ibm.com>
 <87int84d6w.fsf@concordia.ellerman.id.au>
 <0e7ad8ff-8c44-86bc-f560-258bc7b29a32@gmail.com>
 <20161007072058.GC13873@in.ibm.com>
 <87lgxuf7tk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lgxuf7tk.fsf@linux.vnet.ibm.com>
Message-Id: <20161013112357.GB9002@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stewart,

On Wed, Oct 12, 2016 at 04:35:35PM +1100, Stewart Smith wrote:
> 
> What if we just treat the 0xF state from firmware as special and set it
> to DEFAULT_PSSCR_MASK in that case? That deals with old skiboot, new
> kernel, and sets a pretty small special case that's easy to track into
> the future as something we should watch out for.

Yes, that will work. I will use this approach in the next version.

> 
> Additionally, if we make skiboot set sane values in ~DEFAULT_PSSCR_MASK
> for valid fields in PSSCR on boot/(also kexec?), then
> we should end up in a situation where everything works with everything
> (even if you don't get the best power saving). Specifically, new
> skiboot, old kernel... but it looks like there's nothing currently
> missing there

No we're not missing much there. From the code of the old kernel, I
see that if we pass the psscr_val instead of just the RL to
power9_idle_stop(), we end up saving all the SPRs in
power_enter_stop() even if the psscr_val didn't correspond to a deep
idle state.

But that should be ok.

> 
> Should this patch also have Fixes: 3005c597ba4 and CC to stable?

Yes, thanks for pointing it out. I shall mark the next version to
stable.

> 
> -- 
> Stewart Smith
> OPAL Architect, IBM.

--
Thanks and Regards
gautham.
