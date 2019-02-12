Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E50C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 00:22:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D991720863
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 00:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D991720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z3JK69VYzDqLP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z3Df1bQ5zDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 11:19:13 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1C0Inhn000550;
 Mon, 11 Feb 2019 18:18:52 -0600
Message-ID: <5fa785bd8552e33e637a26a3d06c4ed8c3da4532.camel@kernel.crashing.org>
Subject: Re: [QUESTION] powerpc, libseccomp, and spu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Hromatka <tom.hromatka@oracle.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Feb 2019 11:18:49 +1100
In-Reply-To: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
References: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Paul Moore <paul@paul-moore.com>, Dhaval Giani <dhaval.giani@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-02-11 at 11:54 -0700, Tom Hromatka wrote:
> PowerPC experts,
> 
> Paul Moore and I are working on the v2.4 release of libseccomp,
> and as part of this work I need to update the syscall table for
> each architecture.
> 
> I have incorporated the new ppc syscall.tbl into libseccomp, but
> I am not familiar with the value of "spu" in the ABI column.  For
> example:
> 
> 22	32	umount				sys_oldumount
> 22	64	umount				sys_ni_syscall
> 22	spu	umount				sys_ni_syscall
> 
> In libseccomp, we maintain a 32-bit ppc syscall table and a 64-bit
> ppc syscall table.  Do we also need to add a "spu" ppc syscall
> table?  Some clarification on the syscalls marked "spu" and "nospu"
> would be greatly appreciated.

On the Cell processor, there is a number of little co-processors (SPUs)
that run alongside the main PowerPC core. Userspace can run code on
them, they operate within the user context via their own MMUs. We
provide a facility for them to issue syscalls (via some kind of RPC to
the main core). The "SPU" indication indicates syscalls that can be
called from the SPUs via that mechanism.

Now, the big question is, anybody still using Cell ? :-)

Cheers,
Ben.


