Return-Path: <linuxppc-dev+bounces-16539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0914E8305D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:06:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4x0H0MJwz30GV;
	Tue, 03 Feb 2026 19:06:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::112"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770106014;
	cv=none; b=DF1U2yVGx7jmVFOuTEhpzF5dk+YHMSIObZ+oq5vxgV39p06F5n8hwZIXrsQLU3UFWX8vpDScnQ24ZkSUz0thNXcoRsFUheJu7c3eDL4RALajKnwGaCWlS+jUFccbgAuKMqAwuPVyAaaSJLEOvmPehXrw0MPl2gZta+w/FsE+2ZLWlZMeAepccGW/TSyN6YZ/SbmfC1xs4lqtfcoGxOaZpluhxNtulIPd9ZEiDXh1X0P5EGMIJueAZP3sl5iHzFv5pjJa4iKgLUEafuYXqapJRndsJVn++4NZjM582Jcdn3WvQTaV03B8tTww2TDJ1CJDbUlyQIk83Debo/GH/UYxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770106014; c=relaxed/relaxed;
	bh=2OHG+FXaDqCXk3XQ6cLquWAdlilOVrTvjzs9Zn1AVvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE2B1op2LdouIqx+Ymwr2YVSo3hVxRpLTZMg+kL7x0TMxh1l1oBsBPni6PpCfW6yK8fag5NekI+1LxkwZD+DlCr28j4HULb7iCJd6npAPUW3gLqLVN0KvTho+XJuzbmTyvPYDZdTq3I65momoLEF0AIwXgvaCyCKhBVOM2CKgRV/PAUiPuVwTfYx9A+0N9rM/MuXq4ktnQScYcYRtrpgpoYT0vDegNDRLl3CHa/08SMhwVSZ994OBYev+KURCZCAy8QLFui/oe7cIKkpnEGRxEk0mwpoBQ3WGwjnvVX+bUtrB1GbriYjL/d87wGTmm95+oU7ZARepiieWnrd90cKhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4x0G0DDDz30FF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 19:06:53 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D4CC32C003E4;
	Tue,  3 Feb 2026 09:06:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 866D310724; Tue,  3 Feb 2026 09:06:50 +0100 (CET)
Date: Tue, 3 Feb 2026 09:06:50 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
Message-ID: <aYGsmgyVwvbj83YI@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124074557.73961-5-xueshuai@linux.alibaba.com>

On Sat, Jan 24, 2026 at 03:45:56PM +0800, Shuai Xue wrote:
> The DPC driver clears AER fatal status for the port that reported the
> error, but not for the downstream device that deteced the error.  The
> current recovery code only clears non-fatal AER status, leaving fatal
> status bits set in the error device.

That's not quite accurate:

The error device has undergone a Hot Reset as a result of the Link Down
event.  To be able to use it again, pci_restore_state() is invoked by
the driver's ->slot_reset() callback.  And pci_restore_state() does
clear fatal status bits.

pci_restore_state()
  pci_aer_clear_status()
    pci_aer_raw_clear_status()

> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
> status in the error device, ensuring all AER status bits are properly
> cleared after recovery.

Well, pci_restore_state() already clears all AER status bits so why
is this patch necessary?

> +++ b/drivers/pci/pcie/err.c
> @@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 */
>  	if (host->native_aer || pcie_ports_native) {
>  		pcie_clear_device_status(dev);
> -		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_raw_clear_status(dev);
>  	}

This code path is for the case when pcie_do_recovery() is called
with state=pci_channel_io_normal, i.e. in the nonfatal case.
That's why only the nonfatal bits need to be cleared here.

In the fatal case clearing of the error bits is done by
pci_restore_state().

I understand that this is subtle and should probably be changed
to improve clarity, but this patch doesn't look like a step
in that direction.

Thanks,

Lukas

