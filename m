Return-Path: <SRS0=1OJO=DI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7164C4727E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2020 20:48:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC9D20738
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2020 20:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC9D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C2QFY4lx7zDqdD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2020 06:48:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4C2QCR1m2VzDqbk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2020 06:46:42 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 091KiIqu017242;
 Thu, 1 Oct 2020 15:44:19 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 091KiHHX017241;
 Thu, 1 Oct 2020 15:44:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 1 Oct 2020 15:44:17 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/6] powerpc/time: Rename mftbl() to mftb()
Message-ID: <20201001204417.GP28786@gate.crashing.org>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 01, 2020 at 12:42:39PM +0000, Christophe Leroy wrote:
> On PPC64, we have mftb().
> On PPC32, we have mftbl() and an #define mftb() mftbl().
> 
> mftb() and mftbl() are equivalent, their purpose is to read the
> content of SPRN_TRBL, as returned by 'mftb' simplified instruction.
> 
> binutils seems to define 'mftbl' instruction as an equivalent
> of 'mftb'.
> 
> However in both 32 bits and 64 bits documentation, only 'mftb' is
> defined, and when performing a disassembly with objdump, the displayed
> instruction is 'mftb'
> 
> No need to have two ways to do the same thing with different
> names, rename mftbl() to have only mftb().

There are mttbl and mttbu insns (and no mttb insn); they write a 32-bit
half for the time base.  There is an mftb, and an mftbu.  mftbu reads
the upper half, while mftb reads the *whole* register.  SPR 269 is the
TBU register, while SPR 268 is called both TB and TBL.  Yes, it is
confusing :-)

The "mftb" name is much clearer than "mftbl" (on 64-bit), because it
reads the whole 64-bit register.  On 32-bit mftbl is clearer (but not
defined in the architecture, not officially an insn or even an extended
mnemonic).


Segher
