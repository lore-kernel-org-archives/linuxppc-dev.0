Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C8EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:45:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6E2206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6E2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBgm1YCRzDqpC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:45:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBK33dfWzDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:29:11 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0AFSrcS026816;
 Thu, 10 Jan 2019 09:28:54 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x0AFSoEW026815;
 Thu, 10 Jan 2019 09:28:50 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 10 Jan 2019 09:28:50 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/vdso32: Drop -mabi=elfv1 for 32 bit objects
Message-ID: <20190110152849.GA14180@gate.crashing.org>
References: <20190110014258.20963-1-joel@jms.id.au>
 <82aeb9f8-6d25-de79-487c-a073ea33ba69@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82aeb9f8-6d25-de79-487c-a073ea33ba69@c-s.fr>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 Joel Stanley <joel@jms.id.au>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 08:10:43AM +0100, Christophe Leroy wrote:
> Le 10/01/2019 à 02:42, Joel Stanley a écrit :
> >From: Daniel Axtens <dja@axtens.net>
> >
> >All 64-bit objects need to specify the flag to be compiled correctly, we
> >just don't need it for 32-bit objects. GCC just ignored it, but clang
> >doesn't.

> >+# clang refuses to accept -mabi=elfv1 for when using the
> >+# 64-bit target in 32-bit mode
> >+ifdef CONFIG_CC_IS_CLANG
> 
> If -mabi=elfv1 is unneeded even for GCC, why depend on CLANG ?

It is nonsensical to specify this flag when compiling -m32.  Apparently
clang uses -mabi= to set the current ABI, which isn't quite correct
(although of course the name suggests that's what it does ;-) )

'-mabi=ABI-TYPE'
     Extend the current ABI with a particular extension, or remove such
     extension.  Valid values are 'altivec', 'no-altivec',
     'ibmlongdouble', 'ieeelongdouble', 'elfv1', 'elfv2'.

(It is harmless to use it with -m32 on GCC, because the option just sets a
flag, internally).

> >+ifdef CONFIG_PPC64
> >+AFLAGS_REMOVE_getcpu.o += -mabi=elfv1
> >+endif

Don't remove it, just never set it where not needed?


Segher
