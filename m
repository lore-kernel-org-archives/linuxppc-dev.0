Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVGly6xVzzDqlQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 05:29:02 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FJSxs3134982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 15:28:59 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jswbkjt4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 15:28:59 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 13:28:57 -0600
Date: Thu, 16 Jun 2016 00:58:44 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the
 beginning of CPU_ONLINE
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
 <20160615155350.GB24102@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615155350.GB24102@mtj.duckdns.org>
Message-Id: <20160615192844.GA20301@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Tejun,

On Wed, Jun 15, 2016 at 11:53:50AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 07, 2016 at 08:44:02PM +0530, Gautham R. Shenoy wrote:
> > Currently in the CPU_ONLINE workqueue handler, the
> > restore_unbound_workers_cpumask() will never call
> > set_cpus_allowed_ptr() for a newly created unbound worker thread.
> 
> Hmmm... did you actually verify that this happens?  A new kworker
> always gets bound to the cpumask that it's assigned to in
> create_worker().

Yes I have verified that this happens despite the fact that
create_worker() calls kthread_bind_mask() to bind the worker thread to
attrs->cpumask. However, this doesn't seem to be sufficient.

Consider the following case of a 2-node POWER machine running 4.7-rc3.

CPUs 0-79 belong to the 1st node and CPUs 80-159 belong to the second.

======================================================================
root@fir01:~# uname -r
4.7.0-rc3-vanilla
root@fir01:~# numactl -H
available: 2 nodes (0,8)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
node 0 size: 65246 MB
node 0 free: 64025 MB
node 8 cpus: 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159
node 8 size: 65304 MB
node 8 free: 64985 MB
node distances:
node   0   8 
  0:  10  40 
  8:  40  10 
======================================================================

If we inspect the unbound worker threads affinity we will observe that
the ordered unbound worker threads (pids 6, 1088, 1122) are affined to
the online CPUs while the remaining unbound worker threads are affined
to the nodemask.
======================================================================
root@fir01:/home/ego# ./pr_unbound_workers_affinity.sh #See [1] below
pid 6's current affinity list: 0-159
pid 7's current affinity list: 0-79
pid 1018's current affinity list: 80-159
pid 1054's current affinity list: 80-159
pid 1088's current affinity list: 0-159
pid 1089's current affinity list: 0-79
pid 1090's current affinity list: 80-159
pid 1122's current affinity list: 0-159
pid 1176's current affinity list: 0-79
pid 3683's current affinity list: 0-79
======================================================================

At this point if we offline all but CPU0, the only unbound workers
that exist are the unordered workers and those affined to the first
node.
======================================================================
root@fir01:/home/ego# ./cpuhp.sh 0 1 159 #See [2] below
root@fir01:/home/ego# ./pr_unbound_workers_affinity.sh 
pid 6's current affinity list: 0
pid 7's current affinity list: 0
pid 1088's current affinity list: 0
pid 1089's current affinity list: 0
pid 1122's current affinity list: 0
pid 1176's current affinity list: 0
pid 3683's current affinity list: 0
======================================================================

We now online CPU80 which is the first CPU in the second node. We
would expect that an unbound worker thread corresponding to the second
node would be created and would have the mask 80-159. However, the
newly created workers (pid 4109 and 4110) are affined to CPU0 instead
of CPU80!
======================================================================
root@fir01:/home/ego# ./cpuhp.sh 1 80 80
root@fir01:/home/ego# ./pr_unbound_workers_affinity.sh 
pid 6's current affinity list: 0,80
pid 7's current affinity list: 0
pid 1088's current affinity list: 0,80
pid 1089's current affinity list: 0
pid 1122's current affinity list: 0,80
pid 1176's current affinity list: 0
pid 3683's current affinity list: 0
pid 4109's current affinity list: 0
pid 4110's current affinity list: 0
======================================================================

Furthermore, if we now bring all the CPUs online, we don't expect new
worker threads to be created since the representative for the second
node would have been created with CPU80 coming online. However, we do
expect that those worker threads are affined to CPUs 80-159. But
that's not the case either!
======================================================================
root@fir01:/home/ego# ./cpuhp.sh 1 1 159
root@fir01:/home/ego# ./pr_unbound_workers_affinity.sh 
pid 6's current affinity list: 0-159
pid 7's current affinity list: 0-79
pid 1088's current affinity list: 0-159
pid 1089's current affinity list: 0-79
pid 1122's current affinity list: 0-159
pid 1176's current affinity list: 0-79
pid 3683's current affinity list: 0-79
pid 4109's current affinity list: 0
pid 4110's current affinity list: 0
======================================================================


Note:

[1] pr_unbound_workers_affinity.sh
======================================================================
#!/bin/bash
for PID in `ps aux |grep "kworker/u" | grep -v "grep" | awk '{print $2}'`
do
	taskset -pc $PID
done
======================================================================


[2] cpuhp.sh
======================================================================
#!/bin/bash
VAL=$1
START=$2
END=$3

for i in `seq $START $END`
do
	echo $VAL > /sys/devices/system/cpu/cpu$i/online
done
======================================================================

--
Thanks and Regards
gautham.
