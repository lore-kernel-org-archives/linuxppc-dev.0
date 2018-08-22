Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41w9qz4FSNzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 12:05:51 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7M242s2091524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 22:05:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m0x41s567-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 22:05:49 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 22 Aug 2018 03:05:47 +0100
Date: Tue, 21 Aug 2018 19:05:42 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michal Suchanek <msuchanek@suse.de>, Manjunatha H R <manjuhr1@in.ibm.com>,
 Michael Bringmann <mbringm@us.ibm.com>
Subject: Re: [v5] powerpc/topology: Get topology for shared processors at boot
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1534517679-10792-1-git-send-email-srikar@linux.vnet.ibm.com>
 <41vnBN2hf3z9s8T@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41vnBN2hf3z9s8T@ozlabs.org>
Message-Id: <20180822020542.GC2080@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <patch-notifications@ellerman.id.au> [2018-08-21 20:35:23]:

> On Fri, 2018-08-17 at 14:54:39 UTC, Srikar Dronamraju wrote:
> > On a shared lpar, Phyp will not update the cpu associativity at boot
> > time. Just after the boot system does recognize itself as a shared lpar and
> > trigger a request for correct cpu associativity. But by then the scheduler
> > would have already created/destroyed its sched domains.
> > 
> > This causes
> > - Broken load balance across Nodes causing islands of cores.
> > - Performance degradation esp if the system is lightly loaded
> > - dmesg to wrongly report all cpus to be in Node 0.
> > - Messages in dmesg saying borken topology.
> > - With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity
> >   node sched domain"), can cause rcu stalls at boot up.
> > 
> > 
> > Previous attempt to solve this problem
> > https://patchwork.ozlabs.org/patch/530090/
> > 
> > Reported-by: Manjunatha H R <manjuhr1@in.ibm.com>
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/2ea62630681027c455117aa471ea3a
> 

Once it gets to Linus's tree, can we request this to be included in
stable trees?

-- 
Thanks and Regards
Srikar Dronamraju
