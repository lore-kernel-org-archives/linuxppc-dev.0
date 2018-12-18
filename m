Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F9C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:08:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F566217D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F566217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K0Hn2RYfzDqTn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 01:08:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K0Dh0bWNzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 01:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43K0Dg4LFBz9s3Z;
 Wed, 19 Dec 2018 01:06:11 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] powerpc: implement CONFIG_DEBUG_VIRTUAL
In-Reply-To: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr>
References: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr>
Date: Wed, 19 Dec 2018 01:06:11 +1100
Message-ID: <87y38nrkto.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch implements CONFIG_DEBUG_VIRTUAL to warn about
> incorrect use of virt_to_phys() and page_to_phys()

This commit is breaking my p5020ds booting a 32-bit kernel with:

  smp: Bringing up secondary CPUs ...
  __ioremap(): phys addr 0x7fef5000 is RAM lr ioremap_coherent
  Unable to handle kernel paging request for data at address 0x00000000
  Faulting instruction address: 0xc002e950
  Oops: Kernel access of bad area, sig: 11 [#1]
  BE SMP NR_CPUS=24 CoreNet Generic
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc2-gcc-7.0.1-00138-g9a0380d299e9 #148
  NIP:  c002e950 LR: c002eb20 CTR: 00000001
  REGS: e804bd20 TRAP: 0300   Not tainted  (4.20.0-rc2-gcc-7.0.1-00138-g9a0380d299e9)
  MSR:  00021002 <CE,ME>  CR: 28004222  XER: 00000000
  DEAR: 00000000 ESR: 00000000 
  GPR00: c002eb20 e804bdd0 e8050000 00000000 00021002 00000000 00000050 00021002 
  GPR08: 2d3f0000 00000001 00000000 00000004 24000842 00000000 c00026d0 00000000 
  GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001 
  GPR24: 00029002 7fef5140 30000000 00000000 00000000 00000040 00000001 00000000 
  NIP [c002e950] smp_85xx_kick_cpu+0x120/0x410
  LR [c002eb20] smp_85xx_kick_cpu+0x2f0/0x410
  Call Trace:
  [e804bdd0] [c002eb20] smp_85xx_kick_cpu+0x2f0/0x410 (unreliable)
  [e804be20] [c0012e38] __cpu_up+0xc8/0x230
  [e804be50] [c0040b34] bringup_cpu+0x34/0x110
  [e804be70] [c00418a8] cpu_up+0x128/0x250
  [e804beb0] [c0b84b14] smp_init+0xc4/0x10c
  [e804bee0] [c0b75c1c] kernel_init_freeable+0xc8/0x250
  [e804bf20] [c00026e8] kernel_init+0x18/0x120
  [e804bf40] [c0011298] ret_from_kernel_thread+0x14/0x1c
  Instruction dump:
  7fb3e850 57bdd1be 2e1d0000 41d20250 57bd3032 393dffc0 7e6a9b78 5529d1be 
  39290001 7d2903a6 60000000 60000000 <7c0050ac> 394a0040 4200fff8 7c0004ac 
  ---[ end trace edcab2a1dfd5b38c ]---


Which is obviously this hunk:

> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 4fc77a99c9bf..68d204a45cd0 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -143,7 +143,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
>  	 * Don't allow anybody to remap normal RAM that we're using.
>  	 * mem_init() sets high_memory so only do the check after that.
>  	 */
> -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
> +	if (slab_is_available() && virt_addr_valid(p) &&
>  	    page_is_ram(__phys_to_pfn(p))) {
>  		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>  		       (unsigned long long)p, __builtin_return_address(0));


I'll try and come up with a fix tomorrow.

cheers

