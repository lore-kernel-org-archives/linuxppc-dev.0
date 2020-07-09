Return-Path: <SRS0=USLf=AU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A42FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 00:33:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAB520739
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 00:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAB520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B2HFk0DW8zDqkg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 10:32:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B2HCh5jWpzDqS7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2020 10:31:12 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0690UhUB021413;
 Wed, 8 Jul 2020 19:30:43 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0690Uf1C021412;
 Wed, 8 Jul 2020 19:30:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 8 Jul 2020 19:30:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: powerpc: Incorrect stw operand modifier in __set_pte_at
Message-ID: <20200709003041.GG3598@gate.crashing.org>
References: <873469922.2744.1594219513228.JavaMail.zimbra@efficios.com>
 <582c7ca7-a7a4-9861-cd53-8e34ff10c942@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <582c7ca7-a7a4-9861-cd53-8e34ff10c942@csgroup.eu>
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
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jul 08, 2020 at 06:16:54PM +0200, Christophe Leroy wrote:
> Le 08/07/2020 à 16:45, Mathieu Desnoyers a écrit :
> >Reviewing use of the patterns "Un%Xn" with lwz and stw instructions
> >(where n should be the operand number) within the Linux kernel led
> >me to spot those 2 weird cases:
> >
> >arch/powerpc/include/asm/nohash/pgtable.h:__set_pte_at()
> >
> >                 __asm__ __volatile__("\
> >                         stw%U0%X0 %2,%0\n\
> >                         eieio\n\
> >                         stw%U0%X0 %L2,%1"
> >                 : "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> >                 : "r" (pte) : "memory");
> >
> >I would have expected the stw to be:
> >
> >                         stw%U1%X1 %L2,%1"
> >
> >and:
> >arch/powerpc/include/asm/book3s/32/pgtable.h:__set_pte_at()
> >
> >         __asm__ __volatile__("\
> >                 stw%U0%X0 %2,%0\n\
> >                 eieio\n\
> >                 stw%U0%X0 %L2,%1"
> >         : "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> >         : "r" (pte) : "memory");
> >
> >where I would have expected:
> >
> >                 stw%U1%X1 %L2,%1"
> >
> >Is it a bug or am I missing something ?
> 
> Well spotted. I guess it's definitly a bug.

Yes :-)

> Introduced 12 years ago by commit 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bf2b5cd 
> ("powerpc: Fixes for CONFIG_PTE_64BIT for SMP support").
> 
> It's gone unnoticed until now it seems.

Apparently it always could use offset form memory accesses?  Or even
when not, %0 and %1 are likely to use the same base register for
addressing :-)


Segher
