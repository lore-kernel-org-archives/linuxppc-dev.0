Return-Path: <linuxppc-dev+bounces-19035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB41061B18
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 22:21:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl5Lb2ymrz2yhP;
	Tue, 31 Mar 2026 09:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774909271;
	cv=none; b=Ut6EXFdEuqkMEAhQ7mec1FnvBDkXfLOJZnUNkD4JdqSYuU1kyqIJVzHDqyEntPyIt1xuH9CNIZtTp8nQ8Y3UQxbAUBuPIs1udwDQynq2h7lW7mCrMbyQfu9+b/ELnfGnmh1nOh4vznFRxwlhOPFKUKv9FfDUjRDYwk6EBThSAP8Jbl2gL0fyfspbSh8ZUz93azqxqAytthKvC9/6DIFY5X1Gy2FmOdOfzDSvF/zDmVeIZNfFb68KeiIxFb2E71G+YYVi1TA+ahxygXgEohfiaYlts5PUG74hLO0+kg9bJVXiTBp+X9ykOVxwH0gexSsLsyMa4MFKBctaZuKR7YMI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774909271; c=relaxed/relaxed;
	bh=lRNMP+IQFFhRH8IqM5dvz46GSzncg6iDWxGwX6faS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D7ClT8bjlAy0MjEkFT5cm7v8jAtZ+3kWPVORfJhSbc+QGw2xgDga8xvvCMuAeZ7PgTxyjlOD43TT/l+unAp06D6ZYgS+JFGVVprFK8Gvf6QEpgd1SfJ90gXWvQROKKca+939iaPnYUnqS8PeB+qHmFkoBm0D4+N5dmIlLBLXTTPOBaMegMkGTBKVrn02kHK731kYs8AASY/+B9rt+rjpqqXaVZfOP4JxVDPFN8WDKWWi7hEbVyenMk2y7DEd2Ym1T3SgB9RBn6hszPcp+W3C4Vs67X8ea1PrjzVd3laZkCtRJafNNk5LFNVRZVlqo5jgNb2PiyKylsIS4iOZa1yg0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LnF8VaGq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LnF8VaGq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl5LS1CGwz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 09:21:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7560160145;
	Mon, 30 Mar 2026 22:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCD6C4CEF7;
	Mon, 30 Mar 2026 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774909261;
	bh=Z7uV56hlfQ9pLrCukHTJCQOvvOCs3RGKHDjgLZ0nYMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LnF8VaGqjHuPXP/rT2Qly9l/SPsw7L73y2AiSFPdX8b9orvH01g8fqf8xupv+eOdK
	 AMpYOm+GTv6yFsP1Q7oKLGvOUmdOEdzwyJvmx9nTFJm4P0eyACaretAH1ECUDvvbft
	 LS9l6fIWNvgOEFmJz5WQGhLRuoNl9kjzKpb0qI3gNwK3yCxZntU1qzK2Yd8EGo1aiH
	 kfkouAiDODU1dudxgpcwtB46IxoY/Ihtbv2ttalPDU+54ZroSyvNuukMqdW6klMLJp
	 72U1bEmTjfJEX83THdj26WG4DAbE+RnfM00+solTR6OriRzQbffOuWi9newTGntH1y
	 EioOjd9o3WcSg==
Date: Mon, 30 Mar 2026 17:20:59 -0500
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
Message-ID: <20260330222059.GA103174@bhelgaas>
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
In-Reply-To: <875b2f99-35b9-4a7c-b47e-bfdc543ef7a0@linux.intel.com>

On Wed, Mar 18, 2026 at 10:48:07AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/18/2026 10:22 AM, Bjorn Helgaas wrote:
> > On Wed, Mar 18, 2026 at 10:04:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> aer_print_error() skips printing if ratelimit_print[i] is not set.
> >> In the native AER path, ratelimit_print is initialized by
> >> add_error_device() during source device discovery, and is set to 1
> >> for fatal errors to bypass rate limiting since fatal errors should
> >> always be logged.
> >>
> >> The DPC/EDR path uses the DPC-capable port as the error source and
> >> reads its AER uncorrectable error status registers directly in
> >> dpc_get_aer_uncorrect_severity(). Since it does not go through
> >> add_error_device(), ratelimit_print[0] is left uninitialized and zero.
> >> As a result, aer_print_error() silently drops all AER error messages
> >> for DPC/EDR triggered events.
> >>
> >> Set ratelimit_print[0] to 1 to bypass rate limiting and always print
> >> AER logs for fatal errors.

To be precise, I think this bypasses rate limiting for all
uncorrectable errors (both fatal and non-fatal) that cause DPC to be
triggered, i.e., uncorrectable errors detected directly by the DPC
port, right?

Uncorrectable errors detected downstream of the DPC port would
generate ERR_NONFATAL or ERR_FATAL messages.  When the DPC port
receives those, it triggers DPC but logs only the "containment event
... received from" message.  That message isn't ratelimited, and this
patch doesn't change that.  I guess there aren't any AER log details
to log in this case because they're in downstream devices that we
can't read while DPC is triggered.

> >> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> >> Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> >> Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > I think this does the same as
> > https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=d4d1ecff2c2d
> > which is already queued for v7.1.
> 
> Thanks for the reference.
> 
> Since errors in the DPC path leads to port containment, I think it
> is best to always log them for reference and debug purposes. So I
> think we don't need to export aer_print_init() from the AER driver
> (which can ratelimit non-fatal DPC error). Instead we can by default
> skip ratelimit for DPC errors by initializing ratelimit_print[0] =
> 1.

I think that makes sense.  With Sizhe's patch, the pci_warn() in
dpc_process_error() is not ratelimited but the aer_print_error() part
is, so we always see the "containment event" warning but may not see
the rest.

I guess we only call dpc_get_aer_uncorrect_severity() for the
PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR case; the NFE, FE, and IN_EXT
cases aren't affected by this patch.

I replaced Sizhe's ratelimit patch on pci/dpc with this one, keeping
the patch that holds a reference while calling dpc_process_error().

> >> ---
> >>  drivers/pci/pcie/dpc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> >> index fc18349614d7..7605ddd9f0ba 100644
> >> --- a/drivers/pci/pcie/dpc.c
> >> +++ b/drivers/pci/pcie/dpc.c
> >> @@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >>  
> >>  	info->dev[0] = dev;
> >>  	info->error_dev_num = 1;
> >> +	info->ratelimit_print[0] = 1;
> >>  
> >>  	return 1;
> >>  }
> >> -- 
> >> 2.43.0
> >>
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

