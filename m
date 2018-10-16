Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BB6C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:26:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756132086E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756132086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZHg52dMrzF3XB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 01:26:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZHcT459GzF3Sd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 01:24:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42ZHcT2v0Qz8wRV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 01:24:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42ZHcT1ySxz9s8r; Wed, 17 Oct 2018 01:24:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42ZHcS3Z1wz9sCf
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2018 01:24:08 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9GENhXA019393;
 Tue, 16 Oct 2018 09:23:44 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w9GENf9H019392;
 Tue, 16 Oct 2018 09:23:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 16 Oct 2018 09:23:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Stack protector crash in pnv_smp_cpu_kill_self()
Message-ID: <20181016142340.GY29268@gate.crashing.org>
References: <87k1mjz6hd.fsf@concordia.ellerman.id.au>
 <a23f6298-f860-190c-4b45-333198fdc160@c-s.fr>
 <87ftx6kowh.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftx6kowh.fsf@concordia.ellerman.id.au>
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
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 17, 2018 at 12:21:50AM +1100, Michael Ellerman wrote:
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
> > Looks like a lack of initialisation of the canary for the non-boot CPUs 
> > on SMP, you applied this morning the patch I sent you for that.
> >
> > Is the patch in ?
> 
> Yeah it is.
> 
>   $ git log --oneline 4ffe713b7587 arch/powerpc/kernel/smp.c
>   8e8a31d7fd54 powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores
>   425752c63b6f powerpc: Detect the presence of big-cores via "ibm, thread-groups"
>   7241d26e8175 powerpc/64: properly initialise the stackprotector canary on SMP.
> 
> 
> It only happens on a specific Power9 machine, not in sim, but it's 100%
> reproducible on that hardware.
> 
> The canary value has changed (?!).
> 
> The value in paca->canary and current->canary agree, but they don't
> match what's in the stack.
> 
> Clearly the idle code is doing something I don't understand :)

Did something actually corrupt the stack?


Segher
