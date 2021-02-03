Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 21:22:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E1D64F5F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 21:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1D64F5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DWF4c3lc5zDxTp
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 08:22:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DWF2z5S4XzDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2021 08:20:40 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 113LHYGb014316;
 Wed, 3 Feb 2021 15:17:34 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 113LHXCH014310;
 Wed, 3 Feb 2021 15:17:33 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 3 Feb 2021 15:17:33 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/3] powerpc: sstep: Fix load and update emulation
Message-ID: <20210203211732.GD30983@gate.crashing.org>
References: <20210203063841.431063-1-sandipan@linux.ibm.com>
 <20210203094909.GD210@DESKTOP-TDPLP67.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203094909.GD210@DESKTOP-TDPLP67.localdomain>
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
Cc: ravi.bangoria@linux.ibm.com, ananth@linux.ibm.com, jniethe5@gmail.com,
 paulus@samba.org, Sandipan Das <sandipan@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 03, 2021 at 03:19:09PM +0530, Naveen N. Rao wrote:
> On 2021/02/03 12:08PM, Sandipan Das wrote:
> > The Power ISA says that the fixed-point load and update
> > instructions must neither use R0 for the base address (RA)
> > nor have the destination (RT) and the base address (RA) as
> > the same register. In these cases, the instruction is
> > invalid.

> > However, the following behaviour is observed using some
> > invalid opcodes where RA = RT.
> > 
> > An userspace program using an invalid instruction word like
> > 0xe9ce0001, i.e. "ldu r14, 0(r14)", runs and exits without
> > getting terminated abruptly. The instruction performs the
> > load operation but does not write the effective address to
> > the base address register. 
> 
> While the processor (p8 in my test) doesn't seem to be throwing an 
> exception, I don't think it is necessarily loading the value. Qemu 
> throws an exception though. It's probably best to term the behavior as 
> being undefined.

Power8 does:

  Load with Update Instructions (RA = 0)
    EA is placed into R0.
  Load with Update Instructions (RA = RT)
    EA is placed into RT. The storage operand addressed by EA is
    accessed, but the data returned by the load is discarded.

Power9 does:

  Load with Update Instructions (RA = 0)
    EA is placed into R0.
  Load with Update Instructions (RA = RT)
    The storage operand addressed by EA is accessed. The displacement
    field is added to the data returned by the load and placed into RT.

Both UMs also say

  Invalid Forms
    In general, the POWER9 core handles invalid forms of instructions in
    the manner that is most convenient for the particular case (within
    the scope of meeting the boundedly-undefined definition described in
    the Power ISA). This document specifies the behavior for these
    cases.  However, it is not recommended that software or other system
    facilities make use of the POWER9 behavior in these cases because
    such behavior might be different in another processor that
    implements the Power ISA.

(or POWER8 instead of POWER9 of course).  Always complaining about most
invalid forms seems wise, certainly if not all recent CPUs behave the
same :-)


Segher
