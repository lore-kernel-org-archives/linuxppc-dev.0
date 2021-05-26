Return-Path: <SRS0=OfUe=KV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719FDC2B9F7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 May 2021 08:33:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB3B613B0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 May 2021 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB3B613B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FqkkD6QKSz30Dr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 May 2021 18:33:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qh9DODud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=qh9DODud; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fqkjf6tTCz2xvV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 May 2021 18:33:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ayi1aZxpImaUKGH6duzMtDP6l99UaS5sywY/3DasNpU=; b=qh9DODudqPXQIY8M6srRqx+hlI
 BVH0SAG11gAaZJpweQoBW8mHLczvQwdN5BmIhMEw0RqptBpYv9dQeW/BQcTgiUWJ4iHYiUirk3jfD
 DcMzKRTZJDE1fNyngOaSpT4pY97kT5tKp9I0/R3R/mCAairZXC2fFt27xeKwAFOWjx8MtNp3rwM0+
 SmLHX1wrjAibiX1VYsYpcPBkgvxA9tKQ4HlwFNQ5EYhT5a/d8RLRLtFbAEk08VRLS0V0hc0KoKDRo
 NYTrlqQu+xrUf3VIWg4vynNiSxX23Olp0DYfLA+h3i0HTFGKB7xPkRlZKFFyxCEZjgt8YkREcKUTv
 lww1wgUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lloxr-000Wkb-SA; Wed, 26 May 2021 08:32:39 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B214300242;
 Wed, 26 May 2021 10:32:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0522C201DB6C5; Wed, 26 May 2021 10:32:36 +0200 (CEST)
Date: Wed, 26 May 2021 10:32:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC v2 4/4] powerpc/papr_scm: Add cpu hotplug support for
 nvdimm pmu device
Message-ID: <YK4Ho7e+LCqjYA2X@hirez.programming.kicks-ass.net>
References: <20210525132216.1239259-1-kjain@linux.ibm.com>
 <20210525132216.1239259-5-kjain@linux.ibm.com>
 <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
 <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
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
Cc: santosh@fossix.org, maddy@linux.vnet.ibm.com, ira.weiny@intel.com,
 linux-nvdimm@lists.01.org, rnsastry@linux.ibm.com,
 linux-kernel@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
 aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 26, 2021 at 12:56:58PM +0530, kajoljain wrote:
> On 5/25/21 7:46 PM, Peter Zijlstra wrote:
> > On Tue, May 25, 2021 at 06:52:16PM +0530, Kajol Jain wrote:

> >> It adds cpumask to designate a cpu to make HCALL to
> >> collect the counter data for the nvdimm device and
> >> update ABI documentation accordingly.
> >>
> >> Result in power9 lpar system:
> >> command:# cat /sys/devices/nmem0/cpumask
> >> 0
> > 
> > Is this specific to the papr thing, or should this be in generic nvdimm
> > code?
> 
> This code is not specific to papr device and we can move it to
> generic nvdimm interface. But do we need to add some checks on whether
> any arch/platform specific driver want that support or we can assume 
> that this will be something needed by all platforms?

I'm a complete NVDIMM n00b, but to me it would appear they would have to
conform to the normal memory hierarchy and would thus always be
per-node.

Also, if/when deviation from this rule is observed, we can always
rework/extend this. For now I think it would make sense to have the
per-node ness of the thing expressed in the generic layer.
