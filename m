Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68552C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:57:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6992086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6992086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xYX9420nzF3pZ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:57:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=deltatee.com
 (client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=deltatee.com
X-Greylist: delayed 1348 seconds by postgrey-1.36 at bilbo;
 Sat, 17 Nov 2018 09:55:21 AEDT
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xYV14dq2zF3ny
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:55:21 +1100 (AEDT)
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165]
 helo=[192.168.0.18])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1gNmfI-0008FH-0j; Fri, 16 Nov 2018 15:32:40 -0700
To: Alexander Fomichev <a.fomichev@yadro.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <01D3121E-A92B-4200-9777-5D416B7D0EED@yadro.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <14052813-6af0-d637-3279-493fb3657628@deltatee.com>
Date: Fri, 16 Nov 2018 15:32:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <01D3121E-A92B-4200-9777-5D416B7D0EED@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux@yadro.com, linuxppc-dev@lists.ozlabs.org,
 a.fomichev@yadro.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: Unexpectedly dma_ops is NULL in struct device
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
Cc: "linux@yadro.com" <linux@yadro.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 15/11/18 03:05 AM, Alexander Fomichev wrote:
> This issue makes functions dma_set_mask() and dma_set_coherent_mask() and dma_alloc_coherent() fail in ntb_hw_switchtec. And the driver can't start on powerpc.

I don't know a lot about powerpc in this area, but a quick peek shows
that dma_set_mask() does some platform specific stuff so it would
definitely help if you can let us know more about your hardware.

On one platform I looked at, it seems that dma_set_mask() sets the
dma_ops for the device, so the fact that it is NULL at that point is not
likely the issue. It's probably some platform specific bug that's
causing this.

Logan
