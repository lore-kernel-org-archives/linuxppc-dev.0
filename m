Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E95C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 13:16:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B0E61040
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 13:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B0E61040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8RjW4Z3pz3bwC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 23:15:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Txzx9gND;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=Txzx9gND; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8Rhv4cHGz302l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 23:15:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=++Q8EHvNJOniOHh5A5dqNXrOe0ZjsvPzI3S1iuyJd0c=; b=Txzx9gND61hysapCm7XtbdbUZr
 2YsWt1vi+k79EDFOYgoGnzuf2OFMkaj4KdG5nOGfQFdIzyZoFIs2KPpFqdlwwkwiCBjkaT/qldytF
 e+cfhJ95GNrbWmsoCA1bbRT0QqHLryJKGRhlxXE5/OK1ynxTqAByddMjYUdGY9ONd1xPqpc6Ugx/F
 o8NusjwVdkXD7UVBLokBoyfKxOv+hdUIszHpBzT7q+Hytwuq2puSXFhB2LKv8JCH5vzRA1m1+lT3P
 xe2+cqruOSRZ/fKM3F5xUI6rIQ8pYgJ3vxMLfgBbE64jUwvzZw4KjPAaV+Zd3BrGCOHtoKv6WFKJl
 A63KkXoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvgEj-00AbaW-GN; Tue, 22 Jun 2021 13:14:48 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B4FF30021A;
 Tue, 22 Jun 2021 15:14:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 4595720C169E1; Tue, 22 Jun 2021 15:14:44 +0200 (CEST)
Date: Tue, 22 Jun 2021 15:14:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] Add perf interface to expose nvdimm
Message-ID: <YNHiRO11E9yYS6mv@hirez.programming.kicks-ass.net>
References: <20210617132617.99529-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617132617.99529-1-kjain@linux.ibm.com>
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
Cc: nvdimm@lists.linux.dev, santosh@fossix.org, maddy@linux.vnet.ibm.com,
 ira.weiny@intel.com, rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
 atrajeev@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 17, 2021 at 06:56:13PM +0530, Kajol Jain wrote:
> ---
> Kajol Jain (4):
>   drivers/nvdimm: Add nvdimm pmu structure
>   drivers/nvdimm: Add perf interface to expose nvdimm performance stats
>   powerpc/papr_scm: Add perf interface support
>   powerpc/papr_scm: Document papr_scm sysfs event format entries

Don't see anything obviously wrong with this one.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
