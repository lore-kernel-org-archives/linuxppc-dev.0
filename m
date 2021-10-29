Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2166FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 15:10:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EE6611C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 15:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1EE6611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgm8S71bqz3c9V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Oct 2021 02:10:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=FV3owrfn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=FV3owrfn; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgm7m2b1dz2ymS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Oct 2021 02:10:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=4YN8DKc/50CxJ1/q46BvmC8TnMeGci9z1miBkCyhNpU=; b=FV3owrfnS0CfUbnuX9OXOFFqJX
 NmdXz/DOByNNeprGTa6FC6aCLvgPTkCUorqFQSUa+L8LcKCSn304KpqFF6IrnnLOyTrD+evEDLQNK
 0ozka9hMYFCBdJJi2TW7fTAaOcYdSEWqAhbmHvvJybh5ws+8VX5lV7FbxZ9oHcRz52mpd+MYzcmQY
 q9LHMBOH2BBDn2Qqjlgaf7ipi7kV+dlrv7WbmGGZKTuh7jReVQZfRggusg5qsRfyB1SLDw0PUdCl6
 sj1lMU6/nR3d9jQhIR7slT5in4a2hvAfpyIJmBmlT5iK/ycRhNn1PBughoXKBA+URp0XO1NddfCzi
 QwHixX/g==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgTW9-00D6lg-CO; Fri, 29 Oct 2021 15:10:05 +0000
Subject: Re: [PATCH 11/13] ps3vram: add error handling support for add_disk()
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 jim@jtan.com, minchan@kernel.org, ngupta@vflare.org,
 senozhatsky@chromium.org, richard@nod.at, miquel.raynal@bootlin.com,
 vigneshr@ti.com, dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-12-mcgrof@kernel.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <2b782451-f931-27bb-1114-2aba450c5879@infradead.org>
Date: Fri, 29 Oct 2021 08:09:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015235219.2191207-12-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Luis,

On 10/15/21 4:52 PM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.

I didn't yet test this ps3vram related change, but based
on the ps3disk testing I think this change will be OK.

Acked-by: Geoff Levand <geoff@infradead.org>
