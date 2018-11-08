Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD57CECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:13:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A3620817
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A3620817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rZHN40rMzF3SV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:13:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rZBG6S2jzF3SV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 07:09:26 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wA8K99Cu029567;
 Thu, 8 Nov 2018 14:09:10 -0600
Message-ID: <158f2b8a16915bc13d209c1acd38ef5e4e363d3d.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Guarded Userspace Access Prevention on Radix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Russell Currey
 <ruscur@russell.cc>
Date: Fri, 09 Nov 2018 07:09:09 +1100
In-Reply-To: <3b8d2b1b-548b-5a07-4358-4e645c06f59e@c-s.fr>
References: <20181026182916.Horde.8LHYJj4tB_PV5JLEA5Czjw1@messagerie.si.c-s.fr>
 <0e66ee72293811f580bd02ab4ed7967a4b703d70.camel@russell.cc>
 <20181031175845.Horde.o95YpPKYLOaCZUubOS1NRw1@messagerie.si.c-s.fr>
 <cdfb9e078946c63170845d2ec7167a6902514fc1.camel@russell.cc>
 <3b8d2b1b-548b-5a07-4358-4e645c06f59e@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-08 at 18:52 +0100, Christophe LEROY wrote:
> 
> In signal_32.c and signal_64.c, save_user_regs() calls __put_user() to 
> modify code, then calls flush_icache_range() on user addresses.
> 
> Shouldn't flush_icache_range() be performed with userspace access 
> protection unlocked ?

Thankfully this code is pretty much never used these days...

Russell: To trigger that, you need to disable the VDSO.

This brings back the idea however of having a way to "bulk" open the
gate during the whole signal sequence...

Cheers,
Ben.


