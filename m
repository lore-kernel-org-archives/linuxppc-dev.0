Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A8FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 11:18:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA63420844
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 11:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA63420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yjvj3VqhzDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:18:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=collabora.com
 (client-ip=2a00:1098:0:82:1000:25:2eeb:e3e3; helo=bhuna.collabora.co.uk;
 envelope-from=boris.brezillon@collabora.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yjsj2NMyzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 22:16:41 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9CC4A27D94A;
 Mon, 11 Feb 2019 11:16:31 +0000 (GMT)
Date: Mon, 11 Feb 2019 12:16:28 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] drivers/mtd: Use mtd->name when registering
 nvmem device
Message-ID: <20190211121628.30c22370@collabora.com>
In-Reply-To: <2f3cae2b-32d2-0651-29ef-2359221de4ef@linux.ibm.com>
References: <20190208151419.1800-1-aneesh.kumar@linux.ibm.com>
 <20190210135552.65f532bb@collabora.com>
 <2f3cae2b-32d2-0651-29ef-2359221de4ef@linux.ibm.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev@lists.ozlabs.org, Alban Bedel <albeu@free.fr>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Feb 2019 16:26:38 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> On 2/10/19 6:25 PM, Boris Brezillon wrote:
> > Hello Aneesh,
> > 
> > On Fri,  8 Feb 2019 20:44:18 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >   
> >> With this patch, we use the mtd->name instead of concatenating the name with '0'
> >>
> >> Fixes: c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>  
> > 
> > You forgot to Cc the MTD ML and maintainers. Can you please send a new
> > version?
> >   
> 
> linux-mtd list is on CC: Is that not sufficient?

Not in your original email, I added it in my reply.
