Return-Path: <SRS0=FDsq=UQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C8C31E44
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 04:08:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE5421881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 04:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Z0EfrHRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE5421881
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45RyPS2fRJzDqbB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 14:08:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45RyMK16l5zDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2019 14:06:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Z0EfrHRu"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45RyMJ6YWDz9sDX; Mon, 17 Jun 2019 14:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1560744396; bh=0cKzGdt6WGsAZB+3r9paweiXCWroPIbVCKopag+ojKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0EfrHRuzCrzprrirgHeOsXdN2MtYJKGs6jXEhmiug8dsUK12ukgYg32hkFCb32M/
 SEWnO0nlsdQrwLeL95aLHsYI9wNrhfo+dt7avrzQ3v6WFTsS3n8LqE1+R1ZoH1wVOB
 XhRxaQpvwDQ+wOyiTLrg4oBAuxXIPQbr1gLS9PdXzmBOK3h0TTrb8o7c4DwqDiEDij
 BtF6DgIrxDxJ3ODFdTsYKOQVtKq7em0JyemWTaH0hwIzAMfahUUjv2X1YXLbU8b0Hk
 exxEagml3AklSQK/5L6IAQtiDBLPPDNXXL2MENQvKE2dFxXAr28p+NlONIhtySetgU
 yElL5UmUA4eOQ==
Date: Mon, 17 Jun 2019 14:06:32 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RFC PATCH v4 6/6] kvmppc: Support reset of secure guest
Message-ID: <20190617040632.jiq73ogxqyccvfjl@oak.ozlabs.ibm.com>
References: <20190528064933.23119-1-bharata@linux.ibm.com>
 <20190528064933.23119-7-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528064933.23119-7-bharata@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: linuxram@us.ibm.com, cclaudio@linux.ibm.com, kvm-ppc@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 28, 2019 at 12:19:33PM +0530, Bharata B Rao wrote:
> Add support for reset of secure guest via a new ioctl KVM_PPC_SVM_OFF.
> This ioctl will be issued by QEMU during reset and in this ioctl,
> we ask UV to terminate the guest via UV_SVM_TERMINATE ucall,
> reinitialize guest's partitioned scoped page tables and release all
> HMM pages of the secure guest.
> 
> After these steps, guest is ready to issue UV_ESM call once again
> to switch to secure mode.

Since you are adding a new KVM ioctl, you need to add a description of
it to Documentation/virtual/kvm/api.txt.

Paul.
