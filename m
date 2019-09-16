Return-Path: <SRS0=9DpD=XL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17FCC49ED7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Sep 2019 15:11:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1072067B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Sep 2019 15:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1072067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46X8pw3fm1zF4hV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Sep 2019 01:11:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46X8lf2lJ5zF1RP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2019 01:09:02 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1i9sYG-0008L7-6q; Mon, 16 Sep 2019 10:04:28 -0500
Message-ID: <71490f3b94b851106eb48c8909239f401d0018d1.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, galak@kernel.crashing.org
Date: Mon, 16 Sep 2019 10:04:27 -0500
In-Reply-To: <7f8f9747ef1ab2e1261cf83b03c1da321d47f7b7.1568616151.git.christophe.leroy@c-s.fr>
References: <966e6d6a226f9786098d296239a6c65064e73a41.1568616151.git.christophe.leroy@c-s.fr>
 <7f8f9747ef1ab2e1261cf83b03c1da321d47f7b7.1568616151.git.christophe.leroy@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@c-s.fr, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2 2/2] powerpc/83xx: map IMMR with a BAT.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-09-16 at 06:42 +0000, Christophe Leroy wrote:
> @@ -145,6 +147,15 @@ void __init mpc83xx_setup_arch(void)
>  	if (ppc_md.progress)
>  		ppc_md.progress("mpc83xx_setup_arch()", 0);
>  
> +	if (!__map_without_bats) {
> +		phys_addr_t immrbase = get_immrbase();
> +		int immrsize = IS_ALIGNED(immrbase, SZ_2M) ? SZ_2M : SZ_1M;
> +		unsigned long va = __fix_to_virt(FIX_IMMR_BASE);

Why __fix_to_virt() and not fix_to_virt()?

-Scott


