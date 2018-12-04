Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D39C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:39:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5662081C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="RIEWumvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5662081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438XHq0J2czDqRG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 06:39:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="RIEWumvw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=verge.net.au
 (client-ip=202.4.237.240; helo=kirsty.vergenet.net;
 envelope-from=horms@verge.net.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="RIEWumvw";
 dkim-atps=neutral
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 438XB84GgfzDqKh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 06:34:40 +1100 (AEDT)
Received: from penelope.horms.nl (96-64-203-130-static.hfc.comcastbusiness.net
 [96.64.203.130])
 by kirsty.vergenet.net (Postfix) with ESMTPA id B515B25B7C3;
 Wed,  5 Dec 2018 01:48:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1543934904; bh=9c0VKMlr4G0qlS81aEtR0YhJxfiJsuSOyDVDXo0NivY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RIEWumvwAZ+JJTZR51F0Vel9B+UV1kGQndX0l6Jr85CQh2s2WzeAQaW1XcjVha5BB
 N7cglLcBiKn8Z36+8WhbJbgBpmrZkm/LWI8CsCSLJpXOms4I/uPI8WFJ7WoTkiblqK
 5ISgdIbQh18D+Kb4xm5ehr2ei67xTbZApYFc6kMM=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id BD81FE217E3; Tue,  4 Dec 2018 06:48:22 -0800 (PST)
Date: Tue, 4 Dec 2018 06:48:22 -0800
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181204144822.uqonsto45u7ysdu5@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-27-robh@kernel.org>
Organisation: Horms Solutions BV
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> Convert Renesas SoC bindings to DT schema format using json-schema.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
>  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
>  2 files changed, 218 insertions(+), 151 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml

Hi Rob,

what is this based on? I get a conflict when applying the .txt change
and if I knew the base for this patch it would be rather easy to work
out what has changed.

Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
