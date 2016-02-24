Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A63F31A0351
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 17:55:43 +1100 (AEDT)
Received: by mail-pa0-x230.google.com with SMTP id ho8so7672335pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 22:55:43 -0800 (PST)
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com> <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com> <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com> <20160216103907.GB25103@lst.de>
 <20160216135742.GT12548@pathway.suse.cz>
 <1455678521.2956.4.camel@ellerman.id.au> <20160223170017.GB21932@lst.de>
 <56CD4FA0.4090109@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CD53E7.3010108@gmail.com>
Date: Wed, 24 Feb 2016 17:55:35 +1100
MIME-Version: 1.0
In-Reply-To: <56CD4FA0.4090109@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>

We need to remove the SQUASH_TOC_SAVE_INSNS bits as well, now that the ppc64_profile_stub_insns does not save r2
> Looks like we are getting closer to the final solution Thanks, Balbir 

With the SQUASH_TOC_SAVE_INSNS removed, ftrace function seems to work, but function_graph is broken. I've not yet debugged this.

[   77.182430] b'Oops: Kernel access of bad area, sig: 11 [#1]'
[   77.182464] b'SMP NR_CPUS=32 NUMA pSeries'
[   77.182513] b'Modules linked in: sr_mod cdrom virtio_blk virtio_net ibmvscsi scsi_transport_srp scsi_mod virtio_pci virtio_ring virtio'
[   77.182661] b'CPU: 1 PID: 2287 Comm: sshd Not tainted 4.5.0-rc4-00007-g1968536-dirty #143'
[   77.182709] b'task: c000000037b6bc00 ti: c00000003e8c4000 task.ti: c00000003e8c4000'
[   77.182757] b'NIP: c000000000194ebc LR: c000000000049d4c CTR: d0000000004f1434'
[   77.182804] b'REGS: c00000003e8c72a0 TRAP: 0300   Not tainted  (4.5.0-rc4-00007-g1968536-dirty)'
[   77.182858] b'MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28282828  XER: 20000000'
[   77.183008] b'CFAR: c00000000017f400 DAR: d000000000653c70 DSISR: 40000000 SOFTE: 1 '
[   77.183008] b'GPR00: c000000000009f3c c00000003e8c7520 d0000000004fde40 c00000000077da34 '
[   77.183008] b'GPR04: d0000000004f1430 c00000003e008100 c00000003719e520 c00000003719e008 '
[   77.183008] b'GPR08: c00000000113ea50 d00000000064de40 d0000000004f57b8 c000000000009d1c '
[   77.183008] b'GPR12: c00000000077da34 c00000000fff8400 00000000000005a8 0000000040000000 '
[   77.183008] b'GPR16: 0000000022000000 00000000000346db c00000003e8c7720 c00000000113fbe0 '
[   77.183008] b'GPR20: 0000000000000000 c00000000113fbd0 c000000037a9dc00 0000000000000000 '
[   77.183008] b'GPR24: 0000000000000000 c00000000113fbe0 c000000037077000 c000000037077090 '
[   77.183008] b'GPR28: c0000000379982d8 d0000000004f1430 c00000000077da34 c000000037077068 '
[   77.183788] b'NIP [c000000000194ebc] ftrace_graph_is_dead+0xc/0x20'
[   77.183850] b'LR [c000000000049d4c] prepare_ftrace_return+0x2c/0x110'
---Type <return> to continue, or q <return> to quit---
[   77.183890] b'Call Trace:'
[   77.183911] b'[c00000003e8c7520] [c000000037a9dc00] 0xc000000037a9dc00 (unreliable)'
[   77.183987] b'[c00000003e8c7570] [c000000000009f3c] ftrace_graph_caller+0x34/0x74'
[   77.184080] b'[c00000003e8c75e0] [c00000000077da34] dev_hard_start_xmit+0x374/0x4e0'
[   77.184139] b'[c00000003e8c76c0] [c000000000009f7c] return_to_handler+0x0/0x58 (bad_page_fault+0x130/0x150)'
[   77.184210] b'[c00000003e8c7760] [c000000000009f7c] return_to_handler+0x0/0x58 (handle_page_fault+0x2c/0x30)'
[   77.184281] b'[c00000003e8c7800] [c000000000009f7c] return_to_handler+0x0/0x58 (sch_direct_xmit+0xe0/0x2d0)'
[   77.184369] b'[c00000003e8c7860] [c000000000009f7c] return_to_handler+0x0/0x58 (__dev_queue_xmit+0x2d4/0x6a0)'
[   77.184473] b'[c00000003e8c78f0] [c000000000009f7c] return_to_handler+0x0/0x58 (return_to_handler+0x0/0x58)'
[   77.184544] b'[c00000003e8c7930] [c000000000009f7c] return_to_handler+0x0/0x58 (ip_finish_output2+0x348/0x420)'
[   77.184614] b'[c00000003e8c79a0] [c000000000009f7c] return_to_handler+0x0/0x58 (return_to_handler+0x0/0x58)'
[   77.184684] b'[c00000003e8c7a70] [c000000000009f7c] return_to_handler+0x0/0x58 (ip_output+0xd0/0x160)'
[   77.184754] b'[c00000003e8c7ae0] [c000000000009f7c] return_to_handler+0x0/0x58 (ip_local_out+0x6c/0x90)'
[   77.184823] b'[c00000003e8c7b30] [c000000000009f7c] return_to_handler+0x0/0x58 (return_to_handler+0x0/0x58)'
[   77.184893] b'[c00000003e8c7c00] [c000000000009f7c] return_to_handler+0x0/0x58 (tcp_transmit_skb+0x980/0xa50)'
[   77.184969] b'[c00000003e8c7c40] [c000000000009f7c] return_to_handler+0x0/0x58 (tcp_write_xmit+0xd9c/0x1120)'
[   77.185039] b'[c00000003e8c7c60] [c000000000009f7c] return_to_handler+0x0/0x58 (__tcp_push_pending_frames+0x50/0x130)'
[   77.185117] b'[c00000003e8c7d00] [c000000000009f7c] return_to_handler+0x0/0x58 (tcp_push+0x194/0x1e0)'
[   77.185192] b'[c00000003e8c7d90] [c000000000009f7c] return_to_handler+0x0/0x58 (tcp_sendmsg+0xa54/0xce0)'
[   77.185262] b'[c00000003e8c7de0] [c000000000009f7c] return_to_handler+0x0/0x58 (inet_sendmsg+0xd8/0x100)'
[   77.185342] b'[c00000003e8c7e30] [c000000000009f7c] return_to_handler+0x0/0x58 (sock_sendmsg+0x38/0x60)'
[   77.185416] b'Instruction dump:'
[   77.185469] b'60000000 4bfe3b89 60000000 e8610020 38210030 e8010010 7c0803a6 4bffff40 '
[   77.185566] b'60420000 3c4c00fa 3842e750 3d220015 <88695e30> 4e800020 60000000 60000000 '
[   77.185668] b'---[ end trace 78e882547ec0a563 ]---'
[   79.191159] b'Kernel panic - not syncing: Fatal exception in interrupt'

Warm Regards,
Balbir Singh.
