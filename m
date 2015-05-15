Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E31BB1A1D13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:15:13 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 15 May 2015 09:45:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4BFC0E0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:48:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F4F61J5243146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:45:06 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F3a9Dx024946
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:06:10 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] perf/script: Ganged exits and VM topology
Date: Fri, 15 May 2015 09:44:25 +0530
Message-Id: <1431663266-13954-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org,
 acme@kernel.org, warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc, if a thread running inside a guest needs to exit to the
host to serve interrupts like the external interrupt, or the hcall
interrupts, etc., all the threads running in that specific vcore
inside the guest exit to the host. These events are called as ganged
exits.

Because of the ganged exits, the other threads (if any) doing useful
work need to exit to the host. They can serve as a parameter to relate
the performance of the VM with their topology.

Here are a couple of examples to correlate this performance metric
with the topology of a VM.

The following setup was used :
Setup 1a :
VM (with 4 vcpus and one core)
ebizzy running on 2 vcpus.
No other load on the other 2 vcpus.
Resultant throughput for ebizzy in this case : 24373 records/sec
Total gang exits : 1174

Setup 1b:
VM (with 4 vcpus and one core)
ebizzy running on 2 vcpus.
Spinloop (while 1) loop running on other 2 vcpus.
Resultant throughput for ebizzy in this case : 20373 records/sec
Total gang exits : 1676

Setup 1c:
VM (with 4 vcpus and one core)
ebizzy running on 2 vcpus.
ping -f running on other 2 vcpus.
Resultant throughput for ebizzy in this case : 7841 records/sec
Total gang exits : 871073

Due to an increase in number of the gang exits, performance of ebizzy
dropped.

To verify the degradation in performance of ebizzy with the other
workloads running on the same core, the same set of loads were run on
the host machine too, with SMT on:
In all the following setups, ebizzy was pinned to 2 cpus and for
setups where some other load is running, the loads were pinned to
the other cpus of the same core.

Setup 2a:
ebizzy alone.
Resultant throughput for ebizzy in this case : 25099 records/sec

Setup 2b:
ebizzy and a spin loop (while 1) running on other cpus of the same
core.
Resultant throughput for ebizzy in this case : 22818 records/sec

Setup 2c:
ebizzy and ping -f (to a other machine in the same subnet).
Resultant throughput for ebizzy in this case : 17982 records/sec

We can see that the performance of ebizzy is dropping due to the
some load running on the other threads of the same core.

The "gang_exits" can serve as a parameter to define the topology of a
VM so that the load running on the VM can give us a maximum
throughput.

Here is an example with "redis" benchmark :

A VM running on 1 core and having two threads.
Running redis benchmark on this VM gives this throughput:
SET: 30048.08 requests per second
GET: 31806.62 requests per second
INCR: 247524.75 requests per second
LPUSH: 30284.68 requests per second
LPOP: 34036.76 requests per second
SADD: 168634.06 requests per second
SPOP: 261096.61 requests per second
MSET (10 keys): 11107.41 requests per second

For the entire run of redis :
Total gang_exits = 1192893

To see if we can reduce the number of gang_exits and increase the
throughput of redis benchmark by trying out a different topology and
system configuration, the cores were split into subcores. Each subcore
now has 2 threads each (SMT 2 mode).

So, the VM was started again with 2 subcores (with 1 thread each)
in SMT 1 mode. Running redis now gives this throughput :
SET: 36231.88 requests per second
GET: 57438.25 requests per second
INCR: 292397.66 requests per second
LPUSH: 38343.56 requests per second
LPOP: 53792.36 requests per second
SADD: 267379.66 requests per second
SPOP: 247524.75 requests per second
MSET (10 keys): 9922.60 requests per second

We see an increase in the performance of redis.
Total gang exits for this case : 0 (because of SMT 1)

The number of vcpus allocated to VM remained the same in both the
cases.

In the host, with the help of gang_exit numbers, we can change the
configuration of the host and the topology of the VM to increase the
throughput of the load (running on a VM).

If there is a single active thread on that core, none of the exits
should be counted in gang_exits.

Do have a look at the patch and let me know your feedback.

Thanks,

---
Hemant Kumar (1):
  perf/script: Python script to display the ganged exits count on powerpc

 tools/perf/scripts/python/gang_exits.py | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/perf/scripts/python/gang_exits.py

-- 
1.9.3
