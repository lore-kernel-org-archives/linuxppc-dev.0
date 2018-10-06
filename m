Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB108C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 07:05:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A879208E7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 07:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBNNzcf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A879208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RyLK2B8mzF3d1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 17:04:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NBNNzcf+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=bjorn.andersson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="NBNNzcf+"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RyHl0tJqzF385
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 17:02:38 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id p24-v6so6056317pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Oct 2018 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yxuvBu+Fwt+lK+efudO8FJo6vyjQWM3N8/U9NFmxvos=;
 b=NBNNzcf+XT2vcflggfwGxwcUwEbcV+4BoJavPuiIXo92PniznQvrxXkzH2mi7Ok5sm
 ZsU/OCdsuCkHOwhUI/VGSbQ5R35qXCcRmM32NLxVnGTZx970MtD3IeYlUY0UNDQwPZVq
 vsLh01rG+tMjRWRLgKa/cFyR39gz878jTGLoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yxuvBu+Fwt+lK+efudO8FJo6vyjQWM3N8/U9NFmxvos=;
 b=IalTerRsm0KjDojoSwi3wnlWeLmMhqepBGiLkPfw58CP/2Bhd1dNL4oPRJ1VIW1/JR
 R30k5UZ6uKZIIeZHpj3uBZ0/10YASN/PcbIq1hI2/0+Ol9lWfsouJHE+t0PLS814zK4U
 +dcMWLB0i9w3wlOfhIr6bVomkJ/OCnS71Tzv2LX0EPh74G+I5F+5Vj/5ccf/FAheupOa
 KuEFSNp6Rys73LqiTpHI+KxHcqCkBeOPQvTxtZPeZW5GRG6IcBrZP24nfjyRWHQZU9+V
 HCSItg7xUjRPRnNjT/aUG8X2uCieIMxr3bdN3C1Q1Sn+2YP/2hZt60dlh+l88Bs0L7GN
 SDNg==
X-Gm-Message-State: ABuFfoi4yC0bu+Z3DCdWaEb0Ttkrm2RCIVgAXWcjj8+UtuVQTX+mFGwD
 k6hDvyxuVU1/Xq1SkoossFsVhQ==
X-Google-Smtp-Source: ACcGV60dGSKOxXNr63g3bSD2U1+VM5YZuF2x7KTrzF1isi7pBVPzBtAzQZonbp4SGaT2JDqwz8iFZw==
X-Received: by 2002:a62:1407:: with SMTP id 7-v6mr15150079pfu.28.1538809356673; 
 Sat, 06 Oct 2018 00:02:36 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id g123-v6sm749112pfc.67.2018.10.06.00.02.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 06 Oct 2018 00:02:35 -0700 (PDT)
Date: Sat, 6 Oct 2018 00:05:21 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20181006070521.GM12063@builder>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
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
Cc: linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-nvme@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 sparclinux@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-rdma@vger.kernel.org, qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 ceph-devel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 12 Sep 08:08 PDT 2018, Arnd Bergmann wrote:

[..]
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a76b963a7e50..02aefb2b2d47 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -285,7 +285,7 @@ static const struct file_operations rpmsg_eptdev_fops = {
>  	.write = rpmsg_eptdev_write,
>  	.poll = rpmsg_eptdev_poll,
>  	.unlocked_ioctl = rpmsg_eptdev_ioctl,
> -	.compat_ioctl = rpmsg_eptdev_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  
>  static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> @@ -446,7 +446,7 @@ static const struct file_operations rpmsg_ctrldev_fops = {
>  	.open = rpmsg_ctrldev_open,
>  	.release = rpmsg_ctrldev_release,
>  	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
> -	.compat_ioctl = rpmsg_ctrldev_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  

For rpmsg part

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
