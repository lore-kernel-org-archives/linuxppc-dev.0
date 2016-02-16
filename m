Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B1E81A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 00:57:46 +1100 (AEDT)
Date: Tue, 16 Feb 2016 14:57:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
Message-ID: <20160216135742.GT12548@pathway.suse.cz>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com>
 <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com>
 <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com>
 <20160216103907.GB25103@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216103907.GB25103@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2016-02-16 11:39:07, Torsten Duwe wrote:
> On Tue, Feb 16, 2016 at 04:00:30PM +0530, Kamalesh Babulal wrote:
> > * Torsten Duwe <duwe@lst.de> [2016-02-16 09:23:02]:
> > > 
> > > N.b.: if you try to livepatch/trace such a leaf function without
> > > global dependencies, it will crash if that function got called with
> > > a different TOC value. Hence this whole testing.
> > > 
> > 
> > I am running out of ideas on how to generate this crash, any pointers
> > will be helpful.
> 
> Petr discovered some modular SCSI helper function does it.

The kernel crashes here when I build it _with_ modules and
enable a tracer.

I see this:

$> lsmod
Module                  Size  Used by
af_packet              46767  0 
dm_mod                148307  0 
e1000                 184154  0 
rtc_generic             2617  0 
ext4                  716333  1 
crc16                   2307  1 ext4
mbcache                14237  1 ext4
jbd2                  143496  1 ext4
sd_mod                 49002  3 
sr_mod                 22532  0 
cdrom                  65024  1 sr_mod
ibmvscsi               34139  2 
scsi_transport_srp     18979  1 ibmvscsi
sg                     44568  0 
scsi_mod              289641  5 sg,scsi_transport_srp,ibmvscsi,sd_mod,sr_mod
autofs4                48256  0 

echo function >/sys/kernel/debug/tracing/current_tracer

BANG!


Some dugging has shown an Oops in the fucntion int_to_scsilun()
called from ibmvscsi_queuecommand(). So, I rebooted and
did the following test:

$> echo ibmvscsi_queuecommand >/sys/kernel/debug/tracing/set_ftrace_filter
$> echo function > /sys/kernel/debug/tracing/current_tracer 
$> echo 1 > /sys/kernel/debug/tracing/tracing_on
$> cat /sys/kernel/debug/tracing/trace
# tracer: function
#
# entries-in-buffer/entries-written: 7/7   #P:4
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-3488  [000] ....   100.278622: ibmvscsi_queuecommand <-scsi_dispatch_cmd
     kworker/1:2-223   [001] ....   101.048569: ibmvscsi_queuecommand <-scsi_dispatch_cmd
     kworker/1:2-223   [001] ....   103.048575: ibmvscsi_queuecommand <-scsi_dispatch_cmd
     jbd2/sda3-8-1021  [003] ....   104.008645: ibmvscsi_queuecommand <-scsi_dispatch_cmd
     jbd2/sda3-8-1021  [003] ....   104.008883: ibmvscsi_queuecommand <-scsi_dispatch_cmd
          <idle>-0     [000] ..s.   104.017672: ibmvscsi_queuecommand <-scsi_dispatch_cmd
          <idle>-0     [003] ..s.   104.017771: ibmvscsi_queuecommand <-scsi_dispatch_cmd

It means that ibmvscsi_queuecommand can be traced. Then I did

c79:/sys/kernel/debug/tracing # echo int_to_scsilun >set_ftrace_filter

BANG!

Unable to handle kernel paging request for data at address 0xd00000000108b148
Faulting instruction address: 0xd000000000bde35c
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: af_packet(E) dm_mod(E) e1000(E) rtc_generic(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sd_mod(E) ibmvscsi(E) scsi_transport_srp(E) sg(E) scsi_mod(E) autofs4(E)
CPU: 1 PID: 223 Comm: kworker/1:2 Tainted: G            E   4.5.0-rc2-11-default+ #90
Workqueue: events_freezable_power_ disk_events_workfn
task: c0000000f7d99aa0 ti: c0000000f7cb8000 task.ti: c0000000f7cb8000
NIP: d000000000bde35c LR: d000000000bcffec CTR: d000000000bcffe0
REGS: c0000000f7cbb3b0 TRAP: 0300   Tainted: G            E    (4.5.0-rc2-11-default+)
MSR: 8000000100009033 <SF,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 24c82220  XER: 00000000
CFAR: d000000000bdd144 DAR: d00000000108b148 DSISR: 40000000 SOFTE: 0 
GPR00: d0000000010a21cc c0000000f7cbb630 d0000000010aeda0 0000000000008200 
GPR04: c0000000fa0b33fc 000000000000014a c0000000fa0b3408 0000000000000010 
GPR08: 0000000000000008 c00000000370a4e0 0000000000000000 d00000000108b128 
GPR12: d000000000bcffe0 c000000007e80300 c0000000000d8b18 c0000000fe04ba80 
GPR16: 0000000000000000 c0000000f7b6f208 0000000000000000 0000000000010000 
GPR20: c0000000f7b6f144 c0000000f7b6f140 d000000000bcbcf0 0000000000000000 
GPR24: 0000000000000200 0000000000000000 0000000000000001 c0000000f7b6f810 
GPR28: c0000000f7b6f000 c0000000f7b6f000 c0000000fa0b33a0 c0000000fe837e00 
NIP [d000000000bde35c] scsi_inq_str+0x21b0/0x41ac [scsi_mod]
LR [d000000000bcffec] int_to_scsilun+0xc/0x60 [scsi_mod]
Call Trace:
[c0000000f7cbb630] [d0000000010a21cc] ibmvscsi_queuecommand+0x10c/0x4e0 [ibmvscsi] (unreliable)
[c0000000f7cbb6e0] [d000000000bcbea8] scsi_dispatch_cmd+0xe8/0x2c0 [scsi_mod]
[c0000000f7cbb760] [d000000000bceb0c] scsi_request_fn+0x50c/0x8b0 [scsi_mod]
[c0000000f7cbb850] [c000000000407280] __blk_run_queue+0x60/0x90
[c0000000f7cbb880] [c000000000413640] blk_execute_rq_nowait+0x100/0x1a0
[c0000000f7cbb8d0] [c000000000413768] blk_execute_rq+0x88/0x170
[c0000000f7cbb9b0] [d000000000bca048] scsi_execute+0x108/0x1d0 [scsi_mod]
[c0000000f7cbba20] [d000000000bca2e8] scsi_execute_req_flags+0xc8/0x150 [scsi_mod]
[c0000000f7cbbae0] [d0000000012209e4] sr_check_events+0xb4/0x340 [sr_mod]
[c0000000f7cbbb90] [d0000000011c00b4] cdrom_check_events+0x44/0x80 [cdrom]
[c0000000f7cbbbc0] [d000000001220fa4] sr_block_check_events+0x44/0x60 [sr_mod]
[c0000000f7cbbbe0] [c0000000004222f8] disk_check_events+0x78/0x1b0
[c0000000f7cbbc50] [c0000000000d0610] process_one_work+0x1a0/0x480
[c0000000f7cbbce0] [c0000000000d0998] worker_thread+0xa8/0x5c0
[c0000000f7cbbd80] [c0000000000d8c24] kthread+0x114/0x140
[c0000000f7cbbe30] [c000000000009538] ret_from_kernel_thread+0x5c/0xa4
Instruction dump:
396bc360 f8410018 e98b0020 7d8903a6 4e800420 00000000 00000000 0044fb30 
c0000000 3d62fffe 396bc388 60000000 <e98b0020> 7d8903a6 4e800420 00000000 
---[ end trace 3b830c669dd7adb5 ]---


Note that ibmvscsi_queuecommand() handle TOC and int_to_scsilun()
does not handle TOC

$> objdump -hdr  drivers/scsi/ibmvscsi/ibmvscsi.ko
00000000000020c0 <ibmvscsi_queuecommand>:
    20c0:       00 00 4c 3c     addis   r2,r12,0
                        20c0: R_PPC64_REL16_HA  .TOC.
    20c4:       00 00 42 38     addi    r2,r2,0
                        20c4: R_PPC64_REL16_LO  .TOC.+0x4
    20c8:       a6 02 08 7c     mflr    r0
    20cc:       10 00 01 f8     std     r0,16(r1)
    20d0:       01 00 00 48     bl      20d0 <ibmvscsi_queuecommand+0x10>
                        20d0: R_PPC64_REL24     _mcount
    20d4:       a6 02 08 7c     mflr    r0


$> objdump -hdr  drivers/scsi/scsi_mod.ko
[...]
000000000000ffe0 <int_to_scsilun>:
    ffe0:       a6 02 08 7c     mflr    r0
    ffe4:       10 00 01 f8     std     r0,16(r1)
    ffe8:       01 00 00 48     bl      ffe8 <int_to_scsilun+0x8>
                        ffe8: R_PPC64_REL24     _mcount
    ffec:       a6 02 08 7c     mflr    r0
    fff0:       10 00 01 f8     std     r0,16(r1)
    fff4:       e1 ff 21 f8     stdu    r1,-32(r1)


I am able to trace int_to_scsilun() if I add a global call
into this fucntion.

I could trace any function when everything is built into the kernel.


I am not sure where the problem is but even normal tracing does not
work with this patchset and when -pg -mprofile-kernel is used.


Best Regards,
Petr
