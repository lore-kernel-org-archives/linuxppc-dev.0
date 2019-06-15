Return-Path: <SRS0=8zLz=UO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B13AC31E47
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:43:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6382184C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HVi9H+S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6382184C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QqGC18WGzDrfY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 17:43:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Qq9P5XLmzDrdZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 17:39:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HVi9H+S4"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 45Qq9P3HdYz9sNk; Sat, 15 Jun 2019 17:39:05 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45Qq9P1qmmz9sNT; Sat, 15 Jun 2019 17:39:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1560584345; bh=jJrBcz383cyzLtbHZTqELCISI6z/er7Ec5RzoNiO7Dg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HVi9H+S4FU54amSAnfO8034hu+3F4tiNGpRBBNBoOw7v3Q90a42Y1pehOKAt3FVII
 Q/wpp360CEBGgZIsjxdBjt2UKNaMkVwUKyxa1ahrBNozA9eAiL8eVBNX6WF2yihPZM
 ENd9Lb1A9MMUyBB5hmOaXfolFATOE+ThKxkr/sdacM4HAj3ZGmNV94m7jFfPkDoThH
 9psc85W25l16pzHjsSzq/9axy74yEARUShhFhkJ3UQONUfN7Wg3WTsFzZ+YGPf+C0k
 eIIZmf6CVciKHJwxhuTepsENsRGkyaAiTlGnoApDxmjIgeoeB6eTOwge8Npq1NSlBv
 JE0Zlpy76P3Wg==
Date: Sat, 15 Jun 2019 17:38:58 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v3 5/9] KVM: PPC: Ultravisor: Use UV_WRITE_PATE ucall to
 register a PATE
Message-ID: <20190615073858.GC24709@blackberry>
References: <20190606173614.32090-1-cclaudio@linux.ibm.com>
 <20190606173614.32090-6-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606173614.32090-6-cclaudio@linux.ibm.com>
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
 Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauermann@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2019 at 02:36:10PM -0300, Claudio Carvalho wrote:
> From: Michael Anderson <andmike@linux.ibm.com>
> 
> When running under an ultravisor, the ultravisor controls the real
> partition table and has it in secure memory where the hypervisor can't
> access it, and therefore we (the HV) have to do a ucall whenever we want
> to update an entry.
> 
> The HV still keeps a copy of its view of the partition table in normal
> memory so that the nest MMU can access it.
> 
> Both partition tables will have PATE entries for HV and normal virtual
> machines.

As discussed before, all of this should depend only on
CONFIG_PPC_POWERNV.

Paul.
