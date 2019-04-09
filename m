Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8581C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:14:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3EB2084F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="boL01k+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3EB2084F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dg7G32xVzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 18:14:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dg3S6KrKzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 18:11:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="boL01k+6"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 44dg3S27CPz9sRY; Tue,  9 Apr 2019 18:11:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1554797476; bh=xFGsYyMOVtmziFzxDXRT7Ndt/DrmKqE7hgB8LHw8XAM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=boL01k+6euQV119oGHdawNRYqgOUhmQmfZF2SaiKzOcYpcSTAvG9Q9N8YY5EJioGR
 mJLf+e3sL4pVXeRWtLf+gmYcEG4a0NdK7ers9/wIZaKd0Ic0ezMHob7MichEj3lSBG
 rk55HIQkhfV7hh6lBOWIyHnVHBW728XkFsdtvomJqtuqwVMDjkgxtpzT0bwBv6Mz0B
 KPJ3S0xZAtfhvKlKPr/L1vsl4tkivAnZGjeoKmA/0pkgBP9wgAPhRGVs06+l2x9OB0
 gMEtQHBIPtyqo1SBr7KT/cZHetpoOc4mjG9clsME72fiGZJAceE8CQpLNDCGthJTAI
 KqPv+vixJRn7Q==
Date: Tue, 9 Apr 2019 16:19:16 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 10/17] KVM: PPC: Book3S HV: XIVE: add get/set
 accessors for the VP XIVE state
Message-ID: <20190409061916.GA3429@blackberry>
References: <20190320083751.27001-1-clg@kaod.org>
 <20190320083751.27001-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320083751.27001-11-clg@kaod.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 09:37:44AM +0100, Cédric Le Goater wrote:
> The state of the thread interrupt management registers needs to be
> collected for migration. These registers are cached under the
> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
> pulled from the HW thread. An OPAL call retrieves the backup of the
> IPB register in the underlying XIVE NVT structure and merges it in the
> KVM state.

Since you're adding a new one_reg identifier value, you need to update
the list in Documentation/virtual/kvm/api.txt.

Paul.
