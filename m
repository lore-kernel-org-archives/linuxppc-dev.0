Return-Path: <linuxppc-dev+bounces-16523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB91E7DEEB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Feb 2026 14:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4Sxb549Tz309y;
	Tue, 03 Feb 2026 01:02:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::112"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770040979;
	cv=none; b=NL4X8G+ZpawlVBPe9ebDvEX/1uxAyxCo4eOV3bQbFuoKBE+KU5cQNgKtEVYa7c1YrGlXjWjJE7wETG887In1DMf3q02T57HyruEOn4QRFquz1Cfm63MHNhmOwUjIfhHqykKAbcXcLWHONW3dTWjsDb71lx41ZrsvUtp1xtfMZaLIkWnbApALxX+lTHwcNrp0ZxwtMZHm5vjvJPdjZMuydX/5OYoMsmJ1K4jVY91ciHw3P0A4lD84o0LNaSCL1OJFPPjokkjB9E48jdE3gDZVpLZ4zju6gcvlf2HZ2fkmV6ufJJHriH9MNyrlm1VG7121PfyvD1a7ebfz4DboCI0juw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770040979; c=relaxed/relaxed;
	bh=mv+lETVu2FVLFLVXMHQzgkz+no/Al/EZaXqqak1GigU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH6TXk+JIuo8mW/45CCbrItBFGtw3HV5lYRYfexxdkv1r3P4ns/E13CedlbGw1hhcqapj/xkko7ZP5zqZmykhRatt52hpBN+5psku+iwtCSyKktmtJIyHLRM+Vf53sWd8UI+KtdsJ2hdGb/u1lYTNQeR8molHyeen6LSPwxcNQJpgALhwRrYGfMn/5w4h4iwVLxXfxejKt+8Hnglx5+02JYDOELtlc63VmUpHUIo2iaEM5nM8A3oUcvVE+W2JjB18kdFMzHs2pVhzlQFvqm6DkQw6fqTX/pHIb8SQLW3n3UyQaUgf0xlqW0rJXDua/fBF/Flmwyk+RKwyl65nc9ISA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 12026 seconds by postgrey-1.37 at boromir; Tue, 03 Feb 2026 01:02:58 AEDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4SxZ4HSRz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 01:02:58 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9744A2C01637;
	Mon,  2 Feb 2026 15:02:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5DBA328CB4; Mon,  2 Feb 2026 15:02:54 +0100 (CET)
Date: Mon, 2 Feb 2026 15:02:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
Message-ID: <aYCujqZIvxElSsOE@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
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
In-Reply-To: <20260124074557.73961-3-xueshuai@linux.alibaba.com>

On Sat, Jan 24, 2026 at 03:45:54PM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pcie/dpc.c
> @@ -372,10 +388,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  		return IRQ_HANDLED;
>  	}
>  
> -	dpc_process_error(err_port);
> +	err_dev = dpc_process_error(err_port);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
> +	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
> +	pci_dev_put(err_dev);
>  
>  	return IRQ_HANDLED;
>  }

You're assuming that the parent of the Requester is always identical
to the containing Downstream Port.  But that's not necessarily the case:

E.g., imagine a DPC-capable Root Port with a PCIe switch below
whose Downstream Ports are not DPC-capable.  Let's say an Endpoint
beneath the PCIe switch sends ERR_FATAL upstream.  AFAICS, your patch
will cause pcie_do_recovery() to invoke dpc_reset_link() with the
Downstream Port of the PCIe switch as argument.  That function will
then happily use pdev->dpc_cap even though it's 0.

A possible solution may be to amend dpc_reset_link() to walk upwards,
starting at pdev, and search for a pci_dev whose pdev->dpc_cap is
non-zero.  That should be the containing DPC-capable port.

I don't really like the err_dev and err_port terminology invented here.
We generally use spec terms to make it easy to connect the code to the
spec.  The spec uses the term "Downstream Port" to denote the containing
Downstream Port, so a name such as "dport" may be better than "err_port".

Similarly, the spec uses "Requester" or "Source" for the reporting agent,
so "req", "requester", "src" or "source" may all be better names than
"err_dev".

Thanks,

Lukas

