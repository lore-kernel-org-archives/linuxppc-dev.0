Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34768C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 21:23:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB63217FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 21:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB63217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kwFQ1Wt6zDqPC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 07:23:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ftp.linux.org.uk
 (client-ip=195.92.253.2; helo=zeniv.linux.org.uk;
 envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kwCj1hGlzDqNR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 07:21:34 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hGrzT-0007xA-Is; Wed, 17 Apr 2019 21:21:11 +0000
Date: Wed, 17 Apr 2019 22:21:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/26] compat_ioctl: use correct compat_ptr()
 translation in drivers
Message-ID: <20190417212111.GX2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-11-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Shen Jing <jingx.shen@intel.com>, linux-scsi@vger.kernel.org,
 y2038@lists.linaro.org, Frank Haverkamp <haver@linux.ibm.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Jerry Zhang <zhangjerry@google.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
 Vincent Pelletier <plr.vincent@gmail.com>, megaraidlinux.pdl@broadcom.com,
 Felipe Balbi <balbi@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 10:19:48PM +0200, Arnd Bergmann wrote:
> A handful of drivers all have a trivial wrapper around their ioctl
> handler, but don't call the compat_ptr() conversion function at the
> moment. In practice this does not matter, since none of them are used
> on the s390 architecture and for all other architectures, compat_ptr()
> does not do anything, but using the new compat_ptr_ioctl()
> helper makes it more correct in theory, and simplifies the code.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/cxl/flash.c            |  8 +-------
>  drivers/misc/genwqe/card_dev.c      | 23 +----------------------
>  drivers/scsi/megaraid/megaraid_mm.c | 28 +---------------------------
>  drivers/usb/gadget/function/f_fs.c  | 12 +-----------

ACK, provided that all their ioctls are taking pointers (which is
worth mentioning in commit message, assuming it's true)
