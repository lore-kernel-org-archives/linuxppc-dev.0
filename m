Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B3CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 03:55:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928122054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 03:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJm1SAOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928122054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lDxl38KjzF2Dw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 14:55:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJm1SAOf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out3-smtp.messagingengine.com (client-ip=66.111.4.27;
 helo=out3-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="jJm1SAOf"; dkim-atps=neutral
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lDvF0T2SzDrNT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 14:52:55 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 6204F22167;
 Tue, 30 Oct 2018 23:52:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 30 Oct 2018 23:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=HuXb3ZETaNnu7DroutzC7ZxNk8RBCgljtuNYK8NfJ
 gw=; b=jJm1SAOfu3r31ZduulCl2m2tQ9+N5h61uBIp4ZH3fVK0C53dWH+CP4n3n
 9uSt+qvHE6c15JFlbujxpwZ2iZuBYNnjW8pvQA6FbTrlw/LBh86AHtRGlfrrO9BB
 H95zMgRGds0CL6XCu4r2chmHpbtRNDaw1zbvJBCVvsEapiLuNX9U2872nrqSGa83
 6yaCj0IFKnmho+assOlgMvNAcC0YKHRWOWL4QPcFvcx6PLRk47k9yPMdyrz1ldET
 m+on3Nehrmlv+bcKD7tv04ERZhrfVUdB6D+dyv2RAtCE0XnPkgKWq1TkRaw2pN17
 TY53ZEEDysfN3u6wuRjnZ0AmovrqQ==
X-ME-Sender: <xms:EifZW7-uFioFYPuWqid-FzjdFdKIaQOQUQDajCDr8O7QDBEs5FYJxg>
X-ME-Proxy: <xmx:EifZW7D5wm00jxq96P3YPi4DYW0GgMgnQCac6RFm7DDIYNsgfElhoQ>
 <xmx:EifZW_V9uI9cCIlU3UKXKgu7ziL2uP2L1LwCpUL5JF3PqkkYi411Ng>
 <xmx:EifZWxD11DPqJBZmNrKVOWw3WUQyyo-Diyr3v70tIvFu4kE3IwMePw>
 <xmx:EifZW68FL38yMQ7POq2k5-a9NiVKtba_O2ITsbcehSwY8skzcgG6VA>
 <xmx:EifZWwG5X-259v5KUPU51Nc3W-8oRaq7xdm9L0CpApDXtQMLpH7kfQ>
 <xmx:FCfZW1P2q6yQ_gfeed2r825_kp7eT6HPf3iqwDQm3rO2KKLuGAUcvQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id E6E39102EA;
 Tue, 30 Oct 2018 23:52:48 -0400 (EDT)
Message-ID: <0e66ee72293811f580bd02ab4ed7967a4b703d70.camel@russell.cc>
Subject: Re: [PATCH 0/5] Guarded Userspace Access Prevention on Radix
From: Russell Currey <ruscur@russell.cc>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Date: Wed, 31 Oct 2018 14:53:00 +1100
In-Reply-To: <20181026182916.Horde.8LHYJj4tB_PV5JLEA5Czjw1@messagerie.si.c-s.fr>
References: <20181026182916.Horde.8LHYJj4tB_PV5JLEA5Czjw1@messagerie.si.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-10-26 at 18:29 +0200, LEROY Christophe wrote:
> Russell Currey <ruscur@russell.cc> a écrit :
> 
> > Guarded Userspace Access Prevention is a security mechanism that
> > prevents
> > the kernel from being able to read and write userspace addresses
> > outside of
> > the allowed paths, most commonly copy_{to/from}_user().
> > 
> > At present, the only CPU that supports this is POWER9, and only
> > while using
> > the Radix MMU.  Privileged reads and writes cannot access user data
> > when
> > key 0 of the AMR is set.  This is described in the "Radix Tree
> > Translation
> > Storage Protection" section of the POWER ISA as of version 3.0.
> 
> It is not right that only power9 can support that.

It's true that not only P9 can support it, but there are more
considerations under hash than radix, implementing this for radix is a
first step.

> 
> The 8xx has mmu access protection registers which can serve the
> same  
> purpose. Today on the 8xx kernel space is group 0 and user space is  
> group 1. Group 0 is set to "page defined access permission" in
> MD_AP  
> and MI_AP registers, and group 1 is set to "all accesses done with  
> supervisor rights". By setting group 1 to "user and supervisor  
> interpretation swapped" we can forbid kernel access to user space  
> while still allowing user access to it. Then by simply changing
> group  
> 1 mode at dedicated places we can lock/unlock kernel access to user  
> space.
> 
> Could you implement something as generic as possible having that in  
> mind for a future patch ?

I don't think anything in this series is particularly problematic in
relation to future work for hash.  I am interested in doing a hash
implementation in future too.

- Russell

> 
> Christophe
> 
> > GUAP code sets key 0 of the AMR (thus disabling accesses of user
> > data)
> > early during boot, and only ever "unlocks" access prior to certain
> > operations, like copy_{to/from}_user(), futex ops, etc.  Setting
> > this does
> > not prevent unprivileged access, so userspace can operate fine
> > while access
> > is locked.
> > 
> > There is a performance impact, although I don't consider it
> > heavy.  Running
> > a worst-case benchmark of a 1GB copy 1 byte at a time (and thus
> > constant
> > read(1) write(1) syscalls), I found enabling GUAP to be 3.5% slower
> > than
> > when disabled.  In most cases, the difference is negligible.  The
> > main
> > performance impact is the mtspr instruction, which is quite slow.
> > 
> > There are a few caveats with this series that could be improved
> > upon in
> > future.  Right now there is no saving and restoring of the AMR
> > value -
> > there is no userspace exploitation of the AMR on Radix in POWER9,
> > but if
> > this were to change in future, saving and restoring the value would
> > be
> > necessary.
> > 
> > No attempt to optimise cases of repeated calls - for example, if
> > some
> > code was repeatedly calling copy_to_user() for small sizes very
> > frequently,
> > it would be slower than the equivalent of wrapping that code in an
> > unlock
> > and lock and only having to modify the AMR once.
> > 
> > There are some interesting cases that I've attempted to handle,
> > such as if
> > the AMR is unlocked (i.e. because a copy_{to_from}_user is in
> > progress)...
> > 
> >     - and an exception is taken, the kernel would then be running
> > with the
> >     AMR unlocked and freely able to access userspace again.  I am
> > working
> >     around this by storing a flag in the PACA to indicate if the
> > AMR is
> >     unlocked (to save a costly SPR read), and if so, locking the
> > AMR in
> >     the exception entry path and unlocking it on the way out.
> > 
> >     - and gets context switched out, goes into a path that locks
> > the AMR,
> >     then context switches back, access will be disabled and will
> > fault.
> >     As a result, I context switch the AMR between tasks as if it
> > was used
> >     by userspace like hash (which already implements this).
> > 
> > Another consideration is use of the isync instruction.  Without an
> > isync
> > following the mtspr instruction, there is no guarantee that the
> > change
> > takes effect.  The issue is that isync is very slow, and so I tried
> > to
> > avoid them wherever necessary.  In this series, the only place an
> > isync
> > gets used is after *unlocking* the AMR, because if an access takes
> > place
> > and access is still prevented, the kernel will fault.
> > 
> > On the flipside, a slight delay in unlocking caused by skipping an
> > isync
> > potentially allows a small window of vulnerability.  It is my
> > opinion
> > that this window is practically impossible to exploit, but if
> > someone
> > thinks otherwise, please do share.
> > 
> > This series is my first attempt at POWER assembly so all feedback
> > is very
> > welcome.
> > 
> > The official theme song of this series can be found here:
> >     https://www.youtube.com/watch?v=QjTrnKAcYjE
> > 
> > Russell Currey (5):
> >   powerpc/64s: Guarded Userspace Access Prevention
> >   powerpc/futex: GUAP support for futex ops
> >   powerpc/lib: checksum GUAP support
> >   powerpc/64s: Disable GUAP with nosmap option
> >   powerpc/64s: Document that PPC supports nosmap
> > 
> >  .../admin-guide/kernel-parameters.txt         |  2 +-
> >  arch/powerpc/include/asm/exception-64e.h      |  3 +
> >  arch/powerpc/include/asm/exception-64s.h      | 19 ++++++-
> >  arch/powerpc/include/asm/futex.h              |  6 ++
> >  arch/powerpc/include/asm/mmu.h                |  7 +++
> >  arch/powerpc/include/asm/paca.h               |  3 +
> >  arch/powerpc/include/asm/reg.h                |  1 +
> >  arch/powerpc/include/asm/uaccess.h            | 57
> > ++++++++++++++++---
> >  arch/powerpc/kernel/asm-offsets.c             |  1 +
> >  arch/powerpc/kernel/dt_cpu_ftrs.c             |  4 ++
> >  arch/powerpc/kernel/entry_64.S                | 17 +++++-
> >  arch/powerpc/lib/checksum_wrappers.c          |  6 +-
> >  arch/powerpc/mm/fault.c                       |  9 +++
> >  arch/powerpc/mm/init_64.c                     | 15 +++++
> >  arch/powerpc/mm/pgtable-radix.c               |  2 +
> >  arch/powerpc/mm/pkeys.c                       |  7 ++-
> >  arch/powerpc/platforms/Kconfig.cputype        | 15 +++++
> >  17 files changed, 158 insertions(+), 16 deletions(-)
> > 
> > --
> > 2.19.1
> 
> 

