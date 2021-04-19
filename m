Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:01:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C074F6127C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074F6127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP7l62k64z3bs7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 00:01:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FP7kb2XR0z30Jw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2021 00:00:38 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13JDvFjo030774;
 Mon, 19 Apr 2021 08:57:15 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 13JDvEBR030773;
 Mon, 19 Apr 2021 08:57:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 19 Apr 2021 08:57:14 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/2] powerpc: add ALTIVEC support to lib/ when PPC_FPU not
 set
Message-ID: <20210419135714.GS26583@gate.crashing.org>
References: <20210418201726.32130-1-rdunlap@infradead.org>
 <20210418201726.32130-2-rdunlap@infradead.org>
 <20210419133209.GR26583@gate.crashing.org>
 <4f5aea37-f638-3fde-0680-ec456ad91141@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f5aea37-f638-3fde-0680-ec456ad91141@csgroup.eu>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 19, 2021 at 03:38:02PM +0200, Christophe Leroy wrote:
> Le 19/04/2021 à 15:32, Segher Boessenkool a écrit :
> >On Sun, Apr 18, 2021 at 01:17:26PM -0700, Randy Dunlap wrote:
> >>Add ldstfp.o to the Makefile for CONFIG_ALTIVEC and add
> >>externs for get_vr() and put_vr() in lib/sstep.c to fix the
> >>build errors.
> >
> >>  obj-$(CONFIG_PPC_FPU)	+= ldstfp.o
> >>+obj-$(CONFIG_ALTIVEC)	+= ldstfp.o
> >
> >It is probably a good idea to split ldstfp.S into two, one for each of
> >the two configuration options?
> >
> 
> Or we can build it all the time and #ifdef the FPU part.
> 
> Because it contains FPU, ALTIVEC and VSX stuff.

So it becomes an empty object file if none of the options are selected?
Good idea :-)


Segher
