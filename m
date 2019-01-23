Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF15EC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 21:37:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3BD21872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 21:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3BD21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lJY86V2GzDqHq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 08:37:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=rowland.harvard.edu
 (client-ip=192.131.102.54; helo=iolanthe.rowland.org;
 envelope-from=stern+5c437d56@rowland.harvard.edu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rowland.harvard.edu
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by lists.ozlabs.org (Postfix) with SMTP id 43lJWL2m1yzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 08:36:12 +1100 (AEDT)
Received: (qmail 2495 invoked by uid 2102); 23 Jan 2019 11:09:30 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 23 Jan 2019 11:09:30 -0500
Date: Wed, 23 Jan 2019 11:09:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] usb: host: drop pointless static qualifier
In-Reply-To: <20190123083758.8412-1-yuehaibing@huawei.com>
Message-ID: <Pine.LNX.4.44L0.1901231107030.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: geoff@infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 23 Jan 2019, YueHaibing wrote:

> There is no need to have the 'dummy_mask' variable static since new
> value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/usb/host/ehci-ps3.c | 2 +-
>  drivers/usb/host/ohci-ps3.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
> index 454d8c6..91cee02 100644
> --- a/drivers/usb/host/ehci-ps3.c
> +++ b/drivers/usb/host/ehci-ps3.c
> @@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>  	int result;
>  	struct usb_hcd *hcd;
>  	unsigned int virq;
> -	static u64 dummy_mask;
> +	u64 dummy_mask;
>  
>  	if (usb_disabled()) {
>  		result = -ENODEV;
> diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
> index 395f9d3..a1c1bdf 100644
> --- a/drivers/usb/host/ohci-ps3.c
> +++ b/drivers/usb/host/ohci-ps3.c
> @@ -69,7 +69,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
>  	int result;
>  	struct usb_hcd *hcd;
>  	unsigned int virq;
> -	static u64 dummy_mask;
> +	u64 dummy_mask;
>  
>  	if (usb_disabled()) {
>  		result = -ENODEV;

No.  You need to read the code and understand how a variable is used
before you decide to modify it.

In this case, a suitable approach would be to change the declaration 
so that it says:

	status u64 dummy_mask = DMA_BIT_MASK(32);

and remove the line that does the assignment dynamically.

Alan Stern

