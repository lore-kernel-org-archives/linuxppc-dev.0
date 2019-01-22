Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04050C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:45:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B06820879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="KQDdyMfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B06820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHSk6gz8zDqMw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:45:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPs3Y7WzDqMh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="KQDdyMfh"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPr6nX4z9s7h; Tue, 22 Jan 2019 16:42:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135776; bh=yUHGIHK6jhYVXZuBCEEKqTwbH2Ia7boye8b/NF7Mt8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KQDdyMfh7Ola0PECR2ma2XTYQ+BGGMA5zObJUh7ken3XSkjPaAneA66wn65unPckj
 YwB7MU2MGFJ+aCTDvE1B44BU07sCCphLIXwTWb+f6VZMWMjVIGB0b05aZvaA/n23lk
 efES2giNFvX5kXJAQ4DygkfQ3QHHQjMsb2l2HXsgYKUS9KLcgwHCCD6WJJ9Q2cThIF
 30hRftg9e14YhSQ7QnBZdqgIss5fJFeM3yUTpKZxTKbMX/rRCBCiU06JpbXYWyGsAf
 3WijDowLLy4ZLxfrwMewy+8M29i867iLPwLcTqYuuLj8O8P2PynR7d25eTsVD1XH2y
 kLEl+Ojb/0QZA==
Date: Tue, 22 Jan 2019 16:05:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
Message-ID: <20190122050520.GC15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107184331.8429-6-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
> This is the basic framework for the new KVM device supporting the XIVE
> native exploitation mode. The user interface exposes a new capability
> and a new KVM device to be used by QEMU.

[snip]
> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
>  #ifdef CONFIG_KVM_XIVE
>  	if (xive_enabled()) {
>  		kvmppc_xive_init_module();
> +		kvmppc_xive_native_init_module();
>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
> +		kvm_register_device_ops(&kvm_xive_native_ops,
> +					KVM_DEV_TYPE_XIVE);

I think we want tighter conditions on initializing the xive_native
stuff and creating the xive device class.  We could have
xive_enabled() returning true in a guest, and this code will get
called both by PR KVM and HV KVM (and HV KVM no longer implies that we
are running bare metal).

> @@ -1050,8 +1053,10 @@ static int kvmppc_book3s_init(void)
>  static void kvmppc_book3s_exit(void)
>  {
>  #ifdef CONFIG_KVM_XICS
> -	if (xive_enabled())
> +	if (xive_enabled()) {
>  		kvmppc_xive_exit_module();
> +		kvmppc_xive_native_exit_module();

Same comment here.

Paul.
