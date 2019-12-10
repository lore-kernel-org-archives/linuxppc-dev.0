Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B7C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 00:08:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389022071E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 00:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="LUb2ArSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389022071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47X0lT5q29zDqWK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 11:08:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=walle.cc (client-ip=2a01:4f8:151:8464::1:2;
 helo=ssl.serverraum.org; envelope-from=michael@walle.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=walle.cc header.i=@walle.cc header.b="LUb2ArSK"; 
 dkim-atps=neutral
Received: from ssl.serverraum.org (ssl.serverraum.org
 [IPv6:2a01:4f8:151:8464::1:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47X0jN4kbTzDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 11:06:47 +1100 (AEDT)
Received: from apollo.fritz.box (unknown
 [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 3DB0D2304C;
 Tue, 10 Dec 2019 01:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1575936398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQSB7aaTDeosGfScfkElLltHtjKOhiB3ySxyA9Xk4pM=;
 b=LUb2ArSKFj734DrOu29xTCX5VFhRmcC3RSuas9H1v/tSYzhwBSW1kMjgdhtDLqHIG7dFAn
 PyiSvI3s+28kf1XW5HIv9jMMMn+s9bFSG8hOBc1DXqRC2K75rCMD/hLVHIOTqeSQEOeKhh
 2YmXlEbmCsCeHfJKLa1JCJZEBJLbIxU=
From: Michael Walle <michael@walle.cc>
To: yinbo.zhu@nxp.com
Subject: Re: [PATCH v1 3/4] arm64: dts: ls1028a: fix little-big endian issue
 for dcfg
Date: Tue, 10 Dec 2019 01:06:23 +0100
Message-Id: <20191210000623.22321-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814072649.8237-3-yinbo.zhu@nxp.com>
References: <20190814072649.8237-3-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 3DB0D2304C
X-Spamd-Result: default: False [6.40 / 15.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TAGGED_RCPT(0.00)[dt]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; DKIM_SIGNED(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[21]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM(-0.00)[-0.685]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
 SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, amit.jain_1@nxp.com,
 linux-kernel@vger.kernel.org, rajesh.bhagat@nxp.com, alison.wang@nxp.com,
 alexandru.marginean@nxp.com, catalin.horghidan@nxp.com, Ashish.Kumar@nxp.com,
 xiaobo.xie@nxp.com, claudiu.manoil@nxp.com, robh+dt@kernel.org,
 rajat.srivastava@nxp.com, vabhav.sharma@nxp.com, yangbo.lu@nxp.com,
 jiafei.pan@nxp.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Michael Walle <michael@walle.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> dcfg use little endian that SoC register value will be correct
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch is still missing. Any news?

Tested-by: Michael Walle <michael@walle.cc>

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b0d4f8916ede..5538e8e354b2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -162,7 +162,7 @@
>  		dcfg: syscon@1e00000 {
>  			compatible = "fsl,ls1028a-dcfg", "syscon";
>  			reg = <0x0 0x1e00000 0x0 0x10000>;
> -			big-endian;
> +			little-endian;
>  		};
>  
>  		scfg: syscon@1fc0000 {
> -- 
> 2.17.1
> 
