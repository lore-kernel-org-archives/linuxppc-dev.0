Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703BC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 04:30:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63683207E8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="I3B2gb+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63683207E8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WyYv33XczDqSc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 14:30:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WyLh6nYJzDqP6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 14:21:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=I3B2gb+C; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49WyLh3q1Kz9sSg; Wed, 27 May 2020 14:21:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590553260; bh=Y21jN5y45Um4AYIa//KCJfpc5WBbHBo15ZjCSQkLVDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I3B2gb+CqUvnQTciOQNbK+Nanl0aafykbtezdHL4nEHndD94WUy5NzD9feSxRyj49
 QsAoqdEtwRtAS8YCi93WAfbLMVvB2u67ufu53/SWaWwAfhLRaSO6XcMDVAXKpSEbi3
 2nhgX+lFSTNVaNijRZ+Lopo0iA+wnctLMQABLJZDyy8DXRlW0v+qY/763/ZZy1EujN
 UeYyAXI/IzV1D7lbTueJ5plZCHBnk9MrHForXAsPE/LBrl2Ip0AooCH6/mkwiczEgn
 8zvYmomsomo+Sh0iv8WMogEZTERJrj5XG7mnchJAoBaMlm2C5D4ruHw65MLKrLHbZz
 RPtepX0/K25jQ==
Date: Wed, 27 May 2020 14:16:49 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: relax check on H_SVM_INIT_ABORT
Message-ID: <20200527041649.GD293451@thinks.paulus.ozlabs.org>
References: <20200520193259.0b66db32@bahia.lan>
 <20200520174308.77820-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520174308.77820-1-ldufour@linux.ibm.com>
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
Cc: linuxram@us.ibm.com, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 groug@kaod.org, sukadev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 20, 2020 at 07:43:08PM +0200, Laurent Dufour wrote:
> The commit 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_*
> Hcalls") added checks of secure bit of SRR1 to filter out the Hcall
> reserved to the Ultravisor.
> 
> However, the Hcall H_SVM_INIT_ABORT is made by the Ultravisor passing the
> context of the VM calling UV_ESM. This allows the Hypervisor to return to
> the guest without going through the Ultravisor. Thus the Secure bit of SRR1
> is not set in that particular case.
> 
> In the case a regular VM is calling H_SVM_INIT_ABORT, this hcall will be
> filtered out in kvmppc_h_svm_init_abort() because kvm->arch.secure_guest is
> not set in that case.
> 
> Fixes: 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_* Hcalls")
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Thanks, applied to my kvm-ppc-next branch.  I expanded the comment in
the code a little.

Paul.
