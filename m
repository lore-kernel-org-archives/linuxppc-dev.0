Message-Id: <200001111925.LAA28576@soda.CSUA.Berkeley.EDU>
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] 2.2.13 SMP: printk() when viewing /proc/cpuinfo
Date: Tue, 11 Jan 2000 11:25:54 -0800
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I compiled a 2.2.13 kernel with SMP enabled and observed the following
printk() message while viewing /proc/cpuinfo:

$ cat /proc/cpuinfo 

get_cpuinfo(): ran out of cpu nodes.
processor	: 0
cpu		: 604e
clock		: 200MHz
revision	: 2.2
bogomips	: 398.95

processor	: 1
cpu		: 604e
clock		: 200MHz
revision	: 2.2
bogomips	: 398.95

total bogomips	: 797.90
zero pages	: total 0 (0Kb) current: 0 (0Kb) hits: 0/226 (0%)
machine		: Power Macintosh
motherboard	: AAPL,7500 MacRISC
L2 cache	: 256K unified
memory		: 160MB
get_cpuinfo(): ran out of cpu nodes.

The printk()'s (get_cpuinfo(): ran out of cpu nodes.) only appear in
SMP mode. They do not appear when the system is in UP mode.

The following patch appears to fix the problem on my system when in
SMP mode (no change in UP mode):

--- arch/ppc/kernel/setup.c.orig        Mon Jan 10 23:24:29 2000
+++ arch/ppc/kernel/setup.c     Mon Jan 10 23:21:34 2000
@@ -274,8 +274,8 @@
                        if ( !cpu_node ) break;
                        {
                                int s;
-                               for ( s = 0; (s < i) && cpu_node->next ;
-                                     s++, cpu_node = cpu_node->next )
+                                for ( s = i ; cpu_node->next && s; 
+                                      cpu_node = cpu_node->next, s--)
                                        /* nothing */ ;
                                if ( s != i )
                                        printk("get_cpuinfo(): ran out of "

Thanks,

----ranga <ranga@soda.berkeley.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
