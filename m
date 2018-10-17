Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA69C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 01:01:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E20D214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 01:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E20D214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZYlH0x6wzF3WD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 12:00:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZYjB55xNzF3VM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 11:59:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ZYj94TF9z9s2P;
 Wed, 17 Oct 2018 11:59:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
 "benh\@kernel.crashing.org"  <benh@kernel.crashing.org>
Subject: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3 12/24]
 powerpc/mm: use pte helpers in generic code)
In-Reply-To: <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
Date: Wed, 17 Oct 2018 11:59:09 +1100
Message-ID: <87va61jsma.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Get rid of platform specific _PAGE_XXXX in powerpc common code and
> use helpers instead.
>
> mm/dump_linuxpagetables.c will be handled separately
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  9 +++------
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 12 ++++++++----
>  arch/powerpc/include/asm/nohash/pgtable.h    |  3 +--
>  arch/powerpc/mm/pgtable.c                    | 21 +++++++--------------
>  arch/powerpc/mm/pgtable_32.c                 | 15 ++++++++-------
>  arch/powerpc/mm/pgtable_64.c                 | 14 +++++++-------
>  arch/powerpc/xmon/xmon.c                     | 12 +++++++-----
>  7 files changed, 41 insertions(+), 45 deletions(-)

So turns out this patch *also* breaks my p5020ds :)

Even with patch 4 merged, see next.

It's the same crash:

  pcieport 2000:00:00.0: AER enabled with IRQ 480
  Unable to handle kernel paging request for data at address 0x8000080080080000
  Faulting instruction address: 0xc0000000000192cc
  Oops: Kernel access of bad area, sig: 11 [#1]
  BE SMP NR_CPUS=24 CoreNet Generic
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc3-gcc7x-g98c847323b3a #1
  NIP:  c0000000000192cc LR: c0000000005d0f9c CTR: 0000000000100000
  REGS: c0000000f31bb400 TRAP: 0300   Not tainted  (4.19.0-rc3-gcc7x-g98c847323b3a)
  MSR:  0000000080029000 <CE,EE,ME>  CR: 24000224  XER: 00000000
  DEAR: 8000080080080000 ESR: 0000000000800000 IRQMASK: 0 
  GPR00: c0000000005d0f84 c0000000f31bb688 c00000000117dc00 8000080080080000 
  GPR04: 0000000000000000 0000000000400000 00000ffbff241010 c0000000f31b8000 
  GPR08: 0000000000000000 0000000000100000 0000000000000000 c0000000012d4710 
  GPR12: 0000000084000422 c0000000012ff000 c000000000002774 0000000000000000 
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  GPR24: 0000000000000000 0000000000000000 8000080080080000 c0000000ffff89a8 
  GPR28: c0000000f3576400 c0000000f3576410 0000000000400000 c0000000012ecc98 
  NIP [c0000000000192cc] ._memset_io+0x6c/0x9c
  LR [c0000000005d0f9c] .fsl_qman_probe+0x198/0x928
  Call Trace:
  [c0000000f31bb688] [c0000000005d0f84] .fsl_qman_probe+0x180/0x928 (unreliable)
  [c0000000f31bb728] [c0000000006432ec] .platform_drv_probe+0x60/0xb4
  [c0000000f31bb7a8] [c00000000064083c] .really_probe+0x294/0x35c
  [c0000000f31bb848] [c000000000640d2c] .__driver_attach+0x148/0x14c
  [c0000000f31bb8d8] [c00000000063d7dc] .bus_for_each_dev+0xb0/0x118
  [c0000000f31bb988] [c00000000063ff28] .driver_attach+0x34/0x4c
  [c0000000f31bba08] [c00000000063f648] .bus_add_driver+0x174/0x2bc
  [c0000000f31bbaa8] [c0000000006418bc] .driver_register+0x90/0x180
  [c0000000f31bbb28] [c000000000643270] .__platform_driver_register+0x60/0x7c
  [c0000000f31bbba8] [c000000000ee2a70] .fsl_qman_driver_init+0x24/0x38
  [c0000000f31bbc18] [c0000000000023fc] .do_one_initcall+0x64/0x2b8
  [c0000000f31bbcf8] [c000000000e9f480] .kernel_init_freeable+0x3a8/0x494
  [c0000000f31bbda8] [c000000000002798] .kernel_init+0x24/0x148
  [c0000000f31bbe28] [c0000000000009e8] .ret_from_kernel_thread+0x58/0x70
  Instruction dump:
  4e800020 2ba50003 40dd003c 3925fffc 5488402e 7929f082 7d082378 39290001 
  550a801e 7d2903a6 7d4a4378 794a0020 <91430000> 38630004 4200fff8 70a50003 


Comparing a working vs broken kernel, it seems to boil down to the fact
that we're filtering out more PTE bits now that we use pte_pgprot() in
ioremap_prot().

With the old code we get:
  ioremap_prot: addr 0xff800000 flags 0x241215
  ioremap_prot: addr 0xff800000 flags 0x241215
  map_kernel_page: ea 0x8000080080080000 pa 0xff800000 pte 0xff800241215


And now we get:
  ioremap_prot: addr 0xff800000 flags 0x241215 pte 0x241215
  ioremap_prot: addr 0xff800000 pte 0x241215
  ioremap_prot: addr 0xff800000 prot 0x241014
  map_kernel_page: ea 0x8000080080080000 pa 0xff800000 pte 0xff800241014

So we're losing 0x201, which for nohash book3e is:

  #define _PAGE_PRESENT	0x000001 /* software: pte contains a translation */
  #define _PAGE_PSIZE_4K	0x000200


I haven't worked out if it's one or both of those that matter.

The question is what's the right way to fix it? Should pte_pgprot() not
be filtering those bits out on book3e?

cheers
