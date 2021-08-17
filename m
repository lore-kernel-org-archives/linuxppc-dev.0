Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD67C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 18:06:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFF56023E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 18:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EFF56023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpzW63WxQz3cG0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 04:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GpzVc1Ctnz308Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 04:06:15 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17HI3p37025443;
 Tue, 17 Aug 2021 13:03:51 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 17HI3o06025440;
 Tue, 17 Aug 2021 13:03:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 17 Aug 2021 13:03:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix random crashes by adding isync() after
 locking/unlocking KUEP
Message-ID: <20210817180350.GH1583@gate.crashing.org>
References: <1d28441dd80845e6428d693c0724cb6457247466.1629211378.git.christophe.leroy@csgroup.eu>
 <20210817162239.GF1583@gate.crashing.org>
 <0426a0d3-bdc6-1a34-1018-71b34282a6c6@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0426a0d3-bdc6-1a34-1018-71b34282a6c6@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: userm57@yahoo.com, fthain@linux-m68k.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Tue, Aug 17, 2021 at 07:13:44PM +0200, Christophe Leroy wrote:
> Le 17/08/2021 à 18:22, Segher Boessenkool a écrit :
> >On Tue, Aug 17, 2021 at 02:43:15PM +0000, Christophe Leroy wrote:
> >>Commit b5efec00b671 ("powerpc/32s: Move KUEP locking/unlocking in C")
> >>removed the 'isync' instruction after adding/removing NX bit in user
> >>segments. The reasoning behind this change was that when setting the
> >>NX bit we don't mind it taking effect with delay as the kernel never
> >>executes text from userspace, and when clearing the NX bit this is
> >>to return to userspace and then the 'rfi' should synchronise the
> >>context.
> >>
> >>However, it looks like on book3s/32 having a hash page table, at least
> >>on the G3 processor, we get an unexpected fault from userspace, then
> >>this is followed by something wrong in the verification of MSR_PR
> >>at end of another interrupt.
> >>
> >>This is fixed by adding back the removed isync() following update
> >>of NX bit in user segment registers. Only do it for cores with an
> >>hash table, as 603 cores don't exhibit that problem and the two isync
> >>increase ./null_syscall selftest by 6 cycles on an MPC 832x.
> >>
> >>First problem: unexpected PROTFAULT
> >>
> >>	[   62.896426] WARNING: CPU: 0 PID: 1660 at 
> >>	arch/powerpc/mm/fault.c:354 do_page_fault+0x6c/0x5b0
> >>	[   62.918111] Modules linked in:
> >>	[   62.923350] CPU: 0 PID: 1660 Comm: Xorg Not tainted 
> >>	5.13.0-pmac-00028-gb3c15b60339a #40
> >>	[   62.943476] NIP:  c001b5c8 LR: c001b6f8 CTR: 00000000
> >>	[   62.954714] REGS: e2d09e40 TRAP: 0700   Not tainted  
> >>	(5.13.0-pmac-00028-gb3c15b60339a)
> >
> >That is not a protection fault.  What causes this?
> 
> That's the WARN_ON(error_code & DSISR_PROTFAULT) at
> 
> https://elixir.bootlin.com/linux/v5.13/source/arch/powerpc/mm/fault.c#L354

Ah okay.  How confusing :-/

> >A CSI (like isync) is required both before and after mtsr.  It may work
> >on some cores without -- what part of that is luck, if there is anything
> >that guarantees it, is anyone's guess :-/
> 
> kuep_lock() is called when entering interrupts, it means we recently got an 
> 'rfi' to re-enable MMU.
> kuep_unlock() is called when exit interrupts, it means we are soon going to 
> call 'rfi' to go back to user.
> 
> In between, nobody is going to exec any userspace code, so who minds that 
> the 'mtsr' changing user segments is not completely finished ?

Hey, that is my question!  :-)

So why does this not work on 750 then?

> >>@@ -28,6 +30,8 @@ static inline void kuep_lock(void)
> >>  		return;
> >>  
> >>  	update_user_segments(mfsr(0) | SR_NX);
> >>+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
> >>+		isync();	/* Context sync required after mtsr() */
> >>  }
> >
> >This needs a comment why you are not doing this for systems without
> >hardware page table walk, at the least?
> 
> Ok, will add a comment tomorrow.

Thanks!


Segher
