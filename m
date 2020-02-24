Return-Path: <SRS0=vDV2=4M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A70FC35679
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6472192A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Ta29z0+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6472192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Qwwg6xrwzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 19:59:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=walle.cc (client-ip=176.9.125.105; helo=ssl.serverraum.org;
 envelope-from=michael@walle.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=walle.cc header.i=@walle.cc header.a=rsa-sha256
 header.s=mail2016061301 header.b=Ta29z0+G; 
 dkim-atps=neutral
X-Greylist: delayed 2532 seconds by postgrey-1.36 at bilbo;
 Mon, 24 Feb 2020 19:53:38 AEDT
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48QwpB4MlYzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2020 19:53:38 +1100 (AEDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id B794923059;
 Mon, 24 Feb 2020 09:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1582534414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGHRW3l5rCA287QCNNdGXSdyqq9QPHkLJ+IpgLfP+T0=;
 b=Ta29z0+G9GOKfOY5pEnNbXDdYrHts1jhuNXUK+UU5pGYZYKRousrquA57hOniFUq4neRJv
 CWF0Ds23phwNWukPNrMpGKwE0OE5mmUIhqM0t2PymJhANWOk8Jh/P/Ff1ecxm+VF0nYmBQ
 +xZno6FiY9P/UzW4OQIkZlENAnPp3wU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Feb 2020 09:53:34 +0100
From: Michael Walle <michael@walle.cc>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v6 2/3] arm64: dts: ls1028a: Add PCIe controller DT nodes
In-Reply-To: <20200224084307.GD27688@dragon>
References: <20190902034319.14026-2-xiaowei.bao@nxp.com>
 <20200224081105.13878-1-michael@walle.cc> <20200224084307.GD27688@dragon>
Message-ID: <a3aeabddc82ca86e3dca9c26081a0077@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: B794923059
X-Spamd-Result: default: False [1.40 / 15.00]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TAGGED_RCPT(0.00)[dt]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 NEURAL_HAM(-0.00)[-0.572]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 xiaowei.bao@nxp.com, roy.zang@nxp.com, linux-pci@vger.kernel.org,
 Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 minghuan.Lian@nxp.com, robh+dt@kernel.org, mingkai.hu@nxp.com,
 bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shawn, all,

Am 2020-02-24 09:43, schrieb Shawn Guo:
> On Mon, Feb 24, 2020 at 09:11:05AM +0100, Michael Walle wrote:
>> Hi Xiaowei, Hi Shawn,
>> 
>> > LS1028a implements 2 PCIe 3.0 controllers.
>> 
>> Patch 1/3 and 3/3 are in Linus' tree but nobody seems to care about 
>> this patch
>> anymore :(
>> 
>> This doesn't work well with the IOMMU, because the iommu-map property 
>> is
>> missing. The bootloader needs the &smmu phandle to fixup the entry. 
>> See
>> below.
>> 
>> Shawn, will you add this patch to your tree once its fixed, 
>> considering it
>> just adds the device tree node for the LS1028A?
> 
> The patch/thread is a bit aged.  You may want to send an updated patch
> for discussion.

So should I just pick up the patch add my two fixes and send it again? 
What about
the Signed-off-by tags? Leave them? Replace them? Add mine?

-michael
