Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.orange.fr (smtp2.orange.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id 6480667B54
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2006 02:32:27 +1000 (EST)
Received: from smtp-msa-out02.orange.fr (mwinf0207 [172.22.133.37])
	by mwinf0205.orange.fr (SMTP Server) with ESMTP id 5EB391401372
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 18:13:34 +0200 (CEST)
Received: from pegasos (LAubervilliers-151-12-84-108.w193-252.abo.wanadoo.fr
	[193.252.63.108])
	by mwinf0207.orange.fr (SMTP Server) with ESMTP id EBD021C0011E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 18:13:30 +0200 (CEST)
Received: from sven by pegasos with local (Exim 4.50) id 1G6Uvg-0003FX-N1
	for linuxppc-dev@ozlabs.org; Fri, 28 Jul 2006 18:11:12 +0200
Date: Fri, 28 Jul 2006 18:11:07 +0200
To: linuxppc-dev@ozlabs.org
Subject: scheduler death with 2.6.17 on JS21 blades when running stress -c
	32750 ...
Message-ID: <20060728161107.GA12457@powerlinux.fr>
References: <20060728160943.GA12080@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060728160943.GA12080@powerlinux.fr>
From: Sven Luther <sven.luther@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, ...

It was reported to me that, when using the debian 2.6.17 kernel on a JS21
blade (with 1 or 2 970MP cpus), and running stress -c 32750 on it, the blade
dies with some fork ressource problems (don't have the exact message, but it
loops all over the screen), and the blade is completely hosed, and even not
resetable (you have to off/on it).

The kern.log after reboot shows :

Jul 25 11:50:24 debian3 kernel: BUG: soft lockup detected on CPU#0!
Jul 25 11:50:24 debian3 kernel: NIP: C0000000002AE334 LR: C0000000002AE2E0 CTR: C00000000000D7AC
Jul 25 11:50:24 debian3 kernel: REGS: c0000000003479b0 TRAP: 0901   Not tainted  (2.6.15-1-powerpc64)
Jul 25 11:50:24 debian3 kernel: MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000082  XER: 00000010
Jul 25 11:50:24 debian3 kernel: TASK = c00000000037cea0[0] 'swapper' THREAD: c000000000344000 CPU: 0
Jul 25 11:50:24 debian3 kernel: GPR00: 8000000000009032 C000000000347C30 C00000000042BCB8 C00000009EC10980 
Jul 25 11:50:24 debian3 kernel: GPR04: C00000000037D1A0 0000000000000002 0000000024000082 C000000000022034 
Jul 25 11:50:24 debian3 kernel: GPR08: C00000000033F860 C000000004E93760 0000000000000000 0000000004B53F00 
Jul 25 11:50:24 debian3 kernel: GPR12: FFFFFFFFFFFFFFFF C000000000366C00 
Jul 25 11:50:24 debian3 kernel: NIP [C0000000002AE334] .schedule+0xcac/0xdac
Jul 25 11:50:24 debian3 kernel: LR [C0000000002AE2E0] .schedule+0xc58/0xdac
Jul 25 11:50:24 debian3 kernel: Call Trace:
Jul 25 11:50:24 debian3 kernel: [C000000000347C30] [C0000000002AE2E0] .schedule+0xc58/0xdac (unreliable)
Jul 25 11:50:24 debian3 kernel: [C000000000347D40] [C00000000003CD4C] .pseries_dedicated_idle+0x1d8/0x1e0
Jul 25 11:50:24 debian3 kernel: [C000000000347DF0] [C00000000001C5C4] .cpu_idle+0x40/0x54
Jul 25 11:50:24 debian3 kernel: [C000000000347E60] [C0000000000091F4] .rest_init+0x44/0x5c
Jul 25 11:50:24 debian3 kernel: [C000000000347EE0] [C00000000030D868] .start_kernel+0x2e0/0x308
Jul 25 11:50:24 debian3 kernel: [C000000000347F90] [C0000000000084F4] .hmt_init+0x0/0xc
Jul 25 11:50:24 debian3 kernel: Instruction dump:
Jul 25 11:50:24 debian3 kernel: 7d285a14 e8690060 f9490060 60000000 60000000 60000000 ebbf0018 7c2004ac 
Jul 25 11:50:24 debian3 kernel: 7d48592e 7c0000a6 60008000 7c010164 <2fa30000> 419e0030 3803004c 7c0006ac 

(Mmm, the log is from a 2.6.15 kernel, which was in debian testing, but a
similar problem happens with the 2.6.17 debian kernel, which as far as 64bit
powerpc is concerned is mostly mainline).

Did anyone alredy encounter this problem and has any hint on how to fix it ? I
cannot reproduce it on my powerbook, nor on a single G5 powermac, nor on
power5 machines (p505 and a quad cpu openpower), and i don't have hand-on
access to JS21 blades myself.

Friendly,

Sven Luther
