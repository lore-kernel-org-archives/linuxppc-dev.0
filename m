Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9234467C3C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 05:20:21 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9GJKHn2022282
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 15:20:17 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9GJKHFM261984
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 15:20:17 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9GJKHAi009280
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 15:20:17 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 14:20:08 -0500
Message-Id: <1161026409.31903.15.camel@farscape>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Here is the content of /sys/devices/system/node/*  and /proc/meminfo.  
This is from the same partition, booted with a 2.6.16-ish distro
kernel. 

notice that the node1/meminfo MemUsed value seems just a little bit
elevated.   MemFree being larger than MemTotal seems a bit wrong too. 

14:07:43 0 willschm@airbag2:~> find /sys/devices/system/node -type f
-print -exec cat {} \;
/sys/devices/system/node/node1/distance
20 10
/sys/devices/system/node/node1/numastat
numa_hit 6279
numa_miss 141588
numa_foreign 0
interleave_hit 5218
local_node 0
other_node 147867
/sys/devices/system/node/node1/meminfo

Node 1 MemTotal:       327680 kB
Node 1 MemFree:        435704 kB
Node 1 MemUsed:      18446744073709443592 kB
Node 1 Active:          41412 kB
Node 1 Inactive:        19976 kB
Node 1 HighTotal:           0 kB
Node 1 HighFree:            0 kB
Node 1 LowTotal:       327680 kB
Node 1 LowFree:        435704 kB
Node 1 Dirty:               0 kB
Node 1 Writeback:           0 kB
Node 1 Mapped:              0 kB
Node 1 Slab:                0 kB
Node 1 HugePages_Total:     0
Node 1 HugePages_Free:      0
/sys/devices/system/node/node1/cpumap
00000000,00000000,00000000,00000000
/sys/devices/system/node/node0/distance
10 20
/sys/devices/system/node/node0/numastat
numa_hit 0
numa_miss 0
numa_foreign 141749
interleave_hit 0
local_node 0
other_node 0
/sys/devices/system/node/node0/meminfo

Node 0 MemTotal:       229376 kB
Node 0 MemFree:             0 kB
Node 0 MemUsed:        229376 kB
Node 0 Active:              0 kB
Node 0 Inactive:            0 kB
Node 0 HighTotal:           0 kB
Node 0 HighFree:            0 kB
Node 0 LowTotal:       229376 kB
Node 0 LowFree:             0 kB
Node 0 Dirty:               8 kB
Node 0 Writeback:           0 kB
Node 0 Mapped:          33940 kB
Node 0 Slab:            25500 kB
Node 0 HugePages_Total:     0
Node 0 HugePages_Free:      0
/sys/devices/system/node/node0/cpumap
00000000,00000000,00000000,000000ff

---
14:07:45 0 willschm@airbag2:~> cat /proc/meminfo
MemTotal:       531628 kB
MemFree:        436000 kB
Buffers:          2880 kB
Cached:          35156 kB
SwapCached:          0 kB
Active:          41364 kB
Inactive:        19976 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       531628 kB
LowFree:        436000 kB
SwapTotal:      803240 kB
SwapFree:       803240 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          33776 kB
Slab:            25332 kB
CommitLimit:   1069052 kB
Committed_AS:    81980 kB
PageTables:       1088 kB
VmallocTotal: 8589934592 kB
VmallocUsed:      2560 kB
VmallocChunk: 8589931608 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:    16384 kB
