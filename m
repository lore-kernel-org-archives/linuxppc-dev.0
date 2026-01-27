Return-Path: <linuxppc-dev+bounces-16311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECD4D2D8F2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 10:40:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0hkN3Zxpz2xjP;
	Tue, 27 Jan 2026 21:40:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.176.79.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769510412;
	cv=none; b=Sb0r2ign6JlCV+eaLi3UYOLaizLj6CIR/m+1ENQSgj2sxJ1tSbB0ofC7GiyILjK0OPxG5xFlx7b0yEJTOgGTfPT+RAOfuhrgQqJNgskeXDAtmpnM1oPEBk5XeyeiVf/Wm1LcrPxgq5VTS+fjgvlQWWGi22u7ehtOdbPbiHRp+pvc5RdX1fn9EcVxp0/RhUEQdudnRYpDqO4YkIuBVBL2FHMPbVYbflRW2TulifjNYAMSoCpD/Y/Deeydy1pOLBEqQbD3pK7c9NqBh5e0GZmPuvLiOGT23QMqT3Y0YPVnehPHRGWWJtL2e2RE/nwyNTdaJjYJrBfgOQRCFIrKTHmEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769510412; c=relaxed/relaxed;
	bh=2x8Oj9fuy3AK0U2FXXIqAjHj+EvD0gdQqCs5gkumAw8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7qvxQbGhlB279poUc8+u1+ZME+en2GoRoJx17UejEoKAoKoooVWpNXOr8eM0XA4iyEhMnhjVMHsRnl6Wv/scUb2ih5BamtWqIAsGW/MlJKeTAt4ou7hvryoVn4chhBrIomLIStmlJKv+aKZSIPgzWLIXx8VOFa6X5d3ZAaDcOBob3yUQJ1PmfeXk9o8KmyYnw/tDPRvt37pg+3INcFdowgGQM+wPeXZbS5KzE3w4E+kE4AUwohUFDAScycyUPdeXT0adEde4coQiE6s618KYN+JXgl7P2R+dsKnnmFNZQaVVHeBQ9JLogB51umLoRdIZFzFVxFSeiAV1bndly1mPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0hkM4JxMz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2026 21:40:11 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0hjb5JWNzJ46BB;
	Tue, 27 Jan 2026 18:39:31 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F1AA40569;
	Tue, 27 Jan 2026 18:40:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 10:39:32 +0000
Date: Tue, 27 Jan 2026 10:39:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <bhelgaas@google.com>, <kbusch@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <terry.bowman@amd.com>, <tianruidong@linux.alibaba.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal
 status
Message-ID: <20260127103931.000058bb@huawei.com>
In-Reply-To: <20260124074557.73961-5-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
	<20260124074557.73961-5-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 24 Jan 2026 15:45:56 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> The DPC driver clears AER fatal status for the port that reported the
> error, but not for the downstream device that deteced the error.  The
> current recovery code only clears non-fatal AER status, leaving fatal
> status bits set in the error device.
> 
> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
> status in the error device, ensuring all AER status bits are properly
> cleared after recovery.
> 
> Fixes: aa344bc8b727 ("PCI/ERR: Clear AER status only when we control AER")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Shouldn't this be first patch in series to make it easier to backport?

Otherwise seems reasonable to me, but others know these flows better than me
so hopefully we'll get some more review.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/pci/pcie/err.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 0780ea09478b..5e463efc3d05 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 */
>  	if (host->native_aer || pcie_ports_native) {
>  		pcie_clear_device_status(dev);
> -		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_raw_clear_status(dev);
>  	}
>  
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);


