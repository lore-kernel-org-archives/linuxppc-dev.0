Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wNdS2SX6zF2QJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 20:12:27 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7MA9KNo038855
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 06:12:25 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m14nt2s6w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 06:12:25 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Wed, 22 Aug 2018 11:12:23 +0100
From: Michael Ellerman <michaele@au1.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michal Suchanek <msuchanek@suse.de>, Manjunatha H R <manjuhr1@in.ibm.com>,
 Michael Bringmann <mbringm@us.ibm.com>
Subject: Re: [v5] powerpc/topology: Get topology for shared processors at boot
In-Reply-To: <20180822020542.GC2080@linux.vnet.ibm.com>
References: <1534517679-10792-1-git-send-email-srikar@linux.vnet.ibm.com>
 <41vnBN2hf3z9s8T@ozlabs.org> <20180822020542.GC2080@linux.vnet.ibm.com>
Date: Wed, 22 Aug 2018 20:12:16 +1000
Message-Id: <87sh36lngf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <patch-notifications@ellerman.id.au> [2018-08-21 20:35=
:23]:
>
>> On Fri, 2018-08-17 at 14:54:39 UTC, Srikar Dronamraju wrote:
>> > On a shared lpar, Phyp will not update the cpu associativity at boot
>> > time. Just after the boot system does recognize itself as a shared lpa=
r and
>> > trigger a request for correct cpu associativity. But by then the sched=
uler
>> > would have already created/destroyed its sched domains.
>> >=20
>> > This causes
>> > - Broken load balance across Nodes causing islands of cores.
>> > - Performance degradation esp if the system is lightly loaded
>> > - dmesg to wrongly report all cpus to be in Node 0.
>> > - Messages in dmesg saying borken topology.
>> > - With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity
>> >   node sched domain"), can cause rcu stalls at boot up.
>> >=20
>> >=20
>> > Previous attempt to solve this problem
>> > https://patchwork.ozlabs.org/patch/530090/
>> >=20
>> > Reported-by: Manjunatha H R <manjuhr1@in.ibm.com>
>> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>>=20
>> Applied to powerpc next, thanks.
>>=20
>> https://git.kernel.org/powerpc/c/2ea62630681027c455117aa471ea3a
>>=20
>
> Once it gets to Linus's tree, can we request this to be included in
> stable trees?

You can yes.

I'd prefer if we wait a week or two so it can get some testing first.

cheers
