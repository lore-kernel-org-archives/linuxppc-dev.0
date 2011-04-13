Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53351B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 00:44:15 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: FTrace on MPC8xx
Date: Wed, 13 Apr 2011 16:32:21 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104131632.21350.ml@stefan-roese.de>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I noticed that ftrace doesn't seem to work on MPC8xx. I'm trying to use it on 
an MPC855T board, but ftrace oopses upon startup:

[    0.028785] ftrace: allocating 10312 entries in 31 pages
[    0.038594] ------------[ cut here ]------------
[    0.038760] WARNING: at kernel/trace/ftrace.c:1014
[    0.038889] Modules linked in:
[    0.039062] NIP: c00666a0 LR: c006782c CTR: 00000001
[    0.039249] REGS: c0381e60 TRAP: 0700   Not tainted  (2.6.38-default+)
[    0.039417] MSR: 00021032 <ME,CE,IR,DR>  CR: 53009393  XER: a000af7f
[    0.039856] TASK = c0360500[0] 'swapper' THREAD: c0380000
[    0.040001] GPR00: 00000001 c0381f10 c0360500 ffffffff c02962c8 00000000 
c02962c4 00000000 
[    0.040487] GPR08: 1de1a3e3 00000000 000258e3 c0381f40 93009399 10091a60 
03fff800 0040055c 
[    0.040977] GPR16: 00000001 00000001 ffffffff 007fff00 03ff9fb0 00000000 
00000000 c0384080 
[    0.041459] GPR24: c000f234 00000000 024acd00 00009032 c02962c8 c384553c 
c02962c8 c0381f10 
[    0.042054] NIP [c00666a0] ftrace_bug+0x13c/0x1c4
[    0.042268] LR [c006782c] ftrace_process_locs+0x1b4/0x2b0
[    0.042405] Call Trace:
[    0.042592] [c0381f10] [c006fce8] ftrace_now+0x30/0x78 (unreliable)
[    0.042889] [c0381f40] [c006782c] ftrace_process_locs+0x1b4/0x2b0
[    0.043182] [c0381f70] [c0339944] ftrace_init+0x1e8/0x21c
[    0.043443] [c0381fb0] [c0333964] start_kernel+0x284/0x2a0
[    0.043704] [c0381ff0] [c0002224] start_here+0x44/0xa8
[    0.043869] Instruction dump:
[    0.044013] 2f9e0003 7f1ed800 3bbd0001 7f44d378 409dffc8 3c60c02f 3863101c 
4bfbbbb9 
[    0.044508] 48000080 3d20c04b 8929bc82 69200001 <0f000000> 2f890000 
40be0010 38000001 
[    0.045206] ---[ end trace 31fd0ba7d8756001 ]---
[    0.045349] ftrace faulted on writing [<c02962c8>] dns_query+0x8/0x278
...


This is on a 2.6.38 kernel (2.6.32 fails too). Debugging shows that 
__copy_tofrom_user() fails with return code 4 (called via 
ftrace_modify_code()).

Before digging deeper: Has anybody tried/tested ftrace on MPC8xx? Any ideas 
what going wrong here?

Thanks.

Best regards,
Stefan
