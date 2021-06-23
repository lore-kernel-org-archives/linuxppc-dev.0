Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B8EC4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 11:17:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23416102A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 11:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23416102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G912M2g91z3bvw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 21:17:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Je4LaOMm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Je4LaOMm; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G911t1t8Qz2yxW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 21:17:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G911k5VNVz9sWc;
 Wed, 23 Jun 2021 21:16:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1624447019;
 bh=wmQj+u1hPwTTqYQ6rEMEPSf63LiUs3skDiFe2aRX8Ag=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Je4LaOMmfEcosYnT5UzuA6yIBL35UPkM4HxyXBZTLQk27MBKOCdfgUx8P6w84bylY
 9h6RpFO47/cgwPka7uN7z7lKAquq2yQqx+NBDsGNSZlZCdIc3wT3akQYtExw2ZF768
 ypCO3FtmwAL/8gnxqaty4dXc0SWDbr0ZlKAa0dbQMb5wOtJH7pb1dS9INl1aBJ/ryJ
 9H3gq6Ve3EYUP2hbj986m+nBgohXZsOD4LbI6ohz7hrIBH4o+MTlMoup7LyZq/SPCC
 Hfk/xPq4c23k5Iv+F7YXNXeH6RbTktk0ndPVCKIIJPMm0zMXbSYkB+YS8jbaCpyIzU
 Q/o6xKoZpJWng==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>, kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] Add perf interface to expose nvdimm
In-Reply-To: <YNLxRz1w9IeatIKW@hirez.programming.kicks-ass.net>
References: <20210617132617.99529-1-kjain@linux.ibm.com>
 <YNHiRO11E9yYS6mv@hirez.programming.kicks-ass.net>
 <cea827fe-62d4-95fe-b81f-5c7bebe4a6f0@linux.ibm.com>
 <YNLxRz1w9IeatIKW@hirez.programming.kicks-ass.net>
Date: Wed, 23 Jun 2021 21:16:56 +1000
Message-ID: <87fsx825lj.fsf@mpe.ellerman.id.au>
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
Cc: nvdimm@lists.linux.dev, santosh@fossix.org, maddy@linux.vnet.ibm.com,
 ira.weiny@intel.com, rnsastry@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 linux-kernel@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Peter Zijlstra <peterz@infradead.org> writes:
> On Wed, Jun 23, 2021 at 01:40:38PM +0530, kajoljain wrote:
>> 
>> On 6/22/21 6:44 PM, Peter Zijlstra wrote:
>> > On Thu, Jun 17, 2021 at 06:56:13PM +0530, Kajol Jain wrote:
>> >> ---
>> >> Kajol Jain (4):
>> >>   drivers/nvdimm: Add nvdimm pmu structure
>> >>   drivers/nvdimm: Add perf interface to expose nvdimm performance stats
>> >>   powerpc/papr_scm: Add perf interface support
>> >>   powerpc/papr_scm: Document papr_scm sysfs event format entries
>> > 
>> > Don't see anything obviously wrong with this one.
>> > 
>> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > 
>> 
>> Hi Peter,
>>     Thanks for reviewing the patch. Can you help me on how to take 
>> these patches to linus tree or can you take it?
>
> I would expect either the NVDIMM or PPC maintainers to take this. Dan,
> Michael ?

I can take it but would need Acks from nvdimm folks.

cheers
