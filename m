Return-Path: <linuxppc-dev+bounces-18394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57D610775F8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 17:22:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbbH43f62z2ykX;
	Thu, 19 Mar 2026 04:22:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773854528;
	cv=none; b=V5ndpkhA5vWNoN/bLbh0F/u4kXG3y9Tb9g9eXdx3DJeHbNZSBBJu5UfVprq2AJDv9RRzC1yezTyAfovRtbg8oHJYRPkQJY64/i10w4FpVvJSsNQ3YpcNyIDcOF3ZoyGLNhN51ddSUpmN7LgGQTqs5r7eqMKi/BXOmGwCCjJWHW87YGhRe9HQkXk+Km1Ewr6Ok9rHAG9DNxN4xh3WFeriJ46W08QFTbfO4wn5hOiOrDv6EinKiSk9N5potHgU8kveKZdyoHjW0Wg0CkLtJvXXZ21SzuEGzUeEvdU5QhBp7DVgfejlDKwHsPfFKvy5/0LQIipapL4gk1Bz0Noz5DKmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773854528; c=relaxed/relaxed;
	bh=AJyREjtgCw6461uj+yUH0Yr/yT+t0sqn4NCNwtgjPjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y8JTgSDjINurF6KQZufUykXXTmxa2bzsvVlg+ZMY2E4KFS4bL3mhC+YiJbwMWAdOoD7Xzl/Qm/1HzC3hEbNRNpaHaXfUzIju8fSM8oRDK6b6BQeOtdYxfCx/h+JKtN6TG7SUBPqR6Ty7gLR0Aly0UbMl+iD4iP3rlZpLI/2qYM+yM/19W4XJ2ENkTeeqjTHFieamSn/bzPlMmFk8avAOT7T1s7JHMDV0X5j/21+dMDWk2+YC5TsHBExZo0mS3j0PsaakDX6je30hewTe8OLyX/lxoLvd3AbtNJlxms0fB4C+M9uqn2Hrz3Gwx2naFi2WmYU6s0YM0qJG5MdWsNUqHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=blvhD7Bq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=blvhD7Bq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbbH364gZz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 04:22:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1FDC560132;
	Wed, 18 Mar 2026 17:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB944C19421;
	Wed, 18 Mar 2026 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854524;
	bh=1OgHpLEuNBi1/jSYIEf8g9ynIW7/JAsqHQFct/Wozi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=blvhD7BqkUeHkikxU+oCyjYifKIxbD6EbW3EJmowgbboNYWrRUGNGeFQEIun+eJi3
	 lR2vhQUBEgPwOQbMBfK8dh9E8vxcTqJzN0oTVEjLwMQbXQhPhTj27jdGw4b/vljs5c
	 31mjjzTrUi8syI1ikynyLcmzFTthlx2c3PbIm/pr5vUHx6sanDRCk81qcetC0NMfYW
	 mBwW9AQ7mtlf30kT/zXLgN8NAce3/ya8aLBBQFmwAkOyz+BjPknC9efMDwk+J1Bt50
	 tr52pbfT2HZ2/M+exhel6tnbSLqlJztTgz1iFh1Lb5AsA8nh3E76MBycpvwY/YsAQO
	 RGYqF5YRbLzjA==
Date: Wed, 18 Mar 2026 12:22:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sizhe Liu <liusizhe5@huawei.com>
Subject: Re: [PATCH v1] PCI/DPC: Fix AER error logging for DPC/EDR triggered
 events
Message-ID: <20260318172203.GA51847@bhelgaas>
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
In-Reply-To: <20260318170449.2733581-1-sathyanarayanan.kuppuswamy@linux.intel.com>

[+cc Sizhe]

On Wed, Mar 18, 2026 at 10:04:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
> aer_print_error() skips printing if ratelimit_print[i] is not set.
> In the native AER path, ratelimit_print is initialized by
> add_error_device() during source device discovery, and is set to 1
> for fatal errors to bypass rate limiting since fatal errors should
> always be logged.
> 
> The DPC/EDR path uses the DPC-capable port as the error source and
> reads its AER uncorrectable error status registers directly in
> dpc_get_aer_uncorrect_severity(). Since it does not go through
> add_error_device(), ratelimit_print[0] is left uninitialized and zero.
> As a result, aer_print_error() silently drops all AER error messages
> for DPC/EDR triggered events.
> 
> Set ratelimit_print[0] to 1 to bypass rate limiting and always print
> AER logs for fatal errors.
> 
> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

I think this does the same as
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=d4d1ecff2c2d
which is already queued for v7.1.

> ---
>  drivers/pci/pcie/dpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..7605ddd9f0ba 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  
>  	info->dev[0] = dev;
>  	info->error_dev_num = 1;
> +	info->ratelimit_print[0] = 1;
>  
>  	return 1;
>  }
> -- 
> 2.43.0
> 

