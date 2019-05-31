Return-Path: <SRS0=knV+=T7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A27C28CC0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 01:05:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2082637A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 01:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2082637A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FR7g3PwXzDqZD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 11:05:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FR645ks5zDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2019 11:03:40 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x4V13QtR019033;
 Thu, 30 May 2019 20:03:27 -0500
Message-ID: <43f037c57eed8ad2175470c940917dced947bb70.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] prom_init: Fetch flatten device tree from the
 system firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Date: Fri, 31 May 2019 11:03:26 +1000
In-Reply-To: <20190530193736.GC31586@gate.crashing.org>
References: <20190501034221.18437-1-aik@ozlabs.ru>
 <a62a8612-77f5-5c6b-a6a2-15f006051d5e@ozlabs.ru>
 <20190530193736.GC31586@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-05-30 at 14:37 -0500, Segher Boessenkool wrote:
> On Thu, May 30, 2019 at 05:09:06PM +1000, Alexey Kardashevskiy wrote:
> > so, it is sort-of nack from David and sort-of ack from Segher, what
> > happens now?
> 
> Maybe what we really need just a CI call to get all properties of a node
> at once?  Will that speed up things enough?
> 
> That way you need no change at all in lifetime of properties and how they
> are used, etc.; just a client getting the properties is a lot faster.

Hrm... if we're going to create a new interface, let's go for what we
need.

What we need is the FDT. It's a rather ubiquitous thing these days, it
makes sense to have a way to fetch an FDT directly from FW.

There is no use for the "fetch all properties" cases other than
building an FDT that any of us can think of, and it would create a more
complicated interface than just "fetch an FDT".

So I go for the simple one and agree with Alexey's idea.

Cheers,
Ben.


