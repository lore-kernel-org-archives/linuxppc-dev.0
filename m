Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381EC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 00:00:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7FD20865
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 00:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7FD20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vrhl64XgzF1Nj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 11:00:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VrfZ6BVjzDrWR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 10:59:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42VrfY62MXz9s89;
 Thu, 11 Oct 2018 10:59:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Add driver for PAPR SCM regions
In-Reply-To: <20181010060812.20068-3-oohall@gmail.com>
References: <20181010060812.20068-1-oohall@gmail.com>
 <20181010060812.20068-3-oohall@gmail.com>
Date: Thu, 11 Oct 2018 10:59:01 +1100
Message-ID: <87ftxd2w1m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: nfont@linux.vnet.ibm.com, Oliver O'Halloran <oohall@gmail.com>,
 linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Oliver O'Halloran <oohall@gmail.com> writes:

> Adds a driver that implements support for enabling and accessing PAPR
> SCM regions. Unfortunately due to how the PAPR interface works we can't
> use the existing of_pmem driver (yet) because:
>
>  a) The guest is required to use the H_SCM_BIND_MEM h-call to add
>     add the SCM region to it's physical address space, and
>  b) There is currently no mechanism for relating a bare of_pmem region
>     to the backing DIMM (or not-a-DIMM for our case).
>
> Both of these are easily handled by rolling the functionality into a
> seperate driver so here we are...
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> The alternative implementation here is that we have the pseries code
> do the h-calls and craft a pmem-region@<addr> node based on that.
> However, that doesn't solve b) and mpe has expressed his dislike of
> adding new stuff to the DT at runtime so i'd say that's a non-starter.

Hmm, from memory you yelled something at me across the office about
that, so my response may not have been entirely well considered.

I'm not quite sure what the state of the OF overlays support is, but
that would be The Right Way to do that sort of modification to the
device tree at runtime.

If we merged this and then later got the of_pmem driver to work for us
would there be any user-visible change?

cheers
