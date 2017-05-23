Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXRMz6kPszDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 06:05:19 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4NJxavj035000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:05:14 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2amr5su4ad-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:05:14 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 23 May 2017 14:05:13 -0600
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Reza Arbab <arbab@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 23 May 2017 15:05:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
Content-Type: text/plain; charset=windows-1252
Message-Id: <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/23/2017 10:52 AM, Reza Arbab wrote:
> On Tue, May 23, 2017 at 10:15:44AM -0500, Michael Bringmann wrote:
>> +static void setup_nodes(void)
>> +{
>> +    int i, l = 32 /* MAX_NUMNODES */;
>> +
>> +    for (i = 0; i < l; i++) {
>> +        if (!node_possible(i)) {
>> +            setup_node_data(i, 0, 0);
>> +            node_set(i, node_possible_map);
>> +        }
>> +    }
>> +}
> 
> This seems to be a workaround for 3af229f2071f ("powerpc/numa: Reset node_possible_map to only node_online_map").

They may be related, but that commit is not a replacement.  The above patch ensures that
there are enough of the nodes initialized at startup to allow for memory hot-add into a
node that was not used at boot.  (See 'setup_node_data' function in 'numa.c'.)  That and
recording that the node was initialized.

I didn't see where any part of commit 3af229f2071f would touch the 'node_possible_map'
which is needed by 'numa.c' and 'workqueue.c'.  The nodemask created and updated by
'mem_cgroup_may_update_nodemask()' does not appear to be the same mask.

> 
> Balbir, you have a patchset which reverts it. Do you think that will be getting merged?
> 
> http://lkml.kernel.org/r/1479253501-26261-1-git-send-email-bsingharora@gmail.com
> (see patch 3/3)
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
