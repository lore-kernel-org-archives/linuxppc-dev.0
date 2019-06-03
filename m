Return-Path: <SRS0=u7tn=UC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B903BC04AB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 23:50:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E1F26329
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 23:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E1F26329
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45HsJK4vDvzDqWx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 09:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45HsGs44TKzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2019 09:49:41 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x53NnXcT016185;
 Mon, 3 Jun 2019 18:49:33 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x53NnWCZ016184;
 Mon, 3 Jun 2019 18:49:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 3 Jun 2019 18:49:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel] prom_init: Fetch flatten device tree from the
 system firmware
Message-ID: <20190603234932.GR31586@gate.crashing.org>
References: <20190501034221.18437-1-aik@ozlabs.ru>
 <a62a8612-77f5-5c6b-a6a2-15f006051d5e@ozlabs.ru>
 <20190530193736.GC31586@gate.crashing.org>
 <43f037c57eed8ad2175470c940917dced947bb70.camel@kernel.crashing.org>
 <20190602232330.GN31586@gate.crashing.org>
 <7fc6cd5e-ddd6-4028-b4ef-7bdcd6db69d0@ozlabs.ru>
 <32063141651fd502c8ce94be19cb5c5330ce39bd.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32063141651fd502c8ce94be19cb5c5330ce39bd.camel@kernel.crashing.org>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 04, 2019 at 07:18:42AM +1000, Benjamin Herrenschmidt wrote:
> Yes we could make property fetching faster but mostly by creating a new
> bulk interface which is quite a bit of work, a new API, and will in
> practice not be used for anything other than creating the FDT. In that
> case, nothing will beat in performance having OF create the FDT itself
> based on its current tree.

And that will change the whole boot protocol, the interaction between OF
and its client, which is a much bigger change, not conceptually trivial
at all.  Copying all properties at once is, which is why I suggested it.

It would take away the opposition to your patch.


Segher
