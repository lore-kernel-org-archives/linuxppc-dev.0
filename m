Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 802C9DDF31
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:25:07 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/6] powerpc topology updates
Date: Sun, 27 Jul 2008 00:24:49 -0500
Message-Id: <1217136295-18693-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series consists of a couple of cleanups and a few feature
additions, all of which are more or less related to system topology
(threads, cores, caches, sysfs...)  These are independent of
each other except for 4 and 5 (core sibling and core id info).

I'd say the highlights are the last three patches, which add core and
cache information to sysfs.  Here is some example output with the
patches applied:

(Power5)
# grep -r . /sys/devices/system/cpu/cpu0/cache/ | sed
  's/\/sys\/devices\/system\/cpu\///'
cpu0/cache/index0/type:Data
cpu0/cache/index0/level:1
cpu0/cache/index0/size:32K
cpu0/cache/index0/coherency_line_size:128
cpu0/cache/index0/number_of_sets:64
cpu0/cache/index0/ways_of_associativity:4
cpu0/cache/index1/type:Instruction
cpu0/cache/index1/level:1
cpu0/cache/index1/size:64K
cpu0/cache/index1/coherency_line_size:128
cpu0/cache/index1/number_of_sets:256
cpu0/cache/index1/ways_of_associativity:2
cpu0/cache/index2/type:Unified
cpu0/cache/index2/level:2
cpu0/cache/index2/size:1920K
cpu0/cache/index2/coherency_line_size:128
cpu0/cache/index2/number_of_sets:1536
cpu0/cache/index2/ways_of_associativity:10
cpu0/cache/index3/type:Unified
cpu0/cache/index3/level:3
cpu0/cache/index3/size:36864K
cpu0/cache/index3/coherency_line_size:128
cpu0/cache/index3/number_of_sets:1
cpu0/cache/index3/ways_of_associativity:0

(Power6)
# grep -r . /sys/devices/system/cpu/cpu0/topology/ | sed \
  's/\/sys\/devices\/system\/cpu\///'
cpu0/topology/physical_package_id:-1
cpu0/topology/core_id:0
cpu0/topology/thread_siblings:00000003
cpu0/topology/thread_siblings_list:0-1
cpu0/topology/core_siblings:0000000f
cpu0/topology/core_siblings_list:0-3

Nathan Lynch (6):
  kill useless SMT code in prom_hold_cpus
  register_cpu_online should be __cpuinit
  Update cpu_sibling_maps dynamically
  make core sibling information available to userspace
  make core id information available to userspace
  show processor cache information in sysfs

 arch/powerpc/kernel/prom_init.c    |   39 +----
 arch/powerpc/kernel/setup-common.c |   24 ---
 arch/powerpc/kernel/setup_64.c     |    3 -
 arch/powerpc/kernel/smp.c          |  126 ++++++++++++++-
 arch/powerpc/kernel/sysfs.c        |  310 +++++++++++++++++++++++++++++++++++-
 include/asm-powerpc/smp.h          |    2 +
 include/asm-powerpc/topology.h     |    2 +
 7 files changed, 439 insertions(+), 67 deletions(-)
