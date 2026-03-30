Return-Path: <linuxppc-dev+bounces-18995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BF8FF494D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 06:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhWL11cmz2xpt;
	Mon, 30 Mar 2026 17:42:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774852841;
	cv=none; b=AzhjzGYhGLoECthMeZ0duHxBBykBxo8E6AhzQbSsUBiEKSt1WncgGEeZ0cOG6KkEDykvgM3BDfsHRVqIbzttXpkyAO1K6ap3xQ9niKIEor8Z8f0mnQkyoOfnA1yk8YcJBziUWJ51egj3PtQX+tDsJhEl7V9idL5phvpfMY86G/QLYozlgOiuFTVuyktROU39Z4arl6hrtqHByjjbk2WdYYF/466R7uUCiFntNEZO/Gn/K/0i+ifEbX/+G0iPs+RsVGMgkaQ/xhQm6i2uSo65jydH/vhl5k9J22i3mtRsIQoB/408nXudl3b+mNW6cebtTk6nT8IxAFOfkf6cMC6R2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774852841; c=relaxed/relaxed;
	bh=D2ECkB4mOSlmWvMXRknxyN+wK1aHs3Stn2HSImKd9F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNqNEwcoecTB4CuBPacHGgyb3ajmsEdK9oYqJVtO+e/lTbN1I3DDVrvlidRzsaXpKnD8ModpdhS2rmLDoTbQvijhGy4PZ5wpKnk/G6LzIyyyRDugHJGzNkoZJ/Uc+tjChEYpf0st/uKvCqY2uGKvnX8rQNYUnUZwjNwnMkPoqdPg6gHZtUcDbIHLb9RpOmbafCPMGcon4ylAdCZe9jhPVCZ/ttKeaz6ISpdwgVREjcJoAlnGZNXGP/Ru6o6blFHpEH8zyDP9O46SgiBgqda+D30N7tCrh5b1Ee3Owvp+91po43FyroyRz/NvQWvxETwZni6L0r2iyetkfODUow/v2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lCsFoY2/; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lCsFoY2/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 483 seconds by postgrey-1.37 at boromir; Mon, 30 Mar 2026 17:40:39 AEDT
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhTM2kH7z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 17:40:37 +1100 (AEDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fkhHz2S4Yz9twV;
	Mon, 30 Mar 2026 08:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774852351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ECkB4mOSlmWvMXRknxyN+wK1aHs3Stn2HSImKd9F8=;
	b=lCsFoY2/dNW6hlSHuK7yrDdFgJBAKkCBvgX74WSUhyc+5kgVUWl7kBqUbI5TvPHeouHGeT
	XLBkKF9ngRc+6pC0IobwsLhrm2BT7C0JvRzgCFFVvMKDp7aGqOtOxaz3U9NPRtcO4XwLi+
	2ScXEKq9Y2xs99qt+UQBcmpThi3H++Q003MlIkgv0hrIBr5uNwcRa/y2pGGjP90Mk2QpRg
	vml7y3sR91XtyTvUUZuBF/sjhKxtKUB9x4p49JxuXhWFJTZP3GdHxwkFHeVbblSuKT5pJW
	nUP6gGP4v8MnjCTgtbQjqjEPgTN6bX277z9/n+CXPTUde1kS6/mlA1oUYzR4OA==
Message-ID: <e2b13d94-3f0c-4c2f-87b9-209f1ac04f23@mailbox.org>
Date: Mon, 30 Mar 2026 08:32:28 +0200
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
Subject: Re: [PATCH] PCI/AER: Stop ruling out unbound devices as error source
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0d1365e5608b1ab5bd3
X-MBO-RS-META: kz7zti7iux89zom9i7139ty3r94syf3m

On 3/27/26 10:56, Lukas Wunner wrote:
> When searching for the error source, the AER driver rules out devices
> whose enable_cnt is zero.  This was introduced in 2009 by commit
> 28eb27cf0839 ("PCI AER: support invalid error source IDs") without
> providing a rationale.
> 
> Drivers typically call pci_enable_device() on probe, hence the enable_cnt
> check essentially filters out unbound devices.  At the time of the commit,
> drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
> and so any AER-enabled device could be assumed to be bound to a driver.
> The check thus made sense because it allowed skipping config space
> accesses to devices which were known not to be the error source.
> 
> But since 2022, AER is universally enabled on all devices when they are
> enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
> AER is native").
> 
> Errors may very well be reported by unbound devices, e.g. due to link
> instability.  By ruling them out as error source, errors reported by them
> are neither logged nor cleared.  When they do get bound and another error
> occurs, the earlier error is reported together with the new error, which
> may confuse users.  Stop doing so.
> 
> Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>   drivers/pci/pcie/aer.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4299c55..384d026 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1039,8 +1039,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>   	 *      3) There are multiple errors and prior ID comparing fails;
>   	 * We check AER status registers to find possible reporter.
>   	 */
> -	if (atomic_read(&dev->enable_cnt) == 0)
> -		return false;

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan


