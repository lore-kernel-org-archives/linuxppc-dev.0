Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB7C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 05:04:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5396A64DC4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 05:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5396A64DC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DR7gS74NSzDrgM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 16:04:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.161; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
X-Greylist: delayed 336 seconds by postgrey-1.36 at bilbo;
 Thu, 28 Jan 2021 16:03:03 AEDT
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DR7dg571LzDrBl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 16:03:02 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 924D21804DF77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 04:57:30 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 54824181D341E;
 Thu, 28 Jan 2021 04:57:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fan51_55072612759c
X-Filterd-Recvd-Size: 2289
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf20.hostedemail.com (Postfix) with ESMTPA;
 Thu, 28 Jan 2021 04:57:17 +0000 (UTC)
Message-ID: <d6ddcab2f9db25f49e89f37e1cb4f59ad42651e6.camel@perches.com>
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
From: Joe Perches <joe@perches.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, Will Deacon
 <will@kernel.org>
Date: Wed, 27 Jan 2021 20:57:16 -0800
In-Reply-To: <871re5soof.fsf@manicouagan.localdomain>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
 <20210127184319.GA676@willie-the-truck>
 <871re5soof.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
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
Cc: mark.rutland@arm.com, bhsharma@redhat.com, tao.li@vivo.com,
 zohar@linux.ibm.com, paulus@samba.org, vincenzo.frascino@arm.com,
 frowand.list@gmail.com, sashal@kernel.org, robh@kernel.org,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, masahiroy@kernel.org,
 jmorris@namei.org, takahiro.akashi@linaro.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 serge@hallyn.com, devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org, allison@lohutok.net,
 christophe.leroy@c-s.fr, mbrugger@suse.com, balajib@linux.microsoft.com,
 dmitry.kasatkin@gmail.com, linux-kernel@vger.kernel.org, james.morse@arm.com,
 gregkh@linuxfoundation.org, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2021-01-28 at 00:52 -0300, Thiago Jung Bauermann wrote:
> The problem is that this patch implements only part of the suggestion,
> which isn't useful in itself. So the patch series should either drop
> this patch or consolidate the FDT allocation between the arches.
> 
> I just tested on powernv and pseries platforms and powerpc can use
> vmalloc for the FDT buffer.

Perhaps more sensible to use kvmalloc/kvfree.



