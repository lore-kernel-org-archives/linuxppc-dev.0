Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999D4C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 02:45:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D5B20866
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 02:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bPTE89OO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D5B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Kx2b6pJmzDqpG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 13:45:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="bPTE89OO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="bPTE89OO"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Kwzm1YqqzDqTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 13:43:16 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 958561AA8;
 Wed, 19 Dec 2018 21:43:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 19 Dec 2018 21:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=fz67nhB9oYkFflD70FeiKm7+Q4D9VNTd48+oXNbC6
 lg=; b=bPTE89OOGMDtMPDcWthccKm0dlt8I7VQDkymlcZw4/MsVATH/zHZJxEt8
 VTsxKx8bq3dphSZEcMPiidMdzZdh2UTqUbNPocZP6Ctcg+xCO/rYKcuWJcqPkwwn
 vofFC4ko7WAgAp44EKE5QNs0irl89JhmfNqHQF4b5QDwfV/vcY8CrhkAqHIGib6h
 3V8yHYNeyho2yKP1BCIYo5fi7ESNpJSq52XOxqS13Y0H5INUaaPuDzA0v/ShDIFH
 W9g7SYwaepGz3biVpQ2KujMm5SEzidb+iZZPztN7G8cVMVUfeNXxYZ2Cue18M/ZW
 dYJm4pe4vmUwS5oejSxVUATGIp6vA==
X-ME-Sender: <xms:vAEbXKtRYX-St6rj1oBXfi7jNC8_qKcqTRivFY1SzUJhdW1-naJV1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejvddggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
 tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftd
 dmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhu
 shhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukf
 hppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgt
 uhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vAEbXF_d_zDmTLuON31bx62pGB36ayLNsDpLio6scwBUSPuH1pzrcQ>
 <xmx:vAEbXI88ZZLoicuYK20uoSSnbCadmbw5K6tOhFJsCIJLbtVTrOMjCg>
 <xmx:vAEbXPPXt11VpKgUki0DmE1BedDDBAyCMgtVsmNIgogjnjaKD2lwVQ>
 <xmx:wAEbXOWsgb5CICWY2SEvkhxodwh-HkAve7rwsxgKrBRFAowI3IBzjw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 95138100E5;
 Wed, 19 Dec 2018 21:43:05 -0500 (EST)
Message-ID: <f5ffaacbc379e534f886dd0eeb4298b9d21537c1.camel@russell.cc>
Subject: Re: [PATCH -next] powerpc/eeh: Fix debugfs_simple_attr.cocci warnings
From: Russell Currey <ruscur@russell.cc>
To: YueHaibing <yuehaibing@huawei.com>, Sam Bobroff
 <sbobroff@linux.ibm.com>,  Oliver O'Halloran <oohall@gmail.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 20 Dec 2018 13:44:05 +1100
In-Reply-To: <1545273771-131851-1-git-send-email-yuehaibing@huawei.com>
References: <1545273771-131851-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-12-20 at 02:42 +0000, YueHaibing wrote:
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> for debugfs files.
> 
> Semantic patch information:
> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> imposes some significant overhead as compared to
> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> 
> Generated by:
> scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Russell Currey <ruscur@russell.cc>

