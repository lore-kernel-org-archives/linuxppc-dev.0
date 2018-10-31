Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E762C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:26:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFE22064C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFE22064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ljcR0dqqzF3LY
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 09:26:47 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ljZ83ZHnzF3HY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 09:24:48 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9VMOTXF003676;
 Wed, 31 Oct 2018 17:24:30 -0500
Message-ID: <3da6549832ef68b93b210d5a32b3f12f3565cab0.camel@kernel.crashing.org>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Florian Weimer <fweimer@redhat.com>, Michal =?ISO-8859-1?Q?Such=E1nek?=
 <msuchanek@suse.de>
Date: Thu, 01 Nov 2018 09:24:29 +1100
In-Reply-To: <877ehyf1cj.fsf@oldenburg.str.redhat.com>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <20181031185032.679e170a@naga.suse.cz>
 <877ehyf1cj.fsf@oldenburg.str.redhat.com>
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
Cc: linux-mm@kvack.org, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nick Piggin <npiggin@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-31 at 18:54 +0100, Florian Weimer wrote:
> 
> It would matter to C code which returns the address of a global variable
> in the main program through and (implicit) int return value.
> 
> The old behavior hid some pointer truncation issues.

Hiding bugs like that is never a good idea..

> > Maybe it would be good idea to generate 64bit relocations on 64bit
> > targets?
> 
> Yes, the Go toolchain definitely needs fixing for PIE.  I don't dispute
> that.

There was never any ABI guarantee that programs would be loaded below
4G... it just *happened*, so that's not per-se an ABI change.

That said, I'm surprised of the choice of address.. I would have rather
moved to above 1TB to benefit from 1T segments...

Nick, Anton, do you know anything about that change ?

Ben.


