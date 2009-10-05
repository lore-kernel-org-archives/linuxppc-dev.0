Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 90B77B7B77
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 09:04:24 +1100 (EST)
Date: Mon, 5 Oct 2009 15:04:20 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
Message-ID: <20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Joakim Tjernlund (Joakim.Tjernlund@transmode.se):

> Scott and Rex, please disregard other patches from me and
> try these out instead.

I have results similar to Scott's. I tried both with and without patch 
5 & 6, and I also need the tlbia_va in ptep_set_access_flags().

I got this oops:

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000e110
Oops: Kernel access of bad area, sig: 11 [#1]
MRV NM2
NIP: c000e110 LR: c000d520 CTR: 1006bf40
REGS: c2203dd0 TRAP: 0300   Not tainted  (2.6.32-rc3-00014-gcea49b0-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44022422  XER: 20000000
DAR: 00000000, DSISR: c0000000
TASK = c21c18c0[69] 'rc.sysinit' THREAD: c2202000
GPR00: 00000401 c2203e80 c21c18c0 c2203f50 00000000 4000d032 00000000 00000000
GPR08: 10093eb4 00000000 00009032 c000d514 021c1ad0 10095c50 03ffb000 10006500
GPR16: 10006508 00000000 00000000 00000000 100a2fc8 021c4238 00000000 00000400
GPR24: c21a2700 00000002 40000000 00000000 00000000 c2203f50 00000000 00000011
NIP [c000e110] do_page_fault+0x44/0x5fc
LR [c000d520] handle_page_fault+0xc/0x80
Call Trace:
[c2203e80] [c000e58c] do_page_fault+0x4c0/0x5fc (unreliable)
[c2203f40] [c000d520] handle_page_fault+0xc/0x80
Instruction dump:
800300a0 7cba2b78 54170036 2f970400 7c9c2378 830200e0 54b6018c 40be000c
74ba4820 3ac00000 813d0080 3bc00000 <80a90000> 54a036be 2f80001f 40be0100
---[ end trace 99a4d88f7e2f1b60 ]---

this happens in do_page_fault becaose regs->nip is null, so

                insn = *((unsigned long *)regs->nip);
c000e110:       80 a9 00 00     lwz     r5,0(r9)

fails.

take care!
/rex.
