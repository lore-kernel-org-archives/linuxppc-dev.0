Return-Path: <SRS0=MZVM=KK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC4AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 05:44:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612CF61206
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 05:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612CF61206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FhvTh6q4Lz3bxt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 15:44:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.97; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Received: from smtprelay.hostedemail.com (smtprelay0097.hostedemail.com
 [216.40.44.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FhvTF1KQQz2xff
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 May 2021 15:43:43 +1000 (AEST)
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 38C29182CED28;
 Sat, 15 May 2021 05:43:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf15.hostedemail.com (Postfix) with ESMTPA id 737E2C4171; 
 Sat, 15 May 2021 05:43:36 +0000 (UTC)
Message-ID: <985813cafbbe58cd899737ee49b44798210a69f6.camel@perches.com>
Subject: Re: [PATCH v2 01/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
From: Joe Perches <joe@perches.com>
To: Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Date: Fri, 14 May 2021 22:43:35 -0700
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: sktyye3trus7rah3tcedpkwhqfm6xq1a
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 737E2C4171
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19iS+XLPvw0DQLZl4lLIJgMwROnMeU+SbY=
X-HE-Tag: 1621057416-840459
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Vidya Sagar <vidyas@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2021-05-15 at 05:24 +0000, Krzysztof Wilczyński wrote:
> The sysfs_emit() and sysfs_emit_at() functions were introduced to make
> it less ambiguous which function is preferred when writing to the output
> buffer in a device attribute's "show" callback [1].
> 
> Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
> and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
> latter is aware of the PAGE_SIZE buffer and correctly returns the number
> of bytes written into the buffer.
[]
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
[]
> @@ -6439,7 +6439,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
>  
> 
>  	spin_lock(&resource_alignment_lock);
>  	if (resource_alignment_param)
> -		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
> +		count = sysfs_emit(buf, "%s", resource_alignment_param);
>  	spin_unlock(&resource_alignment_lock);

Ideally, the additional newline check below this would use sysfs_emit_at

drivers/pci/pci.c-      /*
drivers/pci/pci.c:       * When set by the command line, resource_alignment_param will not
drivers/pci/pci.c-       * have a trailing line feed, which is ugly. So conditionally add
drivers/pci/pci.c-       * it here.
drivers/pci/pci.c-       */
drivers/pci/pci.c-      if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
drivers/pci/pci.c-              buf[count - 1] = '\n';
drivers/pci/pci.c-              buf[count++] = 0;
drivers/pci/pci.c-      }
drivers/pci/pci.c-
drivers/pci/pci.c-      return count;
	

