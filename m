Return-Path: <SRS0=8zLz=UO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F4EC31E47
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:41:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D5E2184B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="bdb8QER0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D5E2184B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QqCv6Fw2zDr72
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 17:41:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Qq7X0sDgzDrcZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 17:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="bdb8QER0"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 45Qq7W4nsrz9sNT; Sat, 15 Jun 2019 17:37:27 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45Qq7W41Drz9sDB; Sat, 15 Jun 2019 17:37:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1560584247; bh=tKoVDInPecXoeEXMW70V2vj5KuXPanLCpYWOumHs1rc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bdb8QER0aLThSFeUxQAFwQNi7i5uHfosRYjmTturWX2pu+Y46RASWLyKukwMrpK2y
 v3Q+Ut+yaP7nAQCySox+ZasCthS6xSoaYInqpusAr+63FWI0YWanmF6eXu3wI46APk
 +4G7qG43ELE/MH05qLKvmSqifeCfVfq0LC8kAFNWriRPEivN/fiqszUadjh33+Lmyq
 BL+Usp8T1XiSZYbG+umSw0DC9xoSTurrVtuYyyEdbwgcPZSo3wriOpxgRZ2e0pFiRn
 Bc4+zHxYbN7g0Al275AyW3X1jDDpuKAjAWIfOcwnyl2Uxp6iOGgMJfZGm8pVit50NQ
 OaTTxXlYNiELg==
Date: Sat, 15 Jun 2019 17:37:24 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v3 4/9] KVM: PPC: Ultravisor: Add generic ultravisor call
 handler
Message-ID: <20190615073724.GB24709@blackberry>
References: <20190606173614.32090-1-cclaudio@linux.ibm.com>
 <20190606173614.32090-5-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606173614.32090-5-cclaudio@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauermann@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2019 at 02:36:09PM -0300, Claudio Carvalho wrote:
> From: Ram Pai <linuxram@us.ibm.com>
> 
> Add the ucall() function, which can be used to make ultravisor calls
> with varied number of in and out arguments. Ultravisor calls can be made
> from the host or guests.
> 
> This copies the implementation of plpar_hcall().

Again, we will want all of this on every powernv-capable kernel, since
they will all need to do UV_WRITE_PATE, even if they have no other
support for the ultravisor.

Paul.
