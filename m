Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCFH46y6xzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:31:12 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0V5JXTa091631
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 00:31:10 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ahepwfgh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 00:31:09 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 15:31:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B12412CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:31:03 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0V5Ut6v25362632
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:31:03 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0V5UVYM001378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:30:31 +1100
Date: Tue, 31 Jan 2017 16:30:06 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
 <20170125045822.GA10566@gwshan>
 <20170127124910.GA2668@localhost.localdomain>
 <20170130120240.5018f476@kryten> <20170131043355.GA25724@gwshan>
 <20170131155816.13cf819f@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131155816.13cf819f@kryten>
Message-Id: <20170131053006.GA5063@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 03:58:16PM +1100, Anton Blanchard wrote:
>Hi,
>
>
>> Anton, I think the behaviour looks good. Actually, it's not very
>> relevant to the issue addressed by the patch. I will reply to
>> Michael's reply about the reason. There are two nodes in your system
>> and the memory is expected to be allocated from node-0. If node-0
>> doesn't have enough free memory, the allocater switches to node-1. It
>> means we need more stress.
>
>Did you try setting zone_reclaim_mode? Surely we should reclaim local
>clean pagecache if enabled?
>

In last experiment, I didn't enable zone_reclaim_mode. After changed it to 0x2
(RECLAIM_WRITE), the local pagecache isn't reclaimed from node-0 as we observed
before.

root@P83-p1:~# cat /proc/sys/vm/zone_reclaim_mode
2
root@P83-p1:~# sync
root@P83-p1:~# echo 3 > /proc/sys/vm/drop_caches
root@P83-p1:~# taskset -c 0 cat /tmp/file.8G > /dev/null
root@P83-p1:~# grep FilePages /sys/devices/system/node/node0/meminfo 
Node 0 FilePages:       8497920 kB
root@P83-p1:~# taskset -c 0 ./alloc 68719476736
root@P83-p1:~# grep FilePages /sys/devices/system/node/node0/meminfo 
Node 0 FilePages:       8497920 kB

With the patch applied, the local pagecache is reclaimed:

root@P83-p1:~# cat /proc/sys/vm/zone_reclaim_mode
2
root@P83-p1:~# sync
root@P83-p1:~# echo 3 > /proc/sys/vm/drop_caches
root@P83-p1:~# taskset -c 0 cat /tmp/file.8G > /dev/null
root@P83-p1:~# grep FilePages /sys/devices/system/node/node0/meminfo
Node 0 FilePages:       8441472 kB
root@P83-p1:~# taskset -c 0 ./alloc 68719476736
root@P83-p1:~# grep FilePages /sys/devices/system/node/node0/meminfo
Node 0 FilePages:        712960 kB

Thanks,
Gavin
