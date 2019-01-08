Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0239C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:59:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AF62087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQ2L/56S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AF62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ynm81NZdzDqSJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:59:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="mQ2L/56S"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ynk96HC7zDqND
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:57:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 2AF1B1372;
 Tue,  8 Jan 2019 04:57:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 08 Jan 2019 04:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=8NgReACofGr4pfsVek1KnbG548/6VAg+JiRF3ljMJ
 ik=; b=mQ2L/56S+ov7BImttVK3klS4q7x3z3cfmxwjxB0oew76lugkXWSKxd301
 jhx3z2uBMhRyc8VYpUDl8I39v1dxiQPBESWlGKwvypRH80sXLpShjyi63ZTzokHW
 LplagP37FIZU/ZEJ4OhaIYWmNQruEFc3w8fbouwPTSfrpLe46VX2kakNC4FKQakq
 iNWvA0FHQajxJ/z2MO8Nks3KEe+mwoHGpfEWx1bH+WqpbXf/WhStegRE+7/5fZzp
 kFk6G4tHvFV+6A9vrU0Q7mM0mEneEI1N6wlZ5FRHH1+hhnbbqCPgm2vtpRlBrLYE
 Aos5x9n7zVOj3rybFGBe/lfyS6ygg==
X-ME-Sender: <xms:C3Q0XASfp-usMgrhx_WGTdAASULcT52_PDPMj5Fo5PtBuvuMl_ECAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrvdelgddtkeculddtuddrgedtkedrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucfkphepuddrudehjedrudelgedrudelkeenucfrrghrrghmpehm
 rghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghruf
 hiiigvpedt
X-ME-Proxy: <xmx:C3Q0XItAmkhGC32P9BWVvKIneWF6ItIwYel34OmCDto9z5E3EZL4ZA>
 <xmx:C3Q0XMwtlGuiBWJ69siaYGiWEGUWPUgN2c3UVCsJdfccTkUe1TVg5g>
 <xmx:C3Q0XIeE_OlUJVYyCa7EKe58lk3mF1GDyaHRfsuAJ2GitCHWzkknFw>
 <xmx:DHQ0XF5G1WQhdoXRMjmaqMlPrnpqCbb8ql3OuJNf52dmuGpWNujTRA>
Received: from crackle.ozlabs.ibm.com (unknown [1.157.194.198])
 by mail.messagingengine.com (Postfix) with ESMTPA id BFF3D10087;
 Tue,  8 Jan 2019 04:57:27 -0500 (EST)
Message-ID: <9c1097982d424c0c96459899e36f7f4c9345be73.camel@russell.cc>
Subject: Re: [PATCH v2 2/2] powerpc: use probe_user_read()
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Tue, 08 Jan 2019 20:58:37 +1100
In-Reply-To: <293a653c-52aa-6326-4022-73fb25590354@c-s.fr>
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <e939991366b784ef13c7afcab51749e3b46327ac.1546932949.git.christophe.leroy@c-s.fr>
 <293a653c-52aa-6326-4022-73fb25590354@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-01-08 at 10:37 +0100, Christophe Leroy wrote:
> Hi Michael and Russell,
> 
> Any idea why:
> - checkpatch reports missing Signed-off-by:
> - Snowpatch build fails on PPC64 (it seems unrelated to the patch, 
> something wrong in lib/genalloc.c)

Upstream kernel broke for powerpc (snowpatch applies patches on top of
powerpc/next), it was fixed in commit
35004f2e55807a1a1491db24ab512dd2f770a130 which I believe is in
powerpc/next now.  I will look at rerunning tests for all the patches
that this impacted.

As for the S-o-b, no clue, I'll have a look.  Thanks for the report!

- Russell

> 
> Thanks
> Christophe
> 
> Le 08/01/2019 à 08:37, Christophe Leroy a écrit :
> > Instead of opencoding, use probe_user_read() to failessly
> > read a user location.
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >   v2: Using probe_user_read() instead of probe_user_address()
> > 
> >   arch/powerpc/kernel/process.c   | 12 +-----------
> >   arch/powerpc/mm/fault.c         |  6 +-----
> >   arch/powerpc/perf/callchain.c   | 20 +++-----------------
> >   arch/powerpc/perf/core-book3s.c |  8 +-------
> >   arch/powerpc/sysdev/fsl_pci.c   | 10 ++++------
> >   5 files changed, 10 insertions(+), 46 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/process.c
> > b/arch/powerpc/kernel/process.c
> > index ce393df243aa..6a4b59d574c2 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1298,16 +1298,6 @@ void show_user_instructions(struct pt_regs
> > *regs)
> >   
> >   	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
> >   
> > -	/*
> > -	 * Make sure the NIP points at userspace, not kernel text/data
> > or
> > -	 * elsewhere.
> > -	 */
> > -	if (!__access_ok(pc, NR_INSN_TO_PRINT * sizeof(int), USER_DS))
> > {
> > -		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
> > -			current->comm, current->pid);
> > -		return;
> > -	}
> > -
> >   	seq_buf_init(&s, buf, sizeof(buf));
> >   
> >   	while (n) {
> > @@ -1318,7 +1308,7 @@ void show_user_instructions(struct pt_regs
> > *regs)
> >   		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
> >   			int instr;
> >   
> > -			if (probe_kernel_address((const void *)pc,
> > instr)) {
> > +			if (probe_user_read(&instr, (void __user *)pc,
> > sizeof(instr))) {
> >   				seq_buf_printf(&s, "XXXXXXXX ");
> >   				continue;
> >   			}
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 887f11bcf330..ec74305fa330 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -276,12 +276,8 @@ static bool bad_stack_expansion(struct pt_regs
> > *regs, unsigned long address,
> >   		if ((flags & FAULT_FLAG_WRITE) && (flags &
> > FAULT_FLAG_USER) &&
> >   		    access_ok(nip, sizeof(*nip))) {
> >   			unsigned int inst;
> > -			int res;
> >   
> > -			pagefault_disable();
> > -			res = __get_user_inatomic(inst, nip);
> > -			pagefault_enable();
> > -			if (!res)
> > +			if (!probe_user_read(&inst, nip, sizeof(inst)))
> >   				return !store_updates_sp(inst);
> >   			*must_retry = true;
> >   		}
> > diff --git a/arch/powerpc/perf/callchain.c
> > b/arch/powerpc/perf/callchain.c
> > index 0af051a1974e..0680efb2237b 100644
> > --- a/arch/powerpc/perf/callchain.c
> > +++ b/arch/powerpc/perf/callchain.c
> > @@ -159,12 +159,8 @@ static int read_user_stack_64(unsigned long
> > __user *ptr, unsigned long *ret)
> >   	    ((unsigned long)ptr & 7))
> >   		return -EFAULT;
> >   
> > -	pagefault_disable();
> > -	if (!__get_user_inatomic(*ret, ptr)) {
> > -		pagefault_enable();
> > +	if (!probe_user_read(ret, ptr, sizeof(*ret)))
> >   		return 0;
> > -	}
> > -	pagefault_enable();
> >   
> >   	return read_user_stack_slow(ptr, ret, 8);
> >   }
> > @@ -175,12 +171,8 @@ static int read_user_stack_32(unsigned int
> > __user *ptr, unsigned int *ret)
> >   	    ((unsigned long)ptr & 3))
> >   		return -EFAULT;
> >   
> > -	pagefault_disable();
> > -	if (!__get_user_inatomic(*ret, ptr)) {
> > -		pagefault_enable();
> > +	if (!probe_user_read(ret, ptr, sizeof(*ret)))
> >   		return 0;
> > -	}
> > -	pagefault_enable();
> >   
> >   	return read_user_stack_slow(ptr, ret, 4);
> >   }
> > @@ -307,17 +299,11 @@ static inline int current_is_64bit(void)
> >    */
> >   static int read_user_stack_32(unsigned int __user *ptr, unsigned
> > int *ret)
> >   {
> > -	int rc;
> > -
> >   	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> >   	    ((unsigned long)ptr & 3))
> >   		return -EFAULT;
> >   
> > -	pagefault_disable();
> > -	rc = __get_user_inatomic(*ret, ptr);
> > -	pagefault_enable();
> > -
> > -	return rc;
> > +	return probe_user_read(ret, ptr, sizeof(*ret));
> >   }
> >   
> >   static inline void perf_callchain_user_64(struct
> > perf_callchain_entry_ctx *entry,
> > diff --git a/arch/powerpc/perf/core-book3s.c
> > b/arch/powerpc/perf/core-book3s.c
> > index b0723002a396..4b64ddf0db68 100644
> > --- a/arch/powerpc/perf/core-book3s.c
> > +++ b/arch/powerpc/perf/core-book3s.c
> > @@ -416,7 +416,6 @@ static void power_pmu_sched_task(struct
> > perf_event_context *ctx, bool sched_in)
> >   static __u64 power_pmu_bhrb_to(u64 addr)
> >   {
> >   	unsigned int instr;
> > -	int ret;
> >   	__u64 target;
> >   
> >   	if (is_kernel_addr(addr)) {
> > @@ -427,13 +426,8 @@ static __u64 power_pmu_bhrb_to(u64 addr)
> >   	}
> >   
> >   	/* Userspace: need copy instruction here then translate it */
> > -	pagefault_disable();
> > -	ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
> > -	if (ret) {
> > -		pagefault_enable();
> > +	if (probe_user_read(&instr, (unsigned int __user *)addr,
> > sizeof(instr)))
> >   		return 0;
> > -	}
> > -	pagefault_enable();
> >   
> >   	target = branch_target(&instr);
> >   	if ((!target) || (instr & BRANCH_ABSOLUTE))
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > b/arch/powerpc/sysdev/fsl_pci.c
> > index 918be816b097..c8a1b26489f5 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -1068,13 +1068,11 @@ int fsl_pci_mcheck_exception(struct pt_regs
> > *regs)
> >   	addr += mfspr(SPRN_MCAR);
> >   
> >   	if (is_in_pci_mem_space(addr)) {
> > -		if (user_mode(regs)) {
> > -			pagefault_disable();
> > -			ret = get_user(inst, (__u32 __user *)regs-
> > >nip);
> > -			pagefault_enable();
> > -		} else {
> > +		if (user_mode(regs))
> > +			ret = probe_user_read(&inst, (void __user
> > *)regs->nip,
> > +					      sizeof(inst));
> > +		else
> >   			ret = probe_kernel_address((void *)regs->nip,
> > inst);
> > -		}
> >   
> >   		if (!ret && mcheck_handle_load(regs, inst)) {
> >   			regs->nip += 4;
> > 

