Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F5FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:53:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD3E2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="lSYz02ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD3E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445RVb5TmhzDqSG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RGv4wFMzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:43:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="lSYz02ds"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 445RGv2xC3z9sBp; Fri, 22 Feb 2019 20:43:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550828599; bh=sk0BFagW++kxQWaP8OvW8LG7tsGYW9y3qoRTWglxyuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lSYz02dsFnL3cLe8U+AVP2tmvrhirSNFXMWMrnwlCU2//9GkYZblw15cKGOhEtU/U
 AeUGDTBAIHNzzBHhsLG8dk+CWDHA4pAvGF+stVp3+dcz9Dx7qqZ9CZpFof4eGBa5S+
 WBimXTfnmgypHcNRv/OPcs22P843zb/I2O96Un1xhJJm4kZKa9Gldsj5rYefGUdZEo
 SG4EODAO/IkqyQWcQFC4d90FPdE/cSWZ6nviWkdycE1UUjygBtpczN0DjuVkBitRJg
 xlwL4qlPDLBddk+WbMVF9C0/SY31P3u3R4tdJZg6e0km7FERMwZhF7+JIcZUY9747i
 p8YAIkU6dCGEQ==
Date: Fri, 22 Feb 2019 20:41:01 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix build failure without IOMMU
 support
Message-ID: <20190222094101.GE6006@blackberry>
References: <20190221032848.22590-1-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221032848.22590-1-jniethe5@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 02:28:48PM +1100, Jordan Niethe wrote:
> Currently trying to build without IOMMU support will fail:
> 
>   (.text+0x1380): undefined reference to `kvmppc_h_get_tce'
>   (.text+0x1384): undefined reference to `kvmppc_rm_h_put_tce'
>   (.text+0x149c): undefined reference to `kvmppc_rm_h_stuff_tce'
>   (.text+0x14a0): undefined reference to `kvmppc_rm_h_put_tce_indirect'
> 
> This happens because turning off IOMMU support will prevent
> book3s_64_vio_hv.c from being built because it is only built when
> SPAPR_TCE_IOMMU is set, which depends on IOMMU support.
> 
> Fix it using ifdefs for the undefined references.
> 
> Fixes: 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code on non-pseries platforms")
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>

Thanks, applied to my kvm-ppc-next tree.

Paul.
