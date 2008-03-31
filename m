Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 462B2DDF1D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 00:52:19 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m2VEqLP5026561
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 01:52:21 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VEqFQG3838114
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 01:52:15 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VEqEIU002877
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 00:52:14 +1000
Message-ID: <47F0FA9B.5070807@linux.vnet.ibm.com>
Date: Mon, 31 Mar 2008 20:22:11 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.24.4 - kernel bug at kernel/sched.c:5154!
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu,
	Dhaval Giani <dhaval@linux.vnet.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The 2.6.24.4 kernel panic's while booting up on powerpc, The kernel
was compiled with allmodconfig. (please let me know if the .config 
file is needed)


[    0.000000] Kernel command line: ro console=hvc0 rhgb quiet root=LABEL=/1 autobench_args: root=/dev/sda3 ABAT:1206964330 
[    0.103959] BUG: scheduling while atomic: kthreadd/2/0x0007431c
[    0.104051] BUG: scheduling while atomic: kthreadd/3/0xbe118168
[    0.104119] ------------[ cut here ]------------
[    0.104127] kernel BUG at kernel/sched.c:5154!
cpu 0x0: Vector: 700 (Program Check) at [c0000001be11bd70]
    pc: c000000000070b34: .migration_thread+0x64/0x31c
    lr: c000000000093878: .kthread+0x78/0xc4
    sp: c0000001be11bff0
   msr: 8000000000029032
  current = 0xc0000000ee0ed740
  paca    = 0xc000000000497500
    pid   = 3, comm = kthreadd
kernel BUG at kernel/sched.c:5154!
enter ? for help
[c0000001be11c0b0] c000000000093878 .kthread+0x78/0xc4
[c0000001be11c140] c00000000002906c .kernel_thread+0x4c/0x68

0:mon> r
R00 = 0000000000000001   R16 = 0000000000000000
R01 = c0000001be11bff0   R17 = 0000000000000000
R02 = c00000000053ab90   R18 = 0000000000000000
R03 = 0000000000000000   R19 = 4000000001c00000
R04 = c0000000ee0ed740   R20 = c000000000453218
R05 = 0000000000000000   R21 = 0000000002053488
R06 = c000000000497500   R22 = 00000000002c2000
R07 = c0000001be1181b0   R23 = c000000000453488
R08 = 0000000000000000   R24 = 0000000002053218
R09 = c0000000ee0ed73f   R25 = 0000000000000000
R10 = fffffffffffffffc   R26 = c0000000005d40f8
R11 = c000000000497500   R27 = c0000000005d00b0
R12 = c00000000002906c   R28 = c0000001be0c3ca8
R13 = c000000000497500   R29 = c000000000685c00
R14 = 0000000000000000   R30 = c0000000004f7210
R15 = 0000000000000000   R31 = c00000000050c788
pc  = c000000000070b34 .migration_thread+0x64/0x31c
lr  = c000000000093878 .kthread+0x78/0xc4
msr = 8000000000029032   cr  = 28000024
ctr = c000000000070ad0   xer = 0000000020000004   trap =  700

0:mon>  t
[c0000001be11c0b0] c000000000093878 .kthread+0x78/0xc4
[c0000001be11c140] c00000000002906c .kernel_thread+0x4c/0x68
0:mon>  S
msr  = 8000000000001032  sprg0= 0000000000000000
pvr  = 00000000003b0200  sprg1= c000000000497500
dec  = 00000000c4ac67ed  sprg2= c000000000497500
sp   = c0000001be11b620  sprg3= c000000000497500
toc  = c00000000053ab90  dar  = 0000000000000000

0xc000000000070b34 is in migration_thread (kernel/sched.c:5154).
5149    {
5150            int cpu = (long)data;
5151            struct rq *rq;
5152
5153            rq = cpu_rq(cpu);
5154            BUG_ON(rq->migration_thread != current);
5155
5156            set_current_state(TASK_INTERRUPTIBLE);
5157            while (!kthread_should_stop()) {
5158                    struct migration_req *req;
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
