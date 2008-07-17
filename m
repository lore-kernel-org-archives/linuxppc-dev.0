Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 703B3DE082
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 04:24:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Thu, 17 Jul 2008 13:24:37 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B34D32@ismail.innsys.innovsys.com>
In-Reply-To: <200807171747.28624.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807170032.36564.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34B71@ismail.innsys.innovsys.com>
	<200807171747.28624.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Seeing more hits in handle_mm_fault suggests that you have
> a higher page fault rate. A trivial reason for this might
> be that the amount of memory was misdetected in the new
> code (maybe broken device tree). What is the content of
> /proc/meminfo after a fresh boot?
Powerpc
MemTotal:      1011296 kB
MemFree:        953884 kB
Buffers:         20316 kB
Cached:          25896 kB
SwapCached:          0 kB
Active:          26228 kB
Inactive:        25652 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             132 kB
Writeback:           0 kB
AnonPages:        5684 kB
Mapped:           2436 kB
Slab:             2460 kB
SReclaimable:      732 kB
SUnreclaim:       1728 kB
PageTables:        208 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    505648 kB
Committed_AS:    11472 kB
VmallocTotal:   474756 kB
VmallocUsed:      8776 kB
VmallocChunk:   465664 kB

Ppc:
MemTotal:      1011500 kB
MemFree:        954868 kB
Buffers:         20696 kB
Cached:          25044 kB
SwapCached:          0 kB
Active:          26816 kB
Inactive:        24588 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             124 kB
Writeback:           0 kB
AnonPages:        5680 kB
Mapped:           2456 kB
Slab:             2056 kB
SReclaimable:      736 kB
SUnreclaim:       1320 kB
PageTables:        180 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    505748 kB
Committed_AS:    11468 kB
VmallocTotal:   245696 kB
VmallocUsed:       360 kB
VmallocChunk:   245276 kB

> If it's the same, try running a kernel build with 'time --verbose',
> using GNU time instead of the bash builtin time to see how the page
> fault rate changed.=20

Arch/powerpc
        Command being timed: "make vmlinux"
        User time (seconds): 4339.11
        System time (seconds): 319.41
        Percent of CPU this job got: 99%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 1:17:42
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 4213347
        Voluntary context switches: 53543
        Involuntary context switches: 90165
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

Arch/ppc
        Command being timed: "make vmlinux"
        User time (seconds): 4177.11
        System time (seconds): 295.00
        Percent of CPU this job got: 99%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 1:14:35
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 4203103
        Voluntary context switches: 53812
        Involuntary context switches: 85856
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0
