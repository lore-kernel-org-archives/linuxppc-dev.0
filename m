Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 515F667A00
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 18:03:02 +1000 (EST)
Date: Thu, 18 May 2006 10:03:01 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: mm/rmap.c incompatible with ppc/kernel/dma-mapping.c?
Message-ID: <32470.1147939381@www074.gmx.net>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Since I managed to compile in not cache coherent DMA support in the AmigaOne
Linux kernel, the system crashes whenever I try to view a movie for example
in totem or VLC. The following log snipped is the only debug information I
could extract, because most of the time the system hard locks  and can only
be reactivated with a hardware reset.

May 12 00:04:17 localhost kernel: kernel BUG in page_add_file_rmap at
mm/rmap.c:387!
May 12 00:04:17 localhost kernel: Oops: Exception in kernel mode, sig: 5
[#1]
May 12 00:04:17 localhost kernel: NIP: C004968C LR: C0044CB8 SP: D2C77E20
REGS: d2c77d70 TRAP: 0700    Not tainted
May 12 00:04:17 localhost kernel: MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
May 12 00:04:17 localhost kernel: TASK = d4918000[2900] 'totem' THREAD:
d2c76000Last syscall: 246
May 12 00:04:17 localhost kernel: GPR00: 00000001 D2C77E20 D4918000 C0D02720
00000000 D27B02A0 02000000 D4FE4400
May 12 00:04:17 localhost kernel: GPR08: C03D0000 38139785 00000000 38139785
24048444 10054698 00000000 10171158
May 12 00:04:17 localhost kernel: GPR16: 00000000 00000000 0EADDD7C 00015F90
000001F6 315B1970 33CA8000 D4D6BBA0
May 12 00:04:17 localhost kernel: GPR24: 00000000 00000000 02000000 D4B7D33C
33CA8000 C0D02720 38139785 D2888220
May 12 00:04:17 localhost kernel: NIP [c004968c] page_add_file_rmap+0x8/0x78
May 12 00:04:17 localhost kernel: LR [c0044cb8] do_no_page+0x1cc/0x37c
May 12 00:04:17 localhost kernel: Call trace:
May 12 00:04:17 localhost kernel:  [c004503c] handle_mm_fault+0xf4/0x174
May 12 00:04:17 localhost kernel:  [c0012100] do_page_fault+0x140/0x398
May 12 00:04:17 localhost kernel:  [c0008178] handle_page_fault+0xc/0x80

I tested this with kernel 2.6.8 and 2.6.14.2. Both show the same behavior.
Is this a known problem on PPC systems with desktop CPUs? What about others 
PPC boards that have 6xx/7xxx cpus and not cache coherent northbridges?

Thanks in advance!

regards,

Gerhard

-- 
Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
