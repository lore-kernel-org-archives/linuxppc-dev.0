Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1134DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 03:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABE42147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 03:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Gu8tRS7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABE42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Qzk6GVgzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 14:23:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443Qxz72mFzDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 14:21:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Gu8tRS7r"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 443Qxz4drrz9sDL; Tue, 19 Feb 2019 14:21:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550546503; bh=C4HLRcI4ypCgdGuAUaWYJlccB1gE29ZZS2GrzcNQN90=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gu8tRS7rJAFvgDvEDp81cn1xylOlkuDzmL4CtPcfDyOg2uMuaOcv4rZyEGZR7NyzL
 958zm0atvwfeQgHGkWrR3/ZVcHfKSX6dNzw3dLCO6idaGwOy6D5imZS/SLY6uxEkjZ
 OgXG+jWFgIJkqYg7CiNMvkEQRAk1S/+Q1ab59lOddnU3TjH4a1FfGZz4gyQhFZPk3y
 6OPkQymMisT2ueB+CIvpVwk5SpZVu6y9op65eLo+Wx/R0cV5Xtz/ri6PpGH3ohBQvR
 lpGL/drQryVYhBucwTTVlelN9e+fxP6uAUeOSUKTe7yc/nlYv/+WpKiUvWcrqL1Psm
 Hyya9yfN3sz8w==
Date: Tue, 19 Feb 2019 14:21:40 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RFC PATCH v3 3/4] kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE
 hcalls
Message-ID: <20190219032140.GA5353@blackberry>
References: <20190130060726.29958-1-bharata@linux.ibm.com>
 <20190130060726.29958-4-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130060726.29958-4-bharata@linux.ibm.com>
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
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org, benh@linux.ibm.com,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 30, 2019 at 11:37:25AM +0530, Bharata B Rao wrote:
> H_SVM_INIT_START: Initiate securing a VM
> H_SVM_INIT_DONE: Conclude securing a VM
> 
> During early guest init, these hcalls will be issued by UV.
> As part of these hcalls, [un]register memslots with UV.

That last sentence is a bit misleading as it implies that
H_SVM_INIT_DONE causes us to unregister the memslots with the UV,
which is not the case.  Shouldn't it be "As part of H_SVM_INIT_START,
register all existing memslots with the UV"?

Also, do we subsequently communicate changes in the memslots to the
UV?

Paul.
