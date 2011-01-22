Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EACD0B7105
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jan 2011 20:50:29 +1100 (EST)
In-Reply-To: <4D392D4E.2000004@denx.de>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>
	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
	<AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
	<OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>
	<AANLkTi=cAswFh1cFCU=nomd6yg5Ux9jK0x9h9s7f2571@mail.gmail.com>
	<OFCA182CE3.B20BFA9C-ONC1257814.005C7CE1-C1257814.005CF1A7@transmode.se>
	<OF14B8C2B7.A99F8A1E-ONC1257815.0057AC0A-C1257815.0057F664@transmode.se>
	<4D392D4E.2000004@denx.de>
Subject: Re: mpc880 linux-2.6.32 slow running processes
To: hs@denx.de
Message-ID: <OF40ADBA97.2AA0D8C2-ONC1257820.0034862B-C1257820.00360C3A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 22 Jan 2011 10:50:20 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, Rafael Beims <rbeims@gmail.com>,
	scottwood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, michael@evidence.eu.com,
	RFeany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heiko Schocher <hs@denx.de> wrote on 2011/01/21 07:53:02:
> Hello Joakim,
>
> Joakim Tjernlund wrote:
> >> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
> >>
> >> Rafael Beims <rbeims@gmail.com> wrote on 2011/01/10 17:35:38:
> >>>> Once you have tested it and it works, please send a patch to remove the 8xx workaround.
> >>>> Make sure Scott is cc:ed
> >>>>
> >>>>
> >>> I tested linux-2.6.33 on my ppc880 board today, and even without the
> >>> slowdown.patch applied, the board runs processes with good
> >>> performance.
> >>> It really seems that the problem is solved from linux-2.6.33 on.
> >>>
> >>> I'm not sure what you mean by sending a patch to remove the
> >>> workaround. The only thing that I did in the 2.6.32 version was to
> >>> apply the slowdown.patch attached in the message from Michael.
> >>>
> >>> Could you clarify please?
> >> Yes, this part in arch/powerpc/mm/pgtable.c:
> >> #ifdef CONFIG_8xx
> >>          /* On 8xx, cache control instructions (particularly
> >>           * "dcbst" from flush_dcache_icache) fault as write
> >>           * operation if there is an unpopulated TLB entry
> >>           * for the address in question. To workaround that,
> >>           * we invalidate the TLB here, thus avoiding dcbst
> >>           * misbehaviour.
> >>           */
> >>          /* 8xx doesn't care about PID, size or ind args */
> >>          _tlbil_va(addr, 0, 0, 0);
> >> #endif /* CONFIG_8xx */
> >>
> >> Should be removed in >= 2.6.33 kernels.
> >> My 8xx TLB work fixes this problem more efficiently.
> >
> > Can you test these 2 patches on recent 2.6 linux:
> >>From 9024200169bf86b4f34cb3b1ebf68e0056237bc0 Mon Sep 17 00:00:00 2001
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Tue, 11 Jan 2011 13:43:42 +0100
> > Subject: [PATCH 1/2] powerpc: Move 8xx invalidation of non present TLBs
> [...]
> > and
> >
> >>From 0ef93601290a75b087495dddeee6062a870f1dc6 Mon Sep 17 00:00:00 2001
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Tue, 11 Jan 2011 13:55:22 +0100
> > Subject: [PATCH 2/2] powerpc: Remove 8xx redundant dcbst workaround.
>
> Tested this on a board similliar to the mainline tqm8xx board with
> lmbench:
>
> -bash-3.2# cat /proc/cpuinfo
> processor       : 0
> cpu             : 8xx
> clock           : 80.000000MHz
> revision        : 0.0 (pvr 0050 0000)
> bogomips        : 10.00
> timebase        : 5000000
> platform        : KUP4K
> model           : KUP4K
> Memory          : 96 MB
> -bash-3.2#
>
> -bash-3.2# cat /proc/version
> Linux version 2.6.34-00064-g3e81b6b (hs@pollux.denx.de) (gcc version 4.2.2) #89 Thu Jan 20 08:39:52 CET 2011
> -bash-3.2#
>
> (First run of lmbench without your 2 patches, the two other runs with it)

Thanks,

>From a quick look, the only thing that really stands out is Prot Fault below:

> File & VM system latencies in microseconds - smaller is better
> -------------------------------------------------------------------------------
> Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
>                         Create Delete Create Delete Latency Fault  Fault  selct
> --------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
> kup4k     Linux 2.6.34-  16.7K  10.3K  90.9K  13.7K   22.6K  27.1    43.4 117.9
> kup4k     Linux 2.6.34-  16.9K  15.6K 100.0K  16.1K   22.7K 9.590    39.8 119.2
> kup4k     Linux 2.6.34-  16.7K  13.5K 100.0K  15.9K   22.8K 9.306    39.8 119.6

Anyhow, nothing broke so I am happy with the results.

On top of those 2 patches I came up with this cleanup patch too:

>From 920c236b290ee00d84506369e3898126c78215e8 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 18 Jan 2011 09:50:09 +0100
Subject: [PATCH 3/3] powerpc: Use symbolic constants in 8xx TLB asm

Use the PTE #defines where possible instead of
hardcoded constants.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6cd99e2..31ed813 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -451,11 +451,11 @@ DataStoreTLBMiss:
 	 * this into the Linux pgd/pmd and load it in the operation
 	 * above.
 	 */
-	rlwimi	r11, r10, 0, 27, 27
+	rlwimi	r11, r10, 0, _PAGE_GUARDED
 	/* Insert the WriteThru flag into the TWC from the Linux PTE.
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
-	rlwimi	r11, r10, 32-5, 30, 30
+	rlwimi	r11, r10, 32-5, _PAGE_WRITETHRU>>5
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	SPRN_MD_TWC, r11

@@ -474,10 +474,10 @@ DataStoreTLBMiss:
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
 	/* Honour kernel RO, User NA */
-	/* 0x200 == Extended encoding, bit 22 */
-	rlwimi	r10, r10, 32-2, 0x200 /* Copy USER to bit 22, 0x200 */
+	/* 0x200 == Encoding, bit 22 */
+	rlwimi	r10, r10, 32-2, _PAGE_USER>>2  /* Copy USER to Encoding */
 	/* r11 =  (r10 & _PAGE_RW) >> 1 */
-	rlwinm	r11, r10, 32-1, 0x200
+	rlwinm	r11, r10, 32-1, _PAGE_RW>>1
 	or	r10, r11, r10
 	/* invert RW and 0x200 bits */
 	xori	r10, r10, _PAGE_RW | 0x200
--
1.7.3.4
