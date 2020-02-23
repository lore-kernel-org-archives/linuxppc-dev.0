Return-Path: <SRS0=8Gu8=4L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437DC35669
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Feb 2020 00:09:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4606820702
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Feb 2020 00:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4606820702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Q5Ch30fHzDqc6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Feb 2020 11:09:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Q59T1LcwzDqZb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Feb 2020 11:07:23 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 01N07FkM027986;
 Sat, 22 Feb 2020 18:07:15 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 01N07F9V027985;
 Sat, 22 Feb 2020 18:07:15 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 22 Feb 2020 18:07:15 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: vdso function descriptors (VDS64_HAS_DESCRIPTORS)?
Message-ID: <20200223000715.GW22482@gate.crashing.org>
References: <20200217160852.GA9557@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217160852.GA9557@redhat.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 17, 2020 at 11:08:52AM -0500, Joe Lawrence wrote:
> I was wondering if there was history behind VDS64_HAS_DESCRIPTORS and in
> what cases would one want to turn them on?  (Note, I'm assuming they are
> an implementation of Function Descriptors. [1])

It's from the very first patch implementing VDSOs for powerpc, which
says:

commit 86b67fe764e9e54443226a3a0b298f650588d6c5
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Fri Mar 4 17:33:32 2005 -0800

    [PATCH] ppc64: Implement a vDSO and use it for signal trampoline

[...]

    Note that
    the symbols exposed by the vDSO aren't "normal" function symbols, apps
    can't be expected to link against them directly, the vDSO's are both seen
    as if they were linked at 0 and the symbols just contain offsets to the
    various functions.  This is done on purpose to avoid a relocation step
    (ppc64 functions normally have descriptors with abs addresses in them).
    When glibc uses those functions, it's expected to use it's own trampolines
    that know how to reach them.

so already then this was unused code, presumably it was just used during
development.

> arch/powerpc/include/asm/vdso.h unsets the macro:
> 
>   /* Define if 64 bits VDSO has procedure descriptors */
>   #undef VDS64_HAS_DESCRIPTORS
> 
> so I don't believe they are ever used by default -- in this case
> V_FUNCTION_BEGIN doesn't add to the .opd section with .name, .TOC base,
> etc.
> 
> Manually setting VDS64_HAS_DESCRIPTORS results in a vdso64.so in which
> binutils tools like readelf properly report functions with symbol type
> FUNC instead of NOTYPE.
> 
> Are there pieces of the build/etc toolchain unprepared for function
> descriptors?  I'm just trying to figure out why the code defaults to
> unsetting them.

Because direct calls are faster than indirect calls?  Ben might have a
fuller explanation, cc:ing him.


Segher
